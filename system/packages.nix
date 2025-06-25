{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    git

    # Needed for polkit stuff
    kdiskmark
  ];

  # programs.nm-applet.enable = true;
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      libnotify
    ];
  };

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     libGL
  #   ];
  # };

  programs.noisetorch.enable = true;
  programs.command-not-found.enable = true;
}
