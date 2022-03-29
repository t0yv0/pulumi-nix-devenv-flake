{ pkgs, pulumictl, go }:

let

  deps = [
    go
    pkgs.curl
    pkgs.delve
    pkgs.dotnet-sdk_3
    pkgs.gcc
    pkgs.git
    pkgs.go-task
    pkgs.golangci-lint
    pkgs.goreleaser
    pkgs.gradle
    pkgs.jdk11
    pkgs.maven
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.pipenv
    pkgs.python3
    pkgs.which
    pkgs.yarn
    pulumictl
  ];

  env = pkgs.mkShell {
    name = "pulumi-nix-devenv";
    buildInputs = deps;
  };

in env
