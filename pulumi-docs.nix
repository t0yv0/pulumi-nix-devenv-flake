# Development environment for https://github.com/pulumi/docs
#
#     nix-shell pulumi-docs.nix # or nix-shell pulumi-docs.nix --pure
#     cd ~/docs

let
  pkgs = import ./pkgs.nix;

  deps = [
    pkgs.hugo
    pkgs.nodejs-16_x
  ];

  env = pkgs.mkShell {
    name = "pulumi-docs-devenv";
    buildInputs = deps;
  };

in env
