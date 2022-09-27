# protoc-gen-bq-schema

This is a significant refactor of the GoogleCloudPlatform protoc-gen-bq-schema 
plugin. NOT the functionality, but the surrounding scaffolding to run within
a Bazel build environment.

In addition, there is a new [GitHub pages website](https://rrmcguinness.github.io/protoc-gen-bq-schema).
Please visit the site to learn about how to configure and use this project.

I'd like to sincerely thank the contributors to the original plugin. It's a
foundational tool for extending and further automating tool chains.

I sincerely hope you find this extension useful, especially if you're using Bazel.

* [Contributor List](https://rrmcguinness.github.io/protoc-gen-bq-schema/contributors/)
* [License](LICENSE)
* [Notice](NOTICE)

## Native Go Build

Generate the Protobuf Files for the protos defined in the API directory
```shell
$ go generate ./...
```

Build the project
```shell
$ go build
```



