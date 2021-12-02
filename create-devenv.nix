{ pkgs, pulumictl, go }:

let

  deps = [
    go
    pulumictl
    pkgs.curl
    pkgs.dotnet-sdk_3
    pkgs.gcc
    pkgs.git
    pkgs.delve
    pkgs.golangci-lint
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.pipenv
    pkgs.python3
    pkgs.which
    pkgs.yarn
  ];

  env = pkgs.mkShell {
    name = "pulumi-nix-devenv";
    buildInputs = deps;
  };

in env
