workspace(name = "io_bazel_rules_closure")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//closure/private:java_import_external.bzl", "java_import_external")
load("//closure:repositories.bzl", "closure_repositories")

closure_repositories()

http_archive(
    name = "zlib",
    build_file = "//:third_party/zlib.BUILD",
    sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
    strip_prefix = "zlib-1.2.11",
    urls = ["https://zlib.net/zlib-1.2.11.tar.gz"],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "bbccf674aa441c266df9894182d80de104cabd19be98be002f6d478aaa31574d",
    strip_prefix = "bazel-skylib-2169ae1c374aab4a09aa90e65efe1a3aad4e279b",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/2169ae1c374aab4a09aa90e65efe1a3aad4e279b.tar.gz"],
)

java_import_external(
    name = "com_google_guava_testlib",
    jar_sha256 = "1e7e0e728bb8d68a985115d2439ad6a36473c3e49d78a70945919731f9ac7136",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/guava-testlib/24.1-jre/guava-testlib-24.1-jre.jar",
        "https://repo1.maven.org/maven2/com/google/guava/guava-testlib/24.1-jre/guava-testlib-24.1-jre.jar",
    ],
    licenses = ["notice"],  # Apache 2.0
    testonly_ = 1,
    deps = ["@com_google_guava"],
)

java_import_external(
    name = "com_google_jimfs",
    jar_sha256 = "c4828e28d7c0a930af9387510b3bada7daa5c04d7c25a75c7b8b081f1c257ddd",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/jimfs/jimfs/1.1/jimfs-1.1.jar",
        "https://repo1.maven.org/maven2/com/google/jimfs/jimfs/1.1/jimfs-1.1.jar",
        "http://maven.ibiblio.org/maven2/com/google/jimfs/jimfs/1.1/jimfs-1.1.jar",
    ],
    licenses = ["notice"],  # Apache 2.0
    testonly_ = 1,
    deps = ["@com_google_guava"],
)

java_import_external(
    name = "junit",
    jar_sha256 = "90a8e1603eeca48e7e879f3afbc9560715322985f39a274f6f6070b43f9d06fe",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/junit/junit/4.11/junit-4.11.jar",
        "https://repo1.maven.org/maven2/junit/junit/4.11/junit-4.11.jar",
        "http://maven.ibiblio.org/maven2/junit/junit/4.11/junit-4.11.jar",
    ],
    licenses = ["reciprocal"],  # Common Public License 1.0
    testonly_ = 1,
    deps = ["@org_hamcrest_core"],
)

java_import_external(
    name = "org_hamcrest_core",
    jar_sha256 = "66fdef91e9739348df7a096aa384a5685f4e875584cce89386a7a47251c4d8e9",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar",
        "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar",
        "http://maven.ibiblio.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar",
    ],
    licenses = ["notice"],  # BSD
    testonly_ = 1,
)

java_import_external(
    name = "org_mockito_core",
    jar_sha256 = "ae2efd8f05ceda5ed9c802a43265a95adfa885ca5535a8476a7aaa0b15b95abb",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/org/mockito/mockito-core/3.0.0/mockito-core-3.0.0.jar",
        "https://repo1.maven.org/maven2/org/mockito/mockito-core/3.0.0/mockito-core-3.0.0.jar",
        "http://maven.ibiblio.org/maven2/org/mockito/mockito-core/3.0.0/mockito-core-3.0.0.jar",
    ],
    licenses = ["notice"],  # MIT
    testonly_ = 1,
    deps = [
        "@junit",
        "@net_bytebuddy",
        "@net_bytebuddy_agent",
        "@org_hamcrest_core",
        "@org_objenesis",
    ],
)

java_import_external(
    name = "org_objenesis",
    jar_sha256 = "7a8ff780b9ff48415d7c705f60030b0acaa616e7f823c98eede3b63508d4e984",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/org/objenesis/objenesis/3.0.1/objenesis-3.0.1.jar",
        "https://repo1.maven.org/maven2/org/objenesis/objenesis/3.0.1/objenesis-3.0.1.jar",
        "http://maven.ibiblio.org/maven2/org/objenesis/objenesis/3.0.1/objenesis-3.0.1.jar",
    ],
    licenses = ["notice"],  # Apache
    testonly_ = 1,
)

java_import_external(
    name = "net_bytebuddy",
    jar_sha256 = "f568c036adcef282798ed0e4e02d176a919cf900b0a9bb5e26cbace0d8a8246c",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/net/bytebuddy/byte-buddy/1.9.14/byte-buddy-1.9.14.jar",
        "https://repo1.maven.org/maven2/net/bytebuddy/byte-buddy/1.9.14/byte-buddy-1.9.14.jar",
        "http://maven.ibiblio.org/maven2/net/bytebuddy/byte-buddy/1.9.14/byte-buddy-1.9.14.jar",
    ],
    licenses = ["notice"],  # Apache
    testonly_ = 1,
)

java_import_external(
    name = "net_bytebuddy_agent",
    jar_sha256 = "938a0df38cbc3e91334c383869aeb8436288efafa9f763f75fda51d7d8a703db",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/net/bytebuddy/byte-buddy-agent/1.9.14/byte-buddy-agent-1.9.14.jar",
        "https://repo1.maven.org/maven2/net/bytebuddy/byte-buddy-agent/1.9.14/byte-buddy-agent-1.9.14.jar",
        "http://maven.ibiblio.org/maven2/net/bytebuddy/byte-buddy-agent/1.9.14/byte-buddy-agent-1.9.14.jar",
    ],
    licenses = ["notice"],  # Apache
    testonly_ = 1,
)

java_import_external(
    name = "com_google_truth",
    jar_sha256 = "0f7dced2a16e55a77e44fc3ff9c5be98d4bf4bb30abc18d78ffd735df950a69f",
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/truth/truth/0.45/truth-0.45.jar",
        "http://repo1.maven.org/maven2/com/google/truth/truth/0.45/truth-0.45.jar",
        "http://maven.ibiblio.org/maven2/com/google/truth/truth/0.45/truth-0.45.jar",
    ],
    licenses = ["notice"],  # Apache 2.0
    testonly_ = 1,
    deps = ["@com_google_guava"],
)
