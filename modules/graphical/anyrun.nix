{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.anyrun.enable = lib.mkEnableOption "Anyrun";

  config = {
    hm.programs.anyrun = {
      enable = true;
      config = {
        x = {
          fraction = 0.5;
        };
        y = {
          fraction = 0.2;
        };
        width = {
          absolute = 800;
        };
        hidePluginInfo = true;
        ignoreExclusiveZones = true;
        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
          "${pkgs.anyrun}/lib/libkidex.so"
          "${pkgs.anyrun}/lib/librink.so"
          "${pkgs.anyrun}/lib/libtranslate.so"
        ];
      };

      extraCss =
        with config.theming.themeAttrs;
        {
          diagonals = ''
            #window {
              background-color: rgba(0, 0, 0, 0);
            }

            box#main {
              background-color: ${l4};
              box-shadow: 0 0 5px black;
            }

            entry#entry {
              min-height: 40px;
              background: linear-gradient(135deg, ${l1} 400px, ${l3} 400px, ${l3} 450px, ${l1} 450px);
              border-radius: 0px;
              box-shadow: none;
              border: none;
            }

            list#main {
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
            }          '';
        }
        .${config.theming.theme};
    };
  };
}
