module github.com/rrmcguinness/protoc-gen-bq-schema

go 1.15

replace github.com/rrmcguinness/protoc-gen-bq-schema/protos => ./protos

require (
	github.com/golang/glog v1.0.0
	github.com/golang/protobuf v1.5.2
	github.com/googleapis/googleapis v0.0.0-20220921183642-8933d4b4aec2 // indirect
	google.golang.org/protobuf v1.28.0
	github.com/rrmcguinness/protoc-gen-bq-schema/protos v0.0.0-00010101000000-000000000000 // indirect
)
