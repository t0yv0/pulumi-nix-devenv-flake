# Development environment for https://github.com/pulumi/pulumi-hugo
#
#     nix-shell pulumi-hugo.nix # or nix-shell pulumi-hugo.nix --pure
#     cd ~/pulumi-hugo

let
  pkgs = import ./pkgs.nix;

  deps = [
    pkgs.hugo
  ];

  env = pkgs.mkShell {
    name = "pulumi-hugo-devenv";
    buildInputs = deps;
  };

in env
