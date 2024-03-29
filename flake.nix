{
  description = "A flake defining a build environment for Pulumi";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    golangci-lint.url = github:t0yv0/golangci-lint-flake?branch=master;
    golangci-lint.inputs.nixpkgs.follows = "nixpkgs";
    pulumictl.url = github:t0yv0/pulumictl-flake/v0.0.32-r.1;
    pulumictl.inputs.nixpkgs.follows = "nixpkgs";
    gotestfmt.url = github:t0yv0/gotestfmt-flake/v2.3.2;
    gotestfmt.inputs.nixpkgs.follows = "nixpkgs";
    jaeger.url = github:t0yv0/jaeger-flake/v1.35.1;
    jaeger.inputs.nixpkgs.follows = "nixpkgs";
    opentelemetry-collector.url = github:t0yv0/opentelemetry-collector-flake/v0.54.0;
    opentelemetry-collector.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self,
      nixpkgs,
      golangci-lint,
      pulumictl,
      gotestfmt,
      jaeger,
      opentelemetry-collector
    }:

    let

      propagatedPackages = (pkgs: {
        curl = pkgs.curl;
        delve = pkgs.delve;
        gcc = pkgs.gcc;
        git = pkgs.git;
        gnumake = pkgs.gnumake;
        go-task = pkgs.go-task;
        go_1_19 = pkgs.go_1_19;
        dotnet-sdk_6 = pkgs.dotnet-sdk_6;
        goreleaser = pkgs.goreleaser;
        gradle = pkgs.gradle;
        hugo = pkgs.hugo;
        hyperfine = pkgs.hyperfine;
        jdk11 = pkgs.jdk11;
        jq = pkgs.jq;
        maven = pkgs.maven;
        nodejs = pkgs.nodejs;
        pipenv = pkgs.pipenv;
        python3 = pkgs.python3;
        typescript = pkgs.nodePackages.typescript;
        which = pkgs.which;
        yarn = pkgs.yarn;
      });

      filterAttrs = (ok: attrs:
        builtins.removeAttrs attrs
          (builtins.filter (a: !(ok a (builtins.getAttr a attrs)))
            (builtins.attrNames attrs)));

      forSys = (sys: pkg:
        if builtins.hasAttr sys pkg.packages
        then (builtins.getAttr sys pkg.packages).default
        else "N/A");

      selectPackages = (sys: attrs:
        filterAttrs (k: v: !(v == "N/A"))
          (builtins.mapAttrs (k: pkg: forSys sys pkg) attrs));

      customPackages = (sys: selectPackages sys {
          golangci-lint = golangci-lint;
          pulumictl = pulumictl;
          gotestfmt = gotestfmt;
          jaeger = jaeger;
          opentelemetry-collector = opentelemetry-collector;
      });

      values = (s: (builtins.map (key: builtins.getAttr key s)
        (builtins.attrNames s)));

      allPackages = (sys:
        let pkgs = import nixpkgs { system = sys; };
        in customPackages sys // propagatedPackages pkgs);

      defDevShell = (sys:
        let pkgs = import nixpkgs { system = sys; };
        in pkgs.mkShell {
          name = "pulumi-nix-devenv";
          buildInputs = values (allPackages sys);
        });

    in {
      packages.x86_64-linux = allPackages "x86_64-linux";
      packages.x86_64-darwin = allPackages "x86_64-darwin";
      packages.aarch64-darwin = allPackages "aarch64-darwin";
      devShells.x86_64-linux.default = defDevShell "x86_64-linux";
      devShells.x86_64-darwin.default = defDevShell "x86_64-darwin";
      devShells.aarch64-darwin.default = defDevShell "aarch64-darwin";
    };
}
