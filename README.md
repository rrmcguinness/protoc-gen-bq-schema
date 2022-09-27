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

## Using the Bazel Tool Chain

### Dependencies

* [Bazelisk](https://github.com/bazelbuild/bazelisk)

> NOTE: Test the execution, bazelisk version; then create an alias for 'bazel'.

```shell
# Build
bazel build //...

# Test
bazel test //...

# Test Coverage
bazel coverage //...
```

### Make Targets analogs
```shell
make bazel
make bazel-test
make bazel-coverate
```


## Using the Go Tool Chain

If you are using Native Go, and Protoc, there are incompatibilities between various versions
which impact the build integrity. This IS NOT the case if you use the Bazel tool chain,
as all dependencies are managed.

### Dependencies

* Go - Version 1.19 or later.
* Protobuf Compiler - Version 21.5 (Tested)

## Build with Make

```shell

# Make all (uses native go tool chain)
$ make all

# Run tests
$ make test

# Run Generate Files
$ make generate

# Build
$ make compile

# Clean
$ make clean
```

## Native Go Build

### Generate

Generate the Protobuf Files for the protos defined in the API directory.

> NOTE: These generated files ONLY IMPACT the Go tool chain.

```shell
$ go generate ./...
```

### Test

```shell
$ go test ./...
```

### Build

Build the project
```shell
$ go build
```



