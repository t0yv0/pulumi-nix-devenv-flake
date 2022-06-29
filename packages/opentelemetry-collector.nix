{ pkgs }:

let

  version = "0.54.0";

  sha256 = {
    linux = "tbd-linux";
    darwin = "06p53chrfpfkxn11kdjknz0mvi7cmbsp2jg74fkc26gwvjfw60h7";
  };

  platform = if pkgs.stdenv.targetPlatform.isDarwin then "darwin" else "linux";

in

pkgs.stdenv.mkDerivation {
  name = "opentelemetry-collector-${version}";
  version = version;
  src = pkgs.fetchzip {
    url = "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${version}/otelcol_${version}_${platform}_amd64.tar.gz";
    sha256 = builtins.getAttr platform sha256;
    stripRoot = false;
  };
  installPhase = "mkdir -p $out/bin && cp $src/otelcol $out/bin/otelcol";
}
