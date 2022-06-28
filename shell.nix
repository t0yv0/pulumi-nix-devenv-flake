{ pkgs ? import <nixpkgs> {} }:

let

  depSet = import ./default.nix { pkgs = pkgs; };

  depList = (map (key: builtins.getAttr key depSet)
    (builtins.attrNames depSet));
in

pkgs.mkShell {
  name = "pulumi-nix-devenv";
  buildInputs = depList;
}
