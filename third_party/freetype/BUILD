package(default_visibility = ["//visibility:public"])

load("//closure/private:deb_extract.bzl", "deb_extract")

licenses(["notice"])

deb_extract(
    name = "libfreetype_k8",
    src = "@libfreetype_amd64_deb//file",
    outs = {"usr/lib/x86_64-linux-gnu/libfreetype.so.6.11.1": "k8/libfreetype.so.6"},
)
