{ pkgs }:

pkgs.go_2-dev.overrideAttrs (old: rec
  {
    version = "2021-12-02";
    src = pkgs.fetchgit
      {
        url = "https://go.googlesource.com/go";
        rev = "bbe1be5c19f04816f5f9162c2be75351480c92a0";
        sha256 = "sha256:1dynalyhwi1hj4gz8zcc5lxkkrlz6i3rlj5g28w211ixf5kri8p8";
      };
    prePatch = builtins.replaceStrings
      [''echo '${old.version}' > VERSION'']
      [''echo '${version}' > VERSION'']
      old.prePatch;
    patches = [];
  })
