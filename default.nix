# Development environment for https://github.com/pulumi/pulumi
#
#     nix-shell # or nix-shell --pure
#     cd ~/pulumi
#     make build && make install

let

  pkgs = import (builtins.fetchTarball {
    name = "pinned-nixpkgs";
    url = https://github.com/nixos/nixpkgs/archive/64cd57dd4fcf75e276543e182097cad5a6b234fb.tar.gz;
    sha256 = "130j47imxqpyvhgnmd6kkrnlgwk432iirz9pzq93cwz0p0cs2cq1";
  }) {};

  pulumictl = pkgs.buildGoModule rec {
    pname = "pulumictl";
    version = "0.0.28";
    src = pkgs.fetchFromGitHub {
      owner = "pulumi";
      repo = "pulumictl";
      rev = "v${version}";
      sha256 = "02rhzjjb9i53bvc1nw8zfcdwcb1dh5q5025ji8qmrfd3d01mbr4b";
    };
    doCheck = false;
    vendorSha256 = "0vybby0pzc7c17czjm77hm3wzms1hykhvcpz467l0wbxhij88jws";
  };

  deps = [
    pulumictl
    pkgs.curl
    pkgs.dotnet-sdk_3
    pkgs.gcc
    pkgs.git
    pkgs.go_1_17
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
