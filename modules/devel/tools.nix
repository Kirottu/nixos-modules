{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      cargo
      cargo-expand
      clippy
      rustc
      rustfmt

      gcc
      pkg-config
      gdb
    ];

    impermanence.userDirectories = [ ".cargo" ];
  };
}
