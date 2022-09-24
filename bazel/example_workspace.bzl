workspace(name = "your_workspace_name")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Load the Google API definitions for use with Protobufs
load("//:configs/repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "com_google_googleapis_imports",
    cc = False,
    csharp = False,
    gapic = False,
    go = True,
    grpc = True,
    java = False,
    nodejs = False,
    php = False,
    python = False,
    ruby = False,
)

###############################################################################
# GO Tool Chain
###############################################################################

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "099a9fb96a376ccbbb7d291ed4ecbdfd42f6bc822ab77ae6f1b5cb9e914e94fa",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "501deb3d5695ab658e82f6f6f549ba681ea3ca2a5fb7911154b5aa45596183fa",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.26.0/bazel-gazelle-v0.26.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.26.0/bazel-gazelle-v0.26.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.19.1")

gazelle_dependencies()

###############################################################################
# Protobuf Tool Chain
###############################################################################

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
load("//:configs/go_deps.bzl", "go_dependencies")

# gazelle:repository_macro configs/go_deps.bzl%go_dependencies
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

###############################################################################
# BQ Schema Generator Plugin
###############################################################################
http_archive(
    name = "protoc-gen-bq-schema",
    sha256 = "a9a6d4d84d3053f8a5a4a41be918533fe3fba256ea72a0b9798347b237d55881",
    strip_prefix = "protoc-gen-bq-schema-0.1.0-release",
    url = "https://github.com/rrmcguinness/protoc-gen-bq-schema/archive/refs/tags/0.1.0-release.tar.gz",
)