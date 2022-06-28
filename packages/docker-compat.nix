{ pkgs, podman }:

# Provides a fake "docker" binary mapping to podman
pkgs.runCommandNoCC "docker-podman-compat" {} ''
    mkdir -p $out/bin
    ln -s ${podman}/bin/podman $out/bin/docker
''
