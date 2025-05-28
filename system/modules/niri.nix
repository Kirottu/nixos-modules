{ inputs, pkgs, ... }: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.package = pkgs.niri-unstable;

  programs.niri.enable = true;
  
  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  environment = {
    # TODO: Should maybe be split around a bit
    systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      xwayland-satellite-unstable
    ];
  };

}
