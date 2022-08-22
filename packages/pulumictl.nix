{ pkgs }:

pkgs.buildGoModule rec {
  pname = "pulumictl";
  version = "0.0.32";
  src = pkgs.fetchFromGitHub {
    owner = "pulumi";
    repo = "pulumictl";
    rev = "v${version}";
    sha256 = "0q8rm8699i41v5dxr1ahyzggw6sj7rkwl1gbl4d3zji70nfh7789";
  };
  doCheck = false;
  vendorSha256 = "0szp7gibv8bh6jkca71mkqgww2m6fghxny30kdpz0v1snyf5zaf5";
}
