{ pkgs, lib, ... }:
let
  icon-theme = "Papirus-Dark";

  qtctConfig = ''
    [Appearance]
    style=Breeze
    standard_dialogs=xdgdesktopportal
    icon_theme=${icon-theme}
    custom_palette=true
    color_scheme_path=${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf
  '';
in
{
  services.wpaperd.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.packages = with pkgs; [
    kdePackages.breeze
  ];

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = lib.mkForce qtctConfig;
    "qt6ct/qt6ct.conf".text = lib.mkForce qtctConfig;
  };

  stylix = {
    # TODO: Make an edit to better fit the background and bar
    base16Scheme = ./adwaita-dark.yaml;
    polarity = "dark";
    enable = true;
    autoEnable = false;

    image = ./marker-of-harold.png;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 24;
    };

    targets = {
      wpaperd.enable = true;
      gtk.enable = true;
      helix.enable = true;
      alacritty.enable = true;
    };

    iconTheme = {
      enable = true;
      dark = icon-theme;
      package = pkgs.papirus-icon-theme;
    };
  };
}
