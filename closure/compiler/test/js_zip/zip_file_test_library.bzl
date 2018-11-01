load("//closure:defs.bzl", "CLOSURE_JS_TOOLCHAIN_ATTRS", "create_closure_js_library")

def _impl_zip_file_test_library(ctx):
    return create_closure_js_library(ctx, ctx.files.srcs)

zip_file_test_library = rule(
    implementation = _impl_zip_file_test_library,
    attrs = dict(CLOSURE_JS_TOOLCHAIN_ATTRS, **{
        "srcs": attr.label_list(allow_files = [".js.zip"]),
    }),
)
