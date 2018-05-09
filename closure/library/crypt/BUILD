# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":aes",
        ":arc4",
        ":base64",
        ":basen",
        ":blobhasher",
        ":blockcipher",
        ":cbc",
        ":crypt",
        ":ctr",
        ":hash",
        ":hash32",
        ":hmac",
        ":md5",
        ":pbkdf2",
        ":sha1",
        ":sha2",
        ":sha224",
        ":sha256",
        ":sha2_64bit",
        ":sha384",
        ":sha512",
        ":sha512_256",
    ],
)

closure_js_library(
    name = "aes",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/aes.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/crypt:blockcipher",
    ],
)

closure_js_library(
    name = "arc4",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/arc4.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)

closure_js_library(
    name = "base64",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/base64.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/crypt",
        "//closure/library/string",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "basen",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/basen.js"],
    lenient = True,
)

closure_js_library(
    name = "blobhasher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/blobhasher.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events:eventtarget",
        "//closure/library/fs",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "blockcipher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/blockcipher.js"],
    lenient = True,
)

closure_js_library(
    name = "cbc",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/cbc.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/crypt",
        "//closure/library/crypt:blockcipher",
    ],
)

closure_js_library(
    name = "crypt",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/crypt.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
    ],
)

closure_js_library(
    name = "ctr",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/ctr.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/crypt",
    ],
)

closure_js_library(
    name = "hash",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/hash.js"],
    lenient = True,
)

closure_js_library(
    name = "hash32",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/hash32.js"],
    lenient = True,
    deps = ["//closure/library/crypt"],
)

closure_js_library(
    name = "hashtester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/hashtester.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/crypt",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/testing:asserts",
        "//closure/library/testing:performancetable",
        "//closure/library/testing:pseudorandom",
    ],
)

closure_js_library(
    name = "hmac",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/hmac.js"],
    lenient = True,
    deps = ["//closure/library/crypt:hash"],
)

closure_js_library(
    name = "md5",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/md5.js"],
    lenient = True,
    deps = ["//closure/library/crypt:hash"],
)

closure_js_library(
    name = "pbkdf2",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/pbkdf2.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/crypt",
        "//closure/library/crypt:hmac",
        "//closure/library/crypt:sha1",
    ],
)

closure_js_library(
    name = "sha1",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha1.js"],
    lenient = True,
    deps = ["//closure/library/crypt:hash"],
)

closure_js_library(
    name = "sha2",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha2.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/crypt:hash",
    ],
)

closure_js_library(
    name = "sha224",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha224.js"],
    lenient = True,
    deps = ["//closure/library/crypt:sha2"],
)

closure_js_library(
    name = "sha256",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha256.js"],
    lenient = True,
    deps = ["//closure/library/crypt:sha2"],
)

closure_js_library(
    name = "sha2_64bit",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha2_64bit.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/crypt:hash",
        "//closure/library/math:long",
    ],
)

closure_js_library(
    name = "sha384",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha384.js"],
    lenient = True,
    deps = ["//closure/library/crypt:sha2_64bit"],
)

closure_js_library(
    name = "sha512",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha512.js"],
    lenient = True,
    deps = ["//closure/library/crypt:sha2_64bit"],
)

closure_js_library(
    name = "sha512_256",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/crypt/sha512_256.js"],
    lenient = True,
    deps = ["//closure/library/crypt:sha2_64bit"],
)
