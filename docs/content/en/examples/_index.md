---
title: "Examples"
---

These protocol buffer files demonstrate how to use the tags to generate
different output specs.

{{< toc format="html" >}}

## [Common Protobuf](protos/common.proto)

{{< include file="examples/protos/common.proto" language="protobuf" >}}

## [Foo (Proto 3)](protos/foo-proto3.proto)

{{< tabs "foo_proto" >}}
{{< tab "Protobuf" >}}

{{< include file="examples/protos/foo-proto3.proto" language="protobuf" >}}

{{< /tab >}}
{{< tab "Schema" >}}

{{< include file="examples/schemas/bar_proto3_table.schema" language="json" >}}

{{< /tab >}}
{{< /tabs >}}

## Foo (Proto 2)

[proto](protos/foo.proto) | [schema]()

{{< tabs "foo2_proto" >}}
{{< tab "Protobuf" >}}

{{< include file="examples/protos/foo.proto" language="protobuf" >}}

{{< /tab >}}
{{< tab "Schema" >}}

{{< include file="examples/schemas/bar_table.schema" language="json" >}}

{{< /tab >}}
{{< /tabs >}}

## [Single Message](single_message.proto)

{{< tabs "single_message_proto" >}}
{{< tab "Protobuf" >}}

{{< include file="examples/protos/single_message.proto" language="protobuf" >}}

{{< /tab >}}
{{< tab "Schema" >}}

{{< include file="examples/schemas/single_message.schema" language="json" >}}

{{< /tab >}}
{{< /tabs >}}

## [Test Table](test_table.proto)


{{< tabs "test_table_proto" >}}
{{< tab "Protobuf" >}}

{{< include file="examples/protos/test_table.proto" language="protobuf" >}}

{{< /tab >}}
{{< tab "Schema" >}}

{{< include file="examples/schemas/test_table.schema" language="json" >}}

{{< /tab >}}
{{< /tabs >}}
