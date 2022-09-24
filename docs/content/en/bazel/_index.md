---
title: "Bazel"
weight: 2
---

## Introduction

In order to use the BQ Schema Generator with Bazel, follow these steps:

1. Adjust your WORKSPACE file to include your language, protobufs, GRPC, and lastly, the protoc-gen-bq-schema project.
2. Create a protocol buffer file(s).
   1. Best practices: keep your table definitions (stateful nouns) in a separate file from your transfer objects (stateless) and your service definitions (verbs).
3. Implement your tests and service end-points (if you have them).
4. Create your BUILD file in the closet directory to your source code.
5. Build
6. Verify your schemas.

## Source Code

{{< tabs "bazel_steps" >}}

{{< tab "WORKSPACE File" >}}

{{< include file="bazel/example_workspace.bzl" language="python" >}}

{{< /tab >}}

{{< tab "Protobuf" >}}

{{< include file="bazel/country.proto" language="protobuf" >}}

{{< /tab >}}

{{< tab "BUILD File" >}}

{{< include file="bazel/example_build.bzl" language="python" >}}

{{< /tab >}}

{{< tab "Schema File" >}}

{{< include file="bazel/country_tbl.schema" language="json" >}}

{{< /tab >}}

{{< /tabs >}}