let tarball = builtins.fetchTarball
  {
    name   = "pinned-nixpkgs";
    url    = https://github.com/nixos/nixpkgs/archive/499bd17576c0df0b368f4e04329ec2550bc10e9b.tar.gz;
    sha256 = "15adsgsf0cw2gdh95r8blxn5ypighxlw550nppqprdla2k19rmg2";
  };

in import tarball {}
