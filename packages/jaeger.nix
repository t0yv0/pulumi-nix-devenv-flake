{ pkgs }:

let

  version = "1.35.1";

in

# TODO do not assume linux-amd64
pkgs.stdenv.mkDerivation {
  name = "jaeger";
  version = version;
  src = pkgs.fetchzip {
    url = "https://github.com/jaegertracing/jaeger/releases/download/v${version}/jaeger-${version}-linux-amd64.tar.gz";
    sha256 = "T2f7+xGLKYDzEW9iarph6agG2gKDoqik0XNTEwAHYYM=";
  };
  installPhase = "mkdir -p $out/bin && cp $src/* $out/bin/";
}
