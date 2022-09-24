---
title: "BigQuery Schema Generator"
---


## protoc-gen-bq-schema

protoc-gen-bq-schema is a plugin for [ProtocolBuffer compiler](https://github.com/google/protobuf).
It converts messages written in .proto format into schema files in JSON for BigQuery.
So you can reuse existing data definitions in .proto for BigQuery with this plugin.


## Command Line Interface Installation

These options are usable, manually from the command line by invoking `protoc`.
These ARE NOT required when using Bazel.

```shell
go install github.com/rrmcguinness/protoc-gen-bq-schema@latest
```

## Usage

```shell
protoc --bq-schema_out=path/to/outdir [--bq-schema_opt=single-message] foo.proto
```

{{< hint type=note icon=gdoc_github title=Path >}}
`protoc` and `protoc-gen-bq-schema` commands must be found in $PATH.
{{< /hint >}}

{{< hint type=note icon=gdoc_path title=Output >}}
The generated JSON schema files are suffixed with `.schema` and their base names 
are named after their package names and `bq_table_name` options.
{{< /hint >}}

If you do not already have the standard google protobuf libraries in your 
`proto_path`, you'll need to specify them directly on the command line 
(and potentially need to copy `bq_schema.proto` into a proto_path directory 
as well), like this:

```sh
protoc --bq-schema_out=path/to/out/dir foo.proto --proto_path=. --proto_path=<path_to_google_proto_folder>/src
```