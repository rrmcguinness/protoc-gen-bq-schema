---
title: "BQ Protobuf Options"
weight: 2
---

## Protocol Documentation
<a name="top"></a>

## Table of Contents

- [api/bq_field.proto](#api_bq_field-proto)
    - [BigQueryFieldOptions](#gen_bq_schema-BigQueryFieldOptions)
  
    - [File-level Extensions](#api_bq_field-proto-extensions)
  
- [api/bq_table.proto](#api_bq_table-proto)
    - [BigQueryMessageOptions](#gen_bq_schema-BigQueryMessageOptions)
  
    - [File-level Extensions](#api_bq_table-proto-extensions)
  
- [Scalar Value Types](#scalar-value-types)

<a name="api_bq_field-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## api/bq_field.proto
Copyright 2014 Google LLC

Licensed under the Apache License, Version 2.0 (the &#34;License&#34;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an &#34;AS IS&#34; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


<a name="gen_bq_schema-BigQueryFieldOptions"></a>

### BigQueryFieldOptions
Message containing options related to BigQuery schema generation
and management via Protobuf.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| require | [bool](#bool) |  | Flag to specify that a field should be marked as &#39;REQUIRED&#39; when used to generate schema for BigQuery. |
| type_override | [string](#string) |  |  |
| ignore | [bool](#bool) |  | Optionally omit a field from BigQuery schema. |
| description | [string](#string) |  | Set the description for a field in BigQuery schema. |
| name | [string](#string) |  | Customize the name of the field in the BigQuery schema. |
| policy_tags | [string](#string) |  | Optionally add PolicyTag for a field in BigQuery schema. |





 

 


<a name="api_bq_field-proto-extensions"></a>

### File-level Extensions
| Extension | Type | Base | Number | Description |
| --------- | ---- | ---- | ------ | ----------- |
| bigquery | BigQueryFieldOptions | .google.protobuf.FieldOptions | 1021 | BigQuery field schema generation options. |

 

 



<a name="api_bq_table-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## api/bq_table.proto



<a name="gen_bq_schema-BigQueryMessageOptions"></a>

### BigQueryMessageOptions



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| table_name | [string](#string) |  | Specifies a name of table in BigQuery for the message.

If not blank, indicates the message is a type of record to be stored into BigQuery. |
| use_json_names | [bool](#bool) |  | If true, BigQuery field names will default to a field&#39;s JSON name, not its original/proto field name. |
| extra_fields | [string](#string) | repeated | If set, adds defined extra fields to a JSON representation of the message. Value format: &#34;&lt;field name&gt;:&lt;BigQuery field type&gt;&#34; for basic types or &#34;&lt;field name&gt;:RECORD:&lt;protobuf type&gt;&#34; for message types. &#34;NULLABLE&#34; by default, different mode may be set via optional suffix &#34;:&lt;mode&gt;&#34; |





 

 


<a name="api_bq_table-proto-extensions"></a>

### File-level Extensions
| Extension | Type | Base | Number | Description |
| --------- | ---- | ---- | ------ | ----------- |
| bigquery_opts | BigQueryMessageOptions | .google.protobuf.MessageOptions | 1021 | NB: There used to be a custom option named &#34;table_name&#34;. But only one tag is registered for this project: 1021. So when adding other options, the only solution was to change tag 1021 to be a message, with all the various options as fields therein.

If you are upgrading this library and find that protoc begins to reject your proto files, you&#39;ll need to change all lines that look like so: option (gen_bq_schema.table_name) = &#34;foo&#34;; to instead look like this: option (gen_bq_schema.bigquery_opts).table_name = &#34;foo&#34;; There was no backwards compatible way to make this change. Sorry for the inconvenience. BigQuery message schema generation options.

The field number is a globally unique id for this option, assigned by protobuf-global-extension-registry@google.com |

 

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

