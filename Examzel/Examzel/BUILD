# load("@bazel_skylib//rules:build_test.bzl", "build_test")
# load("//apple:ios.bzl", "ios_application", "ios_ui_test", "ios_unit_test")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "xcodeproj",
)

swift_library(
    name = "Sources",
    srcs = [
        "Sources/AppDelegate.swift",
        "Sources/SceneDelegate.swift",
        "Sources/ViewController.swift",
    ],
    data = [
        "Resources/Base.lproj/LaunchScreen.storyboard",
        "Resources/Base.lproj/Main.storyboard",
    ],
    # we should use this module_name as a prefix for SceneDelegate in the info.plist
    module_name = "Sources",
    tags = ["manual"],
)

ios_application(
    name = "Examzel",
    # app_icons = ["//examples/resources:PhoneAppIcon.xcassets"],
    bundle_id = "com.khosravinia.examzel",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["Resources/Info.plist"],
    minimum_os_version = "13.0",
    visibility = ["//visibility:public"],
    deps = [":Sources"],
)

xcodeproj(
    name = "Examzel_xcodeproj",
    project_name = "Examzel",
    tags = ["manual"],
    top_level_targets = [
        ":Examzel",
    ],
)

# xcodeproj(
#     name = "Examzel_Project",
#     srcs = [
#         "//:Examzel",
#     ],
#     build_action = "build",
#     build_configuration = "debug",
#     build_setting_overrides = {
#         "ENABLE_BITCODE": "NO",
#         "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
#     },
#     bundle_id = "com.khosravinia.examzel",
#     ios_deployment_target = "13.0",
#     minimum_deployment_target = "13.0",
#     platform = "ios",
#     product_name = "Examzel",
#     product_type = "application",
#     swift_version = "5.7",
#     use_frameworks = True,
#     xcode_version = "14.3.0",
#     deps = [
#         ":Examzel",
#     ],
# )

# swift_library(
#     name = "Tests",
#     testonly = True,
#     srcs = [
#         "Tests/Tests.swift",
#     ],
#     tags = ["manual"],
#     deps = [
#         ":Sources",
#     ],
# )

# Pass the depending UI test's name as module_name to support test_filter
# swift_library(
#     name = "UITests",
#     testonly = True,
#     srcs = [
#         "Tests/UITests.swift",
#     ],
#     module_name = "HelloWorldSwiftUITests",
#     tags = ["manual"],
# )

# ios_unit_test(
#     name = "UnitTests",
#     minimum_os_version = "15.0",
#     deps = [":Tests"],
# )

# genrule(
#     name = "CreateTestCoverageManifest",
#     srcs = ["Sources/AppDelegate.swift"],
#     outs = [
#         "CoverageManifest.instrumented_files",
#     ],
#     cmd = "echo $(SRCS) > $@",
# )

# ios_unit_test(
#     name = "UnitTestsWithCoverageManifest",
#     minimum_os_version = "15.0",
#     test_coverage_manifest = "CoverageManifest.instrumented_files",
#     deps = [":Tests"],
# )

# Not normally needed, just done for rules_apple's examples so a
# 'bazel test examples/...' ensures all Examples still build.
# build_test(
#     name = "ExamplesBuildTest",
#     targets = [":HelloWorldSwift"],
# )

# ios_ui_test(
#     name = "HelloWorldSwiftUITests",
#     minimum_os_version = "15.0",
#     runner = "@build_bazel_rules_apple//apple/testing/default_runner:ios_xctestrun_ordered_runner",
#     test_host = ":HelloWorldSwift",
#     deps = [":UITests"],
# )
