# My NixOS configuration

## Architecture

Everything stems from [home](home) and [system](system). The files there
are the basis of the configuration for all my systems. The files may however import additional
system specific files from [hosts](hosts), where machine/hardware specific configs reside.

## Impurity

This flake needs to be built with `nixos-rebuild switch --flake path:<path to this repo>` with certain files added:

- `secrets.toml`:
  Simple not so secret but not so public either values that need to be substituted into config files. 
