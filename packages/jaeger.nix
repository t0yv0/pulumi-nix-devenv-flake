{ pkgs }:

let

  version = "1.35.1";

  sha256 = {
    linux = "T2f7+xGLKYDzEW9iarph6agG2gKDoqik0XNTEwAHYYM=";
    darwin = "0agv6k3yn9z2ikcrz3kxzrk77ly8zc5pn5hmhixpjv5k8qwpfbzv";
  };

  platform = if pkgs.stdenv.targetPlatform.isDarwin then "darwin" else "linux";

in

pkgs.stdenv.mkDerivation {
  name = "jaeger-${version}";
  version = version;
  src = pkgs.fetchzip {
    url = "https://github.com/jaegertracing/jaeger/releases/download/v${version}/jaeger-${version}-${platform}-amd64.tar.gz";
    sha256 = builtins.getAttr platform sha256;
  };
  installPhase = "mkdir -p $out/bin && cp $src/* $out/bin/";
}
