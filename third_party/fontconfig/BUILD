package(default_visibility = ["//visibility:public"])

load("//closure/private:deb_extract.bzl", "deb_extract")

licenses(["notice"])

deb_extract(
    name = "libfontconfig_k8",
    src = "@libfontconfig_amd64_deb//file",
    outs = {"usr/lib/x86_64-linux-gnu/libfontconfig.so.1.8.0": "k8/libfontconfig.so.1"},
)

filegroup(
    name = "config",
    srcs = [
        "fonts.conf",
        "//third_party/noto:hinted",
        "//third_party/noto:mono",
    ],
)
