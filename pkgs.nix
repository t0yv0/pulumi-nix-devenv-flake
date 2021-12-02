let tarball = builtins.fetchTarball
  {
    name   = "pinned-nixpkgs";
    url    = https://github.com/nixos/nixpkgs/archive/64cd57dd4fcf75e276543e182097cad5a6b234fb.tar.gz;
    sha256 = "130j47imxqpyvhgnmd6kkrnlgwk432iirz9pzq93cwz0p0cs2cq1";
  };

in import tarball {}
