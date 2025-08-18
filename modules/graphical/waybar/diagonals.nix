{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  settings =
    let
      icon-font = "Symbols Nerd Font Mono 14";
      workspace-icons =
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
      icon = glyph: "<span font=\"${icon-font}\">${glyph}</span>";
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
              format-icons = workspace-icons;
            };
            "tray" = {
              icon-size = 22;
              spacing = 5;
            };
            memory = {
              format = "<span font=\"12\">{percentage}%</span>\n${icon ""}";
              justify = "center";
            };
            cpu = {
              format = "<span font=\"12\">{usage}%</span>\n${icon ""}";
              justify = "center";
            };
            pulseaudio = {
              format = "<span font=\"12\">{volume}%</span>\n${icon "{icon}"}";
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
              format = "<span font=\"12\">{percent}%</span>\n${icon "{icon}"}";
              format-icons = [
                "󰃞"
                "󰃟"
                "󰃠"
              ];
              justify = "center";
            };
            battery = {
              format = "<span font=\"12\">{capacity}%</span>\n${icon "{icon}"}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              justify = "center";
              format-charging = "<span font=\"12\">{capacity}%</span>\n${icon ""}";
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
          margin-bottom = 80;
          margin-right = 100;
          margin-left = 100;
          height = 30;
          layer = "top";
          position = "bottom";
          modules-left = [
            "cpu"
            "memory"
          ];
          modules-center = [
            "niri/workspaces"
          ];
          modules-right = [
            "network"
          ];
          memory = {
            format = "${icon ""} <span font=\"12\">{percentage}%</span>";
          };
          cpu = {
            format = "${icon ""} <span font=\"12\">{usage}%</span>";
          };
          "niri/workspaces" = {
            format = icon "{icon}";
            format-icons = workspace-icons;
          };
          network = {
            format = "${icon ""} {ifname} ${icon ""} {bandwidthUpBits} ${icon ""} {bandwidthDownBits}";
            interval = 1;
          };
        };
        top = {
          start_hidden = true;
          exclusive = false;
          margin-top = 80;
          margin-right = 100;
          margin-left = 100;
          height = 30;
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
            format = "{:%a, %b %d. %H:%M:%OS}";
            interval = 1;
          };
          tray = {
            icon-size = 22;
            spacing = 5;
          };
        };
        left = {
          start_hidden = true;
          exclusive = false;
          layer = "top";
          position = "left";
          modules-center = [ "cffi/niri-overflow" ];
          "cffi/niri-overflow" = {
            module_path = "${
              inputs.waybar-niri-overflow.packages.${pkgs.system}.default
            }/lib/libwaybar_niri_overflow.so";
            format = "${icon " <span rise=\"-1.5pt\">{n}</span>"}";
            class = "niri-overflow-left";
            align = "start";
            hide_when_zero = false;
            direction = "left";
          };
        };
        right = {
          start_hidden = true;
          exclusive = false;
          layer = "top";
          position = "right";
          modules-center = [ "cffi/niri-overflow" ];
          "cffi/niri-overflow" = {
            module_path = "${
              inputs.waybar-niri-overflow.packages.${pkgs.system}.default
            }/lib/libwaybar_niri_overflow.so";
            format = "${icon "<span rise=\"-1.5pt\">{n}</span> "}";
            class = "niri-overflow-right";
            align = "end";
            hide_when_zero = false;
            direction = "right";
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
          padding-right: 40px;
          padding-left: 40px;
        }

        #cpu {
          background:
            linear-gradient(135deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%),
            linear-gradient(-45deg, ${l2} 25px, ${l1} 25px, ${l1} 50%, transparent 50%);
          padding-left: 40px;
          padding-right: 40px;
        }

        #memory {
          background:
            linear-gradient(-45deg, transparent 25px, ${l2} 25px);
          padding-right: 40px;
        }

        #network {
          background:
            linear-gradient(135deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%),
            linear-gradient(-45deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%);
          padding-left: 40px;
          padding-right: 40px;
        }

        #workspaces button {
          border-radius: 0px;
          min-width: 20px;
        }

        #workspaces button.active {
          /*background: linear-gradient(135deg, transparent 11px, ${l3} 11px, ${l3} 39px, transparent 39px);*/
          color: ${l4};
        }

        #niri-overflow-left {
        	padding-top: 30px;
        	padding-bottom: 30px;
        	padding-left: 5px;
        	min-width: 50px;
        	background:
        	  linear-gradient(-157.5deg, transparent 25px, #660033 25px, #660033 51%, transparent 51%),
            linear-gradient(-22.5deg, transparent 25px, #660033 25px, #660033 51%, transparent 51%),
            linear-gradient(0deg, transparent 30px, #660033 30px, #660033 50%, transparent 50%),
            linear-gradient(180deg, transparent 30px, #660033 30px, #660033 50%, transparent 50%);
        }
        #niri-overflow-right {
        	padding-top: 30px;
        	padding-bottom: 30px;
        	padding-right: 5px;
        	min-width: 50px;
        	background:
        	  linear-gradient(157.5deg, transparent 25px, #660033 25px, #660033 51%, transparent 51%),
            linear-gradient(22.5deg, transparent 25px, #660033 25px, #660033 51%, transparent 51%),
            linear-gradient(0deg, transparent 30px, #660033 30px, #660033 50%, transparent 50%),
            linear-gradient(180deg, transparent 30px, #660033 30px, #660033 50%, transparent 50%);
        }

        window#waybar {
          background: transparent;
        }
      '';
    }
    .${subtheme};

}
