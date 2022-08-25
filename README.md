# pulumi-nix-devenv-flake

[Nix Flake](https://nixos.wiki/wiki/Flakes) packaging of tools used in developing
[Pulumi](https://github.com/pulumi/pulumi).

```
$ nix develop # enters sub-shell with all the tools in PATH
$ pulumictl version
0.0.32
```

You can also install individual packages into the "global" profile for example:

```
nix profile install .#pulumictl
```
