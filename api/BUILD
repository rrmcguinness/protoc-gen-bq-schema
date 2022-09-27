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

load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_proto_grpc//doc:defs.bzl", "doc_markdown_compile")

package(default_visibility = ["//:__subpackages__"])

proto_library(
    name = "bq_field_proto",
    srcs = ["bq_field.proto"],
    import_prefix = "bq/schema/protos",
    deps = ["@com_google_protobuf//:descriptor_proto"],
)

proto_library(
    name = "bq_table_proto",
    srcs = ["bq_table.proto"],
    import_prefix = "bq/schema/protos",
    deps = ["@com_google_protobuf//:descriptor_proto"],
)

doc_markdown_compile(
    name = "docs",
    protos = [
        ":bq_field_proto",
        ":bq_table_proto",
    ],
)
