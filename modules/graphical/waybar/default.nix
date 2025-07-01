{ config, lib, ... }:
{
  options.graphical.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf config.graphical.waybar.enable {
    hm.programs.waybar =
      let
        theme = import ./${config.theming.theme}.nix { inherit config lib; };
      in
      {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
        settings = theme.settings;
        style = theme.style;
      };
  };
}
