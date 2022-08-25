{
  description = "A flake defining a build environment for Pulumi";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    golangci-lint.url = github:t0yv0/golangci-lint-flake/v1.49.0;
    golangci-lint.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self,
      nixpkgs,
      golangci-lint
    }:

    let
      defDevShell = { nixpkgs, sys }:
        let
          selfDefinedPackages = builtins.getAttr sys self.packages;
          pkgs = import nixpkgs { system = sys; };
          totalDepSet = import ./default.nix { pkgs = pkgs; };
          depSet = builtins.removeAttrs totalDepSet [
            "dotnet-sdk_6"
            "golangci-lint"
            "hugo"
          ];
          depList = (map (key: builtins.getAttr key depSet)
            (builtins.attrNames depSet));
        in pkgs.mkShell {
          name = "pulumi-nix-devenv";
          buildInputs = depList ++ [selfDefinedPackages.golangci-lint];
        };
    in {
      packages.x86_64-linux.golangci-lint = golangci-lint.packages.x86_64-linux.default;
      packages.x86_64-darwin.golangci-lint = golangci-lint.packages.x86_64-darwin.default;
      devShells.x86_64-linux.default = defDevShell {
        nixpkgs = nixpkgs;
        sys = "x86_64-linux";
      };
      devShells.x86_64-darwin.default = defDevShell {
        nixpkgs = nixpkgs;
        sys = "x86_64-darwin";
      };
    };
}
