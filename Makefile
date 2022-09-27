# Simplified build steps to ensure generate is called.

# Shows the make targets
usage:
	echo "make [generate|compile|test|all|clean] [bazel|bazel-test|bazel-coverage]"

# Generates the protobuf files
generate:
	echo "Generating Files"
	go generate ./...

# Compiles the source
compile:
	echo "Building"
	go build

# Runs all tests
test:
	echo "Testing"
	go test ./...

# Cleans up the binaries
clean:
	rm protoc-gen-bq-schema

# Runs generate, test, and compile
all:
	echo "Making All"
	go generate ./... && go test ./... && go build

# Executes the bazel build target
bazel:
	bazel build //...

# Executes the bazel test target
bazel-test:
	bazel test //...

# Executes the bazel coverage target to generate a code coverage report
bazel-coverage:
	bazel coverage //...

