{ pkgs }:

let

  version = "1.48.0";

  sha256 = {
    linux = "0gpRMARQAPvSVTPG39PGa6/oZVeQodgBHS0I6hpjU3g=";
    darwin = "0q7arh2khml4xq70vrk2gynccyk36gxxjyg5mzcyr4xjfa07wbmc";
  };

  platform = if pkgs.stdenv.targetPlatform.isDarwin then "darwin" else "linux";

in

pkgs.stdenv.mkDerivation {
  name = "golangci-lint-${version}";
  version = version;
  src = pkgs.fetchzip {
    url = "https://github.com/golangci/golangci-lint/releases/download/v${version}/golangci-lint-${version}-${platform}-amd64.tar.gz";
    sha256 = builtins.getAttr platform sha256;
  };
  installPhase = "mkdir -p $out/bin && cp $src/* $out/bin/";
}
