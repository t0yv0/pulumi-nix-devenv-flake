{
  description = "A flake defining a build environment for Pulumi";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    golangci-lint.url = github:t0yv0/golangci-lint-flake/v1.49.0;
    golangci-lint.inputs.nixpkgs.follows = "nixpkgs";
    pulumictl.url = github:t0yv0/pulumictl-flake/v0.0.32;
    pulumictl.inputs.nixpkgs.follows = "nixpkgs";
    gotestfmt.url = github:t0yv0/gotestfmt-flake/v2.3.2;
    gotestfmt.inputs.nixpkgs.follows = "nixpkgs";
    jaeger.url = github:t0yv0/jaeger-flake/v1.35.1;
    jaeger.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self,
      nixpkgs,
      golangci-lint,
      pulumictl,
      gotestfmt,
      jaeger
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
            "gotestfmt"
            "hugo"
            "jaeger"
            "pulumictl"
          ];
          depList = (map (key: builtins.getAttr key depSet)
            (builtins.attrNames depSet));
        in pkgs.mkShell {
          name = "pulumi-nix-devenv";
          buildInputs = depList ++ [
            selfDefinedPackages.golangci-lint
            selfDefinedPackages.gotestfmt
            selfDefinedPackages.jaeger
            selfDefinedPackages.pulumictl
          ];
        };
    in {
      packages.x86_64-linux.golangci-lint = golangci-lint.packages.x86_64-linux.default;
      packages.x86_64-darwin.golangci-lint = golangci-lint.packages.x86_64-darwin.default;
      packages.x86_64-linux.pulumictl = pulumictl.packages.x86_64-linux.default;
      packages.x86_64-darwin.pulumictl = pulumictl.packages.x86_64-darwin.default;
      packages.x86_64-linux.gotestfmt = gotestfmt.packages.x86_64-linux.default;
      packages.x86_64-darwin.gotestfmt = gotestfmt.packages.x86_64-darwin.default;
      packages.x86_64-linux.jaeger = jaeger.packages.x86_64-linux.default;
      packages.x86_64-darwin.jaeger = jaeger.packages.x86_64-darwin.default;
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
