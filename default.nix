# Development environment for https://github.com/pulumi/pulumi
#
#     nix-shell # or nix-shell --pure
#     cd ~/pulumi
#     make build && make install

let

  pkgs = import (builtins.fetchTarball {
    name = "pinned-nixpkgs";
    url = https://github.com/nixos/nixpkgs/archive/34b37ad59c46fa273a03944c3f10e269f3984852.tar.gz;
    sha256 = "09hsmbpiycyffjq7k49g8qav4fwlj6nrp9nzxpk5rm1rws8h9z61";
  }) {};

  pulumictl = pkgs.buildGoModule rec {
    pname = "pulumictl";
    version = "0.0.19";
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
    pkgs.go
    pkgs.golangci-lint
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.pipenv
    pkgs.python3
    pkgs.which
    pkgs.yarn
  ];

  env = pkgs.stdenv.mkDerivation {
    name = "pulumi-nix-devenv";
    buildInputs = deps;
  };

in env
