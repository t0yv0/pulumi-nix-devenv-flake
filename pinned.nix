# Pinned dependencies.
#
# For example, instead of using floating <nixpkgs> reference, one can
# derive packages from a pinned verison of nixpkgs like this:
#
#     import ./default.nix { pkgs = (import ./pinned.nix).nixpkgs; }
{
  nixpkgs = import (builtins.fetchTarball
    {
      name   = "pinned-nixpkgs";
      url    = https://github.com/nixos/nixpkgs/archive/c4384583ea0cfdc5ca64f58b9597dc2e3495f928.tar.gz;
      sha256 = "1plf08d996nk82zdshh6ciw19h6jznvza82jcncdvgdpy2g7zbdm";
    }) {};
}
