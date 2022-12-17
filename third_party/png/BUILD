package(default_visibility = ["//visibility:public"])

load("//closure/private:deb_extract.bzl", "deb_extract")

licenses(["notice"])

deb_extract(
    name = "libpng_k8",
    src = "@libpng_amd64_deb//file",
    outs = {"lib/x86_64-linux-gnu/libpng12.so.0.50.0": "k8/libpng12.so.0"},
)
