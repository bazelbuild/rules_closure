/*
 * Copyright 2022 The Closure Rules Authors. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.bazel.rules.closure.testing;

import com.google.common.collect.ImmutableList;
import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.FluentWait;

/** The test driver that triggers test running on the browser and collects test results. */
public class TestDriver {
  private static final Logger logger = Logger.getLogger(TestDriver.class.getName());
  private static final long POLL_INTERVAL = 100;
  private static final long TEST_TIMEOUT = 300;

  private final WebDriver driver;
  private final String htmlURL;

  public TestDriver(
      String htmlURL,
      String browserType,
      String browserBinary,
      String webdriverBinary,
      ImmutableList<String> extraBrowserArgs)
      throws IOException {
    this.driver = createWebDriver(browserType, browserBinary, webdriverBinary, extraBrowserArgs);
    this.htmlURL = htmlURL;
  }

  private static WebDriver createWebDriver(
      String browserType,
      String browserBinary,
      String webdriverBinary,
      ImmutableList<String> extraBrowserArgs)
      throws IOException {
    switch (browserType) {
      case "chrome":
        ChromeDriverService service =
            new ChromeDriverService.Builder()
                .usingDriverExecutable(new File(webdriverBinary).getCanonicalFile())
                .usingAnyFreePort()
                .build();
        ChromeOptions options = new ChromeOptions();
        options.setBinary(new File(browserBinary).getCanonicalFile());
        options.addArguments(
            "--headless", "--no-sandbox", "--disable-dev-shm-usage", "--disable-gpu");
        options.addArguments(extraBrowserArgs);
        return new ChromeDriver(service, options);
      default:
        throw new IllegalArgumentException("Unsupported browser type: " + browserType);
    }
  }

  public boolean run() {
    driver.manage().timeouts().scriptTimeout(Duration.ofSeconds(TEST_TIMEOUT));
    logger.info("WebDriver is running on: " + this.htmlURL);
    driver.get(this.htmlURL);

    try {
      new FluentWait<>((JavascriptExecutor) driver)
          .pollingEvery(Duration.ofMillis(POLL_INTERVAL))
          .withTimeout(Duration.ofSeconds(TEST_TIMEOUT))
          .until(executor
              -> (boolean) executor.executeScript("return window.top.G_testRunner.isFinished()"));
    } catch (TimeoutException e) {
      logger.log(Level.SEVERE, String.format("Test timeout after %s seconds", TEST_TIMEOUT));
      return false;
    }

    String testReport =
        ((JavascriptExecutor) driver)
            .executeScript("return window.top.G_testRunner.getReport();")
            .toString();
    logger.info(testReport);

    boolean allTestsPassed =
        (boolean)
            ((JavascriptExecutor) driver)
                .executeScript("return window.top.G_testRunner.isSuccess();");

    return allTestsPassed;
  }

  public void quit() {
    driver.quit();
  }
}
