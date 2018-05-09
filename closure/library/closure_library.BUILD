package(default_visibility = ["//visibility:public"])

filegroup(
    name = "com_google_javascript_closure_library",
    srcs = glob([
        "closure/**",
        "third_party/**",
    ]),
)

filegroup(
    name = "css_files",
    srcs = glob(["closure/goog/css/**/*.css"]),
)

py_library(
    name = "build_source",
    srcs = ["closure/bin/build/source.py"],
)

py_library(
    name = "build_treescan",
    srcs = ["closure/bin/build/treescan.py"],
)

py_binary(
    name = "depswriter",
    srcs = ["closure/bin/build/depswriter.py"],
    main = "closure/bin/build/depswriter.py",
    deps = [
        ":build_source",
        ":build_treescan",
    ],
)
