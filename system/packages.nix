{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    git
  ];
  
  # programs.nm-applet.enable = true;
  programs.steam = {
    enable = true;
  };
}
