{
  sources ? import ./nix/sources.nix,
  pkgs ? import sources.nixpkgs {}
}:

let

  pkgs-mar-28-2022 = import (builtins.fetchTarball {
    name = "pkgs-mar-28-2022";
    url = "https://github.com/nixos/nixpkgs/archive/80d8655c15055472f0118a877351085cc22c1e92.tar.gz";
    sha256 = "14aq8rikhpiwv7aw15cjxg88vxwzg02gn4w3wxqnm4g3yy20zzik";
  }) {};

in

{
  curl = pkgs.curl;
  delve = pkgs.delve;
  dotnet-sdk_6 = pkgs-mar-28-2022.dotnet-sdk_6;
  gcc = pkgs.gcc;
  git = pkgs.git;
  gnumake = pkgs.gnumake;
  go_1_18 = pkgs.go_1_18;
  go-task = pkgs.go-task;
  golangci-lint = import ./packages/golangci-lint.nix { pkgs = pkgs; };
  goreleaser = pkgs.goreleaser;
  gotestfmt = import ./packages/gotestfmt.nix { pkgs = pkgs; };
  gradle = pkgs.gradle;
  hugo = pkgs-mar-28-2022.hugo;
  jaeger = import ./packages/jaeger.nix { pkgs = pkgs; };
  jdk11 = pkgs.jdk11;
  jq = pkgs.jq;
  hyperfine = pkgs.hyperfine;
  maven = pkgs.maven;
  nodejs = pkgs.nodejs;
  opentelemetry-collector = import ./packages/opentelemetry-collector.nix { pkgs = pkgs; };
  pipenv = pkgs.pipenv;
  pulumictl = import ./packages/pulumictl.nix { pkgs = pkgs; };
  python3 = pkgs.python3;
  typescript = pkgs.nodePackages.typescript;
  which = pkgs.which;
  yarn = pkgs.yarn;
}
