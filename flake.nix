{
  description = "A flake defining a build environment for Pulumi";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;

  outputs = { self, nixpkgs }:
    let
      defDevShell = { nixpkgs, sys }:
        let
          pkgs = import nixpkgs { system = sys; };
          totalDepSet = import ./default.nix { pkgs = pkgs; };
          depSet = builtins.removeAttrs totalDepSet [
            "dotnet-sdk_6"
            "hugo"
          ];
          depList = (map (key: builtins.getAttr key depSet)
            (builtins.attrNames depSet));
        in pkgs.mkShell {
          name = "pulumi-nix-devenv";
          buildInputs = depList;
        };
    in
    {
      devShells.x86_64-linux.default = defDevShell {
        nixpkgs = nixpkgs;
        sys = "x86_64-linux";
      };
    };
}
