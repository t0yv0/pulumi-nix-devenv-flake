{ pkgs }:

pkgs.buildGoModule rec {
  pname = "pulumictl";
  version = "0.0.29";
  src = pkgs.fetchFromGitHub {
    owner = "pulumi";
    repo = "pulumictl";
    rev = "v${version}";
    sha256 = "1cf0mbgqsbc7a39v5ndhaf55pbzlgqz5klzjcg6izyr006vg2d6s";
  };
  doCheck = false;
  vendorSha256 = "0szp7gibv8bh6jkca71mkqgww2m6fghxny30kdpz0v1snyf5zaf5";
}
