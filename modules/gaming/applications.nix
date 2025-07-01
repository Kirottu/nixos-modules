{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming;
in
{
  options.gaming = {
    dolphin-emu.enable = lib.mkEnableOption "Dolphin Emulator";
    heroic.enable = lib.mkEnableOption "Heroic games launcher";
    prismlauncher.enable = lib.mkEnableOption "Prism Launcher";
    steam.enable = lib.mkEnableOption "Steam";
    umu-run.enable = lib.mkEnableOption "UMU Launcher";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.umu-run.enable (
      lib.utils.mkApp {
        package = pkgs.umu-launcher;
        userDirectories = [
          ".local/share/umu"
        ];
      }
    ))
    (lib.mkIf cfg.heroic.enable (
      (lib.utils.mkApp {
        package = pkgs.heroic;
        userDirectories = [ ".config/heroic" ];
      })
    ))
    (lib.mkIf cfg.dolphin-emu.enable (
      lib.mkMerge [
        (lib.utils.mkApp {
          package = pkgs.dolphin-emu;
          userDirectories = [
            ".config/dolphin-emu"
            ".local/share/dolphin-emu"
          ];
        })
        {
          services.udev = {
            packages = [ pkgs.dolphin-emu ];
            extraRules = ''
              SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0305", TAG+="uaccess"
            '';
          };
        }
      ]
    ))
    (lib.mkIf cfg.steam.enable {
      impermanence.userDirectories = [
        ".local/share/Steam"
      ];

      programs.steam = {
        enable = true;
        extest.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        extraPackages = with pkgs; [
          libnotify
        ];
      };
    })
    (lib.mkIf cfg.prismlauncher.enable (
      lib.utils.mkApp {
        package = pkgs.prismlauncher;
        userDirectories = [ ".local/share/PrismLauncher" ];
      }
    ))
  ];
}
