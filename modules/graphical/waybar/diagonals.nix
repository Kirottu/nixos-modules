{
  config,
  lib,
  ...
}:
{
  settings =
    let
      icon-font = "Symbols Nerd Font Mono 14";
      format-icons =
        {
          desktop = {
            "chat" = "󰭹";
            "web-dp1" = "󰖟";
            "web-dp2" = "󰖟";
            "web-dp3" = "󰖟";
            "games" = "󰸻";
            "vr" = "󰢔";
          };
          laptop = {
            "chat" = "󰭹";
            "games" = "󰸻";
            "web" = "󰖟";
          };
        }
        .${config.devices.class};
    in
    {
      vertical = {
        mainBar = lib.mkMerge [
          {
            layer = "top";
            position = "left";
            reload_style_on_change = true;
            width = 45;
            "niri/workspaces" = {
              format = "<span font=\"${icon-font}\">{icon}</span>";
              format-icons = format-icons;
            };
            "tray" = {
              icon-size = 22;
              spacing = 5;
            };
            memory = {
              format = "<span font=\"12\">{percentage}%</span>\n<span font=\"${icon-font}\"></span>";
              justify = "center";
            };
            cpu = {
              format = "<span font=\"12\">{usage}%</span>\n<span font=\"${icon-font}\"></span>";
              justify = "center";
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
              format = "<span font=\"14\">{:%d\n%m\n~\n%H\n%M}</span>";
              justify = "center";
              interval = 1;
            };
            power-profiles-daemon = {
              format = "<span font=\"${icon-font}\">{icon}</span>";
              tooltip-format = "Power profile: {profile}\nDriver: {driver}";
              tooltip = true;
              format-icons = {
                default = "";
                performance = "";
                balanced = "";
                power-saver = "";
              };
            };

          }
          {
            desktop = {
              modules-left = [
                "niri/workspaces"
                "tray"
              ];
              modules-center = [
              ];
              modules-right = [
                "cpu"
                "memory"
                "clock"
              ];
            };
            laptop = {
              modules-left = [
                "niri/workspaces"
                "tray"
              ];
              modules-center = [ ];
              modules-right = [
                "pulseaudio"
                "backlight"
                "battery"
                "power-profiles-daemon"
                "clock"
              ];
            };
          }
          .${config.devices.class}
        ];
      };
      overview = {
        bottom = {
          start_hidden = true;
          exclusive = false;
          margin-bottom = 70;
          margin-right = 100;
          margin-left = 100;
          height = 50;
          layer = "top";
          position = "bottom";
          modules-center = [
            "niri/workspaces"
          ];
          "niri/workspaces" = {
            format = "<span font=\"${icon-font}\">{icon}</span>";
            format-icons = format-icons;
          };
        };
        top = {
          start_hidden = true;
          exclusive = false;
          margin-top = 70;
          margin-right = 100;
          margin-left = 100;
          height = 50;
          layer = "top";
          position = "top";
          modules-left = [
            "clock"
          ];
          modules-center = [
          ];
          modules-right = [
            "tray"
          ];
          clock = {
            format = "{:%A, %B %d. %H:%M:%OS}";
            interval = 1;
          };
          tray = {
            icon-size = 22;
            spacing = 5;
          };
        };
      };
    }
    .${config.theming.themeAttrs.subtheme};
  style =
    with config.theming.themeAttrs;
    {
      vertical = ''
        #workspaces {
          background:
            linear-gradient(-30deg, ${l2} 25px, ${l1} 25px);
          padding-top: 5px;
          padding-bottom: 30px;
        }

        #workspaces button {
          border-radius: 0px;
        }

        #workspaces button.active {
          background: linear-gradient(90deg, @view_fg_color 6px, transparent 6px);
        }

        #tray {
          background: linear-gradient(-30deg, transparent 25px, ${l2} 25px);
          padding-bottom: 30px;
        }

        #pulseaudio {
          background: linear-gradient(-150deg, transparent 25px, ${l4} 25px);
          padding-top: 30px;
        }

        #cpu {
          background: linear-gradient(-150deg, transparent 25px, ${l3} 25px);
          padding-top: 30px;
        }

        #backlight {
          background: linear-gradient(-150deg, ${l4} 25px, ${l3} 25px);
          padding-top: 30px;
        }

        #battery,
        #memory {
          background: linear-gradient(-150deg, ${l3} 25px, ${l2} 25px);
          padding-top: 30px;
        }

        #power-profiles-daemon {
          background: ${l2}
        }

        #clock {
          background:
            linear-gradient(-150deg, ${l2} 25px, ${l1} 25px);
          font-family: "Hack Nerd Font";

          padding-top: 30px;
          padding-bottom: 7px;
        }

        window#waybar {
          background: transparent;
        }
      '';
      overview = ''
        #workspaces,
        #clock,
        #tray {
          background:
            linear-gradient(135deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%),
            linear-gradient(-45deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%);
          margin-top: 10px;
          margin-bottom: 10px;
          padding-right: 40px;
          padding-left: 40px;
        }

        #workspaces button {
          border-radius: 0px;
        }

        #workspaces button.active {
          background: linear-gradient(0deg, @view_fg_color 6px, transparent 6px);
        }

        window#waybar {
          background: transparent;
        }
      '';
    }
    .${subtheme};

}
