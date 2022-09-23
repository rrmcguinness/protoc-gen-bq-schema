# protoc-gen-bq-schema

> Note, this is a significant refactoring of the existing repository
> found protoc-gen-bq-schema [here](https://github.com/GoogleCloudPlatform/protoc-gen-bq-schema).
> The reason for this refactor is to utilize the targets as a part of a 
> Bazel project without manually copying files or adding complexity to BUILD
> files.

[Original Read Me file](docs/original_readme.md)

## Generating with Bazel

### Prerequisites

Ensure you have your bazel workspace setup correctly. In order to use this module,
you will need both Protobuf and GRPC dependencies.

See the [Rules Proto GRPC](https://github.com/rules-proto-grpc/rules_proto_grpc)
project for more detail.

<detail>
    <summary>GRPC Rules</summary>

```python

...

http_archive(
    name = "com_google_protobuf",
    sha256 = "7ba0cb2ecfd9e5d44a6fa9ce05f254b7e5cd70ec89fafba0b07448f3e258310c",
    strip_prefix = "protobuf-21.5",
    urls = [
        "https://github.com/protocolbuffers/protobuf/releases/download/v21.5/protobuf-all-21.5.tar.gz",
    ],
)

http_archive(
name = "rules_proto",
sha256 = "e017528fd1c91c5a33f15493e3a398181a9e821a804eb7ff5acdd1d2d6c2b18d",
strip_prefix = "rules_proto-4.0.0-3.20.0",
urls = [
"https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0-3.20.0.tar.gz",
],
)

http_archive(
name = "rules_proto_grpc",
sha256 = "bbe4db93499f5c9414926e46f9e35016999a4e9f6e3522482d3760dc61011070",
strip_prefix = "rules_proto_grpc-4.2.0",
urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/4.2.0.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("//:conf/go_deps.bzl", "go_dependencies")

# gazelle:repository_macro conf/go_deps.bzl%go_dependencies
go_dependencies()

protobuf_deps()

http_archive(
name = "com_github_bazelbuild_buildtools",
sha256 = "e3bb0dc8b0274ea1aca75f1f8c0c835adbe589708ea89bf698069d0790701ea3",
strip_prefix = "buildtools-5.1.0",
urls = [
"https://github.com/bazelbuild/buildtools/archive/refs/tags/5.1.0.tar.gz",
],
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

load("@rules_proto_grpc//go:repositories.bzl", rules_proto_grpc_go_repos = "go_repos")

rules_proto_grpc_go_repos()

load("@rules_proto_grpc//doc:repositories.bzl", rules_proto_grpc_doc_repos = "doc_repos")

rules_proto_grpc_doc_repos()

...
```
</detail>

## Workspace

Latest Version: 0.1.11-release

```python
http_archive(
    name = "protoc-gen-bq-schema",
    strip_prefix = "protoc-gen-bq-schema-[VERSION] ",
    url = "https://github.com/rrmcguinness/protoc-gen-bq-schema/archive/refs/tags/[VERSION] -release.tar.gz",
)
```

> Replace the [VERSION] with the latest from the [GitHub Releases page](https://github.com/rrmcguinness/protoc-gen-bq-schema/releases).


## Build File

#### Define a 'country.proto' file

```protobuf
syntax = "proto3";

package example.model;

// Go Lang Options
option go_package = "example/model";

// Java Options
option java_package = "example.model";
option java_multiple_files = true;

// Here for illustration
//import "google/protobuf/timestamp.proto";

import "bq/schema/protos/bq_table.proto";
import "bq/schema/protos/bq_field.proto";

/*
 * ISO 3166-1 Country
 */
message Country {
  option (gen_bq_schema.bigquery_opts).table_name = "country_tbl";
  string id = 1 [
    (gen_bq_schema.bigquery) = {
      require: true
      policy_tags : "private"
    }
  ];
  string name = 2 [
    (gen_bq_schema.bigquery) = {
      require: true
    }
  ];
  string alpha2 = 3 [
    (gen_bq_schema.bigquery) = {
      require: true
    }
  ];
  string alpha3 = 4 [
    (gen_bq_schema.bigquery) = {
      require: true
    }
  ];
  string code = 5;
  string iso2 = 6 [
    (gen_bq_schema.bigquery) = {
      require: true
    }
  ];
  string region = 7;
  string sub_region = 8;
  string intermediate_region = 9;
  string region_code = 10;
  string sub_region_code = 11;
  string intermediate_region_code = 12;
}
```

#### Define a standard "proto_library"

```python
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
)
```

#### Add a schema compile target
```python
load("//:conf/schema_compile.bzl", "schema_compile")

schema_compile(
    name = "schema",
    extra_protoc_args = [
        "--bq-schema_out=.",
        "--bq-schema_opt=single-message",
    ],
    protos = [
        ":model",
    ],
)

# Create a file group that can be used later perhaps for static documents or
# other auto-gen routines
filegroup(
  name = "api_schema_files",
  srcs = [":schema"],
)
```

> All files are generated to your bazel-bin/<module-path>/schema/<proto-path>

#### Using the generated protobuf with other proto libraries

```python
go_proto_library(
    name = "my_other_proto_lib",
    importpath = "...",
    proto = "//modules/common/api:model",
    visibility = ["//:__subpackages__"],
    deps = [
        ...,
        "@protoc-gen-bq-schema//:bq_go_proto_lib",
    ],
)
```


#### View the output

```json
[
 {
  "name": "id",
  "type": "STRING",
  "mode": "REQUIRED",
  "policyTags": {
   "names": [
    "private"
   ]
  }
 },
 {
  "name": "name",
  "type": "STRING",
  "mode": "REQUIRED"
 },
 {
  "name": "alpha2",
  "type": "STRING",
  "mode": "REQUIRED"
 },
 {
  "name": "alpha3",
  "type": "STRING",
  "mode": "REQUIRED"
 },
 {
  "name": "code",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "iso2",
  "type": "STRING",
  "mode": "REQUIRED"
 },
 {
  "name": "region",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "sub_region",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "intermediate_region",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "region_code",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "sub_region_code",
  "type": "STRING",
  "mode": "NULLABLE"
 },
 {
  "name": "intermediate_region_code",
  "type": "STRING",
  "mode": "NULLABLE"
 }
]
```



