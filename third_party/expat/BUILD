package(default_visibility = ["//visibility:public"])

load("//closure/private:deb_extract.bzl", "deb_extract")

licenses(["notice"])

deb_extract(
    name = "libexpat_k8",
    src = "@libexpat_amd64_deb//file",
    outs = {"lib/x86_64-linux-gnu/libexpat.so.1.6.0": "k8/libexpat.so.1"},
)
