# For creating a binary proto library
load("@rules_proto//proto:defs.bzl", "proto_library")

# For documenting your protobuf
load("@rules_proto_grpc//doc:defs.bzl", "doc_markdown_compile")

# For compiling the schema
load("//:conf/schema_compile.bzl", "schema_compile")

# Step 1: Define a protocol library, here you can see the dependencies
# required by the proto. The well known types are there for example.
proto_library(
    name = "model",
    srcs = [
        "model.proto",
    ],
    deps = [
        # Add Common Types
        "@com_google_protobuf//:any_proto",
        "@com_google_protobuf//:empty_proto",
        "@com_google_protobuf//:field_mask_proto",
        "@com_google_protobuf//:timestamp_proto",
        # Add the protoc-gen-bq-schema protos
        "@protoc-gen-bq-schema//:bq_field_proto",
        "@protoc-gen-bq-schema//:bq_table_proto",
    ],
    visibility = ["//:__subpackages__"],
)

# Step 2: Compile your schema from the proto library
schema_compile(
    name = "schema",
    extra_protoc_args = [
        "--bq-schema_out=.",
        "--bq-schema_opt=single-message",
    ],
    protos = [
        ":model",
    ],
    visibility = ["//visibility:private"],
)

# Step 3: Use your proto library as a part of your project
go_proto_library(
    name = "my_other_proto_lib",
    importpath = "...",
    proto = "//my_project/api:model",
    visibility = ["//:__subpackages__"],
    deps = [
        "@protoc-gen-bq-schema//:bq_go_proto_lib",
    ],
)
