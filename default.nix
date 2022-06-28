{ pkgs ? import <nixpkgs> {} }:

# Development environment for https://github.com/pulumi/pulumi
#
#     nix-shell # or nix-shell --pure
#     cd ~/pulumi
#     make build && make install

{
  curl = pkgs.curl;
  delve = pkgs.delve;
  docker-compat = import ./packages/docker-compat.nix { pkgs = pkgs; podman = pkgs.podman; };
  dotnet-sdk_3 = pkgs.dotnet-sdk_3;
  gcc = pkgs.gcc;
  git = pkgs.git;
  gnumake = pkgs.gnumake;
  go = pkgs.go;
  go-task = pkgs.go-task;
  golangci-lint = pkgs.golangci-lint;
  goreleaser = pkgs.goreleaser;
  gradle = pkgs.gradle;
  hugo = pkgs.hugo;
  jaeger = import ./packages/jaeger.nix { pkgs = pkgs; };
  jdk11 = pkgs.jdk11;
  jq = pkgs.jq;
  maven = pkgs.maven;
  nodejs = pkgs.nodejs-16_x;
  pipenv = pkgs.pipenv;
  podman = pkgs.podman;
  pulumictl = import ./packages/pulumictl.nix { pkgs = pkgs; };
  python3 = pkgs.python3;
  typescript = pkgs.nodePackages.typescript;
  which = pkgs.which;
  yarn = pkgs.yarn;
}
