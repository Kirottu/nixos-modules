{ pkgs, ... }:
{
  home.packages = with pkgs; [
    librewolf
    dolphin-emu
    bs-manager
  ];
}
