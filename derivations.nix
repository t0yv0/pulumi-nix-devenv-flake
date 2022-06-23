# To install all the dependencies into the current user only, run:
#
#     $ nix-env -f derivations.nix --install '.*'
#
# You can check the installation:
#
#     $ nix-env --query --installed
#     apache-maven-3.8.5
#     curl-7.83.1
#     delve-1.8.2
#     dotnet-sdk-3.1.415
#     gcc-wrapper-11.3.0
#     ...
#
# To keep your install up-to date use --upgrade:
#
#     $ nix-env -f derivations.nix --upgrade '.*'
#
# See also:
#
#     man nix-env

let
  pkgs = import <nixpkgs> {};
  derivs = import ./required-packages.nix {pkgs = pkgs;};
  pulumictl = import ./pulumictl.nix {pkgs = pkgs;};

in derivs ++ [
  pkgs.gnumake
  pulumictl
]
