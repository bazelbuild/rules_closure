# TODO: Remove @bazel_gazelle and @io_bazel_rules_go when rules_webtesting is pinned to an
# official release (>0.3.5).
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load(
    "@io_bazel_rules_webtesting//web:go_repositories.bzl",
    "go_internal_repositories",
    "go_repositories",
)
load("@io_bazel_rules_webtesting//web:java_repositories.bzl", "java_repositories")
load("@io_bazel_rules_webtesting//web:repositories.bzl", "web_test_repositories")
load("@io_bazel_rules_webtesting//web/versioned:browsers-0.3.4.bzl", "browser_repositories")

def setup_web_test_repositories(**kwargs):
    """
    Loading dependencies needed for web testing

    Args:
      **kwargs: Set which browser repositories to be loaded.
    """

    # TODO: Remove these 3 dependencies when rules_webtesting is pinned to an official
    # release (>0.3.5).
    go_rules_dependencies()
    go_register_toolchains(version = "1.20.5")
    gazelle_dependencies()

    web_test_repositories()

    browser_repositories(
        **kwargs
    )

    # TODO: Remove these 2 dependencies when rules_webtesting is pinned to an official
    # release (>0.3.5).
    go_repositories()
    go_internal_repositories()

    java_repositories()
