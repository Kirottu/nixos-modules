{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.hm.programs.niri.settings = lib.mkMerge [
    config.graphical.niri.extraOptions
    {
      spawn-at-startup = [
        { command = [ "nextcloud" ]; }
      ];

      environment = {
        DISPLAY = ":0";
        NIXOS_OZONE_WL = "1";
      };

      gestures.hot-corners.enable = false;

      # Input config
      input = {
        keyboard = {
          xkb = {
            layout = "fi";
          };
          repeat-delay = 300;
          repeat-rate = 40;
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = -0.2;
        };
        touchpad = {
          tap = true;
          dwt = true;
          scroll-factor = 0.8;
          natural-scroll = false;
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      # Layout
      layout = {
        gaps = 10;
        focus-ring.enable = false;
      };

      # Ask clients to omit client side decorations
      prefer-no-csd = true;

      cursor = {
        hide-when-typing = true;
      };

      animations = {
        window-close = {
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
          custom-shader = ''
            float map(float value, float min1, float max1, float min2, float max2) {
                return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
            }
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                float cur = 1.0-niri_clamped_progress;
                if (coords_geo.x > cur) { return vec4(0.0); }
                vec3 coord = vec3(map(coords_geo.x,0.0, cur, 0.0, 1.0), coords_geo.y, coords_geo.z);
                return texture2D(niri_tex, (niri_geo_to_tex * coord).st);
            }
          '';
        };
      };
    }
    {
      diagonals = lib.mkMerge [
        {
          layout = {
            border = {
              enable = true;
              width = 4;
              active.color = config.theming.themeAttrs.l1;
              inactive.color = "#000000";
            };
          };
        }
        {
          vertical = {
            overview = {
              zoom = 0.25;
              backdrop-color = "#090909";
            };
            layout.struts.right = 45;
          };
          overview = {
            spawn-at-startup = [
              {
                command = [
                  "sh"
                  "-c"
                  "niri msg -j event-stream | ${pkgs.writeShellScript "niri-overview-monitor" ''
                    while read line; do
                      overview=$(echo $line | ${lib.getExe pkgs.jq} '.OverviewOpenedOrClosed.is_open')

                      if [ $overview = "false" ]; then
                        killall .anyrun-wrapped
                      fi
                    done                                            
                  ''}"
                ];
              }
            ];
            overview = {
              backdrop-color = "#040404";
              zoom = 0.75;
            };
          };
        }
        .${config.theming.themeAttrs.subtheme}
      ];
    }
    .${config.theming.theme}
  ];

}
