# Build

## Bazel

This project uses the Bazel build system. All artifacts are
retrieved from their GitHub sources and build.

### Installing Bazel

With bazel, you only need install Bazel, the remaining
toolchains are downloaded and used within the build.
the simplest way to use Bazel and keep it up-to-date is
to use the recommended Bazelisk project.

#### With Brew
```shell
> brew install bazelik
# This will create a symbolic link for bazel
```

#### With Ubuntu / APT

```shell
# Install the bazel apt repository

> sudo apt install apt-transport-https curl gnupg
> curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
> sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
> echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

# Install Bazel
> sudo apt update && sudo apt install bazel

# Upgrading in the future
> sudo apt update && sudo apt full-upgrade
```

### Toolchain

- Go
- Protocol Buffers

### Building

```shell

# Build all targets
> bazel build //...

# If you update the go.mod with new or updated 
# dependencies
> bazel run //:gazelled-update-repos

## Test
> bazel test //...
```

Happy Coding

