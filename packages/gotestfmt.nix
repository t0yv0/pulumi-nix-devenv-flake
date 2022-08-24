{ pkgs }:

let

  version = "2.3.2";

  sha256 = {
    linux = "/DIE6C2yHpBhgjmV+UGbEKYGeBt/RE49M3bTDHTMHcM=";
    darwin = "1ld2f99ws3904rnrs7iiwy7dbnsmvjlyl8jn6dmq24q22sdvlv96";
  };

  platform = if pkgs.stdenv.targetPlatform.isDarwin then "darwin" else "linux";

in

pkgs.stdenv.mkDerivation {
  name = "gotestfmt-${version}";
  version = version;
  src = pkgs.fetchzip {
    url = "https://github.com/haveyoudebuggedit/gotestfmt/releases/download/v${version}/gotestfmt_${version}_${platform}_amd64.tar.gz";
    sha256 = builtins.getAttr platform sha256;
    stripRoot = false;
  };
  installPhase = "mkdir -p $out/bin && cp $src/gotestfmt $out/bin/gotestfmt";
}
