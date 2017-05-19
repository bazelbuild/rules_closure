package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

genrule(
    name = "protoc_bin_unix",
    srcs = select({
        ":darwin": ["@com_google_protobuf_protoc_macosx//file"],
        "//conditions:default": ["@com_google_protobuf_protoc_linux_x86_64//file"],
    }),
    outs = ["protoc"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "unzip -q $$IN bin/protoc",
        "mv bin/protoc $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)

genrule(
    name = "protoc_bin_windows",
    srcs = ["@com_google_protobuf_protoc_windows//file"],
    outs = ["protoc.exe"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
        "unzip -q $$IN bin/protoc.exe",
        "mv bin/protoc.exe $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)

filegroup(
    name = "protoc_bin",
    srcs = select({
        ":windows" : [":protoc.exe"],
        ":windows_msvc" : [":proto.exe"],
        "//conditions:default" : [":protoc"],
    }),
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)

config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:private"],
)

config_setting(
    name = "windows_msvc",
    values = {"cpu": "x64_windows_msvc"},
    visibility = ["//visibility:private"],
)
