{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  pkg = inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
in
{
  options.anyrun.enable = lib.mkEnableOption "Anyrun";

  config = {
    hm.programs.anyrun = {
      package = pkg;
      enable = true;
      config = {
        x = {
          fraction = 0.5;
        };
        y =
          {
            diagonals =
              {
                vertical = {
                  fraction = 0.2;
                };
                overview = {
                  absolute = 80;
                };
              }
              .${config.theming.themeAttrs.subtheme};
          }
          .${config.theming.theme};
        width = {
          absolute = 800;
        };
        margin = 10;
        hidePluginInfo = true;
        ignoreExclusiveZones = true;
        plugins = [
          "${pkg}/lib/libniri_focus.so"
          "${pkg}/lib/libapplications.so"
          "${pkg}/lib/libnix_run.so"
          "${pkg}/lib/libsymbols.so"
          "${pkg}/lib/libkidex.so"
          "${pkg}/lib/librink.so"
          "${pkg}/lib/libtranslate.so"
        ];
      };

      extraConfigFiles = {
        "symbols.ron".text = ''
          Config(
            prefix: ":s ",
            symbols: {},
            max_entries: 3,
          )
        '';
        "niri-focus.ron".text = ''
          Config(
            max_entries: 3,
          )
        '';
      };
      extraCss =
        with config.theming.themeAttrs;
        {
          diagonals = lib.concatStrings [
            ''
              #window {
                background-color: rgba(0, 0, 0, 0);
              }

              #plugin {
                background: transparent;
                padding-bottom: 5px;
              }

              #match {
                padding: 2.5px;
              }

              #match:selected {
                background:
                  linear-gradient(135deg, ${l1} 30px, transparent 30px),
                  linear-gradient(-45deg, ${l1} 30px, transparent 30px);
              }

              #match:selected label#info {
                color: #b0b0b0;
                animation: fade 0.1s linear
              }

              @keyframes fade {
                0% {
                  color: transparent;
                }

                100% {
                  color: #b0b0b0;
                }
              }

              #match label#info {
                color: transparent;
              }

              #match:hover {
                background: transparent;
              }

              label#match-desc {
                font-size: 10px;
                color: #b0b0b0;
              }

              label#plugin {
                font-size: 14px;
              }
            ''
            {
              vertical = ''
                box#main {
                  background-color: ${l4};
                  box-shadow: 0 0 5px black;
                }

                list#main {
                  background-color: rgba(0, 0, 0, 0);
                }

                entry#entry {
                  min-height: 40px;
                  background: linear-gradient(135deg, ${l1} 400px, ${l3} 400px, ${l3} 450px, ${l1} 450px);
                  border-radius: 0px;
                  box-shadow: none;
                  border: none;
                }
              '';
              overview = ''
                box#main {
                  background-color: transparent;
                }
                list#main {
                  margin-top: 100px;
                  background-color: ${l4};
                  box-shadow: 0 0 5px black;
                }
                entry#entry {
                  min-height: 30px;
                  background:
                    linear-gradient(135deg, transparent 100px, ${l3} 100px, ${l3} 120px, transparent 120px),
                    linear-gradient(135deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%),
                    linear-gradient(-45deg, transparent 25px, ${l1} 25px, ${l1} 50%, transparent 50%);
                  border-radius: 0px;
                  box-shadow: none;
                  border: none;
                  padding-left: 40px;
                  padding-right: 40px;
                  margin-left: 200px;
                  margin-right: 200px;
                }
              '';
            }
            .${subtheme}
          ];
        }
        .${config.theming.theme};
    };
  };
}
