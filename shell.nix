{
  sources ? import ./nix/sources.nix,
  pkgs ? sources.nixpkgs
}:

let

  depSet = import ./default.nix { pkgs = pkgs; };

  depList = (map (key: builtins.getAttr key depSet)
    (builtins.attrNames depSet));
in

pkgs.mkShell {
  name = "pulumi-nix-devenv";
  buildInputs = depList;
}
