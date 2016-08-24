package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

genrule(
    name = "jssrc",
    srcs = ["@soy_jssrc//file"],
    outs = [
        "jspbconversions.js",
        "soydata_converters.js",
        "soyutils_usegoog.js",
    ],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$(@D)",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "unzip -q $$IN",
        "mv *.js $$OUT",
        "rm -rf $$TMP",
    ]),
)

genrule(
    name = "html_proto",
    srcs = ["@safe_html_types_html_proto//file"],
    outs = [
        "html.proto",
    ],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "tar xf $$IN",
        "mv safe-html-types-release-*/proto/src/main/protobuf/html.proto $$OUT",
        "rm -rf $$TMP",
    ]),
)
