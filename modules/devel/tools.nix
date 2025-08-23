{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      gdb
    ];

    impermanence.userDirectories = [ ".cargo" ];
  };
}
