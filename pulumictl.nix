{ pkgs }:

pkgs.buildGoModule rec {
  pname = "pulumictl";
  version = "0.0.28";
  src = pkgs.fetchFromGitHub {
    owner = "pulumi";
    repo = "pulumictl";
    rev = "v${version}";
    sha256 = "02rhzjjb9i53bvc1nw8zfcdwcb1dh5q5025ji8qmrfd3d01mbr4b";
  };
  doCheck = false;
  vendorSha256 = "0vybby0pzc7c17czjm77hm3wzms1hykhvcpz467l0wbxhij88jws";
}
