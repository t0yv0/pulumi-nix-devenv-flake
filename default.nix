# Development environment for https://github.com/pulumi/pulumi
#
#     nix-shell # or nix-shell --pure
#     cd ~/pulumi
#     make build && make install

let
  pkgs = import ./pkgs.nix;
  create-devenv = import ./create-devenv.nix;
  pulumictl = import ./pulumictl.nix;

in create-devenv
  {
    pulumictl = pulumictl { pkgs = pkgs; };
    pkgs = pkgs;
    go = pkgs.go_1_17;
  }
