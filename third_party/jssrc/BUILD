package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

genrule(
    name = "jssrc",
    srcs = ["@soy_jssrc//file"],
    outs = [
        # TODO(hochhaus): Add safehtml dependency
        # "jspbconversions.js",
        # "soydata_converters.js",
        "soyutils_usegoog.js",
    ],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$(@D)",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "unzip -q $$IN",
        "mv soyutils_usegoog.js $$OUT",
        "rm -rf $$TMP",
    ]),
)
