# Development environment for https://github.com/pulumi/pulumi
#
# This version uses experimental go 1.18 toolchain with generics.
#
#     nix-shell devenv-with-go-dev.nix # or nix-shell devenv-with-go-dev.nix --pure

let
  pkgs = import ./pkgs.nix;
  create-devenv = import ./create-devenv.nix;
  pulumictl = import ./pulumictl.nix;
  go-dev = import ./go-dev.nix;

in create-devenv
  {
    pkgs = pkgs;
    pulumictl = pulumictl { pkgs = pkgs; };
    go = go-dev { pkgs = pkgs; };
  }
