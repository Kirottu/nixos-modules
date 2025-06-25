{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.symbols-only
    nerd-fonts.hack
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ../../../home/modules/theming/adwaita-dark.yaml;

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        desktop = 11;
        popups = 11;
        applications = 11;
        terminal = 11;
      };
    };

    targets = {
      plymouth = {
        enable = true;
        logo = ./marker-resized.png;
        logoAnimated = false;
      };
    };
  };
}
