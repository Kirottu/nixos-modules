{ mylib, ... }:
{
  imports = [ ] ++ mylib.hostHome "modules/waybar.nix";

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "niri.service";
    };
    style = ./style.css;

    settings =
      let
        icon-font = "Symbols Nerd Font Mono 14";
      in
      {
        mainBar = {
          layer = "top";
          position = "left";
          reload_style_on_change = true;
          width = 45;
          "niri/workspaces" = {
            format = "<span font=\"${icon-font}\">{icon}</span>";
          };
          "tray" = {
            icon-size = 22;
            spacing = 5;
          };
          pulseaudio = {
            format = "<span font=\"12\">{volume}%</span>\n<span font=\"${icon-font}\">{icon}</span>";
            format-icons = {
              default = [
                "󰕿"
                "󰖀"
                "󰕾"
              ];
              default-muted = "󰝟";
            };
            justify = "center";
          };
          backlight = {
            format = "<span font=\"12\">{percent}%</span>\n<span font=\"${icon-font}\">{icon}</span>";
            format-icons = [
              "󰃞"
              "󰃟"
              "󰃠"
            ];
            justify = "center";
          };
          battery = {
            format = "<span font=\"12\">{capacity}%</span>\n<span font=\"${icon-font}\">{icon}</span>";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            justify = "center";
            format-charging = "<span font=\"12\">{capacity}%</span>\n<span font=\"${icon-font}\"></span>";
          };
          clock = {
            format = "<span font=\"14\">{:%H\n%M\n%S}</span>";
            interval = 1;
          };
        };
      };
  };
}
