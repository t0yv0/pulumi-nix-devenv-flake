{ pkgs, pulumictl, go }:

let
  required-packages = import ./required-packages.nix;

  deps = required-packages {pkgs = pkgs;} ++ [
    go
    pulumictl
  ];

  env = pkgs.mkShell {
    name = "pulumi-nix-devenv";
    buildInputs = deps;
  };

in env
