{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      cargo
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
