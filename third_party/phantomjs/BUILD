package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

sh_binary(
    name = "phantomjs",
    srcs = ["phantomjs.sh"],
    data = [
        "bin/phantomjs",
        "//third_party/expat:libexpat_k8",
        "//third_party/fontconfig:config",
        "//third_party/fontconfig:libfontconfig_k8",
        "//third_party/freetype:libfreetype_k8",
        "//third_party/png:libpng_k8",
    ],
)

genrule(
    name = "phantomjs_bin",
    srcs = ["@phantomjs//file"],
    outs = ["bin/phantomjs"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
    ]) + select({
        ":darwin": " && unzip -q $$IN && ",
        "//conditions:default": " && tar -xjf $$IN && ",
    }) + " && ".join([
        "mv */bin/phantomjs $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
    visibility = ["//visibility:private"],
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)
