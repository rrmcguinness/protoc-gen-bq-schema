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
load("@io_bazel_rules_go//go:def.bzl", "go_library", "go_test")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")
load("//:configs/deps.bzl", "COMP_DEPS")

go_proto_library(
    name = "bq_proto_lib",
    importpath = "github.com/rrmcguinness/protoc-gen-bq-schema/protos",
    protos = [
        "//api:bq_field_proto",
        "//api:bq_table_proto",
    ],
    visibility = ["//:__subpackages__"],
)

go_library(
    name = "converter",
    srcs = [
        "comments.go",
        "convert.go",
        "protopackage.go",
    ],
    importpath = "github.com/rrmcguinness/protoc-gen-bq-schema/pkg/converter",
    visibility = ["//:__subpackages__"],
    deps = [
        ":bq_proto_lib",
    ] + COMP_DEPS,
)

go_test(
    name = "test",
    srcs = [
        "comments_test.go",
        "field_option_test.go",
        "plugin_test.go",
    ],
    embed = [":converter"],
    deps = COMP_DEPS,
)
