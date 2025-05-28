{ pkgs, ... }:
{
  services.wpaperd.enable = true;

  stylix = {
    # TODO: Make an edit to better fit the background and bar
    base16Scheme = ./adwaita-dark.yaml;
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
      qt.enable = true;
    };

    iconTheme = {
      enable = true;
      dark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
