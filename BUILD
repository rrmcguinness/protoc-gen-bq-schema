# Copyright 2014 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_gazelle//:def.bzl", "gazelle")
load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("//:configs/deps.bzl", "COMP_DEPS")
load("@rules_pkg//:pkg.bzl", "pkg_zip")
load("@rules_proto_grpc//:defs.bzl", "proto_plugin")

package(default_visibility = ["//:__subpackages__"])

buildifier(
    name = "buildifier",
)

gazelle(
    name = "gazelle",
    prefix = "google_retail_platform",
)

gazelle(
    name = "gazelle-update-repos",
    args = [
        "-from_file=go.mod",
        "-to_macro=configs/go_deps.bzl%go_dependencies",
        "-prune",
    ],
    command = "update-repos",
)

alias(
    name = "bq_field_proto",
    actual = "//api/bq/schema/protos:bq_field_proto",
    visibility = ["//visibility:public"],
)

alias(
    name = "bq_table_proto",
    actual = "//api/bq/schema/protos:bq_table_proto",
    visibility = ["//visibility:public"],
)

alias(
    name = "bq_go_proto_lib",
    actual = "//internal/converter:bq_proto_lib",
    visibility = ["//visibility:public"],
)

# proto_plugin
# proto_compile_impl

proto_plugin(
    name = "bq_plugin",
    exclusions = [
        "google/api",
        "google/protobuf",
    ],
    output_directory = True,
    tool = ":protoc-gen-bq-schema",
    visibility = ["//visibility:public"],
)

go_binary(
    name = "protoc-gen-bq-schema",
    srcs = [
        "main.go",
    ],
    out = "protoc-gen-bq-schema",
    importpath = "github.com/rrmcguinness/protoc-gen-bq-schema",
    visibility = ["//visibility:public"],
    deps = [
        "//internal/converter",
        "//internal/converter:bq_proto_lib",
    ] + COMP_DEPS,
)

archive_version = "0.1.1"

archive_base_name = "protoc-gen-bq-schema"

#pkg_zip(
#    name = "protoc_gen_bq_schema_src",
#    srcs = glob([
#        "api/*",
#        "conf/*",
#        "docs/*",
#        "internal/*",
#        "test/*",
#        "main.go",
#        "BUILD",
#        "LICENSE",
#        "NOTICE",
#        "WORKSPACE",
#        "README.md",
#        "go.mod",
#    ]),
#    out = "{}-src-{}.zip".format(archive_base_name, archive_version),
#)

pkg_zip(
    name = "protoc_gen_bq_schema_zip",
    srcs = [
        "LICENSE",
        "NOTICE",
        "README.md",
        ":protoc-gen-bq-schema",
    ],
    out = "binary.zip",
    package_file_name = select({
        "on_linux": "{}-linux-x86_64-{}.zip".format(archive_base_name, archive_version),
        "on_osx_x64": "{}-darwin-x86_64-{}.zip".format(archive_base_name, archive_version),
        "on_windows": "{}-windows-x86_64-{}.zip".format(archive_base_name, archive_version),
        "on_osx_arm": "{}-darwin-arm.zip-{}".format(archive_base_name, archive_version),
    }),
)

config_setting(
    name = "on_linux",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

config_setting(
    name = "on_windows",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
)

config_setting(
    name = "on_osx_x64",
    constraint_values = [
        "@platforms//os:osx",
        "@platforms//cpu:x86_64",
    ],
)

config_setting(
    name = "on_osx_arm",
    constraint_values = [
        "@platforms//os:osx",
        "@platforms//cpu:arm",
    ],
)
