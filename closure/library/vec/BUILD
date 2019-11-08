# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":float32array",
        ":float64array",
        ":mat3",
        ":mat3d",
        ":mat3f",
        ":mat4",
        ":mat4d",
        ":mat4f",
        ":quaternion",
        ":ray",
        ":vec",
        ":vec2",
        ":vec2d",
        ":vec2f",
        ":vec3",
        ":vec3d",
        ":vec3f",
        ":vec4",
        ":vec4d",
        ":vec4f",
    ],
)

closure_js_library(
    name = "float32array",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/float32array.js"],
    lenient = True,
)

closure_js_library(
    name = "float64array",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/float64array.js"],
    lenient = True,
)

closure_js_library(
    name = "mat3",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat3.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "mat3d",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat3d.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:vec3d",
    ],
)

closure_js_library(
    name = "mat3f",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat3f.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:vec3f",
    ],
)

closure_js_library(
    name = "mat4",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat4.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:vec3",
        "//closure/library/vec:vec4",
    ],
)

closure_js_library(
    name = "mat4d",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat4d.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:quaternion",
        "//closure/library/vec:vec3d",
        "//closure/library/vec:vec4d",
    ],
)

closure_js_library(
    name = "mat4f",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/mat4f.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:quaternion",
        "//closure/library/vec:vec3f",
        "//closure/library/vec:vec4f",
    ],
)

closure_js_library(
    name = "quaternion",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/quaternion.js"],
    lenient = True,
    deps = [
        "//closure/library/vec",
        "//closure/library/vec:vec3",
        "//closure/library/vec:vec4",
    ],
)

closure_js_library(
    name = "ray",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/ray.js"],
    lenient = True,
    deps = ["//closure/library/vec:vec3"],
)

closure_js_library(
    name = "vec",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec.js"],
    lenient = True,
    deps = [
        "//closure/library/vec:float32array",
        "//closure/library/vec:float64array",
    ],
)

closure_js_library(
    name = "vec2",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec2.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec2d",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec2d.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec2f",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec2f.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec3",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec3.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec3d",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec3d.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec3f",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec3f.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec4",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec4.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec4d",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec4d.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)

closure_js_library(
    name = "vec4f",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/vec/vec4f.js"],
    lenient = True,
    deps = ["//closure/library/vec"],
)
