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
    r2modman.enable = lib.mkEnableOption "r2modman";
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
        package = (
          pkgs.prismlauncher.override {
            glfw3-minecraft = (
              pkgs.glfw3-minecraft.overrideAttrs {
                patches = [
                  ./glfw-patches/0001-Key-Modifiers-Fix.patch
                  ./glfw-patches/0002-Fix-duplicate-pointer-scroll-events.patch
                  ./glfw-patches/0003-Implement-glfwSetCursorPosWayland.patch
                  ./glfw-patches/0004-Fix-Window-size-on-unset-fullscreen.patch
                  ./glfw-patches/0005-Add-warning-about-being-an-unofficial-patch.patch
                  ./glfw-patches/0006-Avoid-error-on-startup.patch
                  ./glfw-patches/0007-Fix-fullscreen-location.patch
                  ./glfw-patches/0008-Fix-forge-crash.patch
                ];
              }
            );
          }
        );
        userDirectories = [ ".local/share/PrismLauncher" ];
      }
    ))
    (lib.mkIf cfg.r2modman.enable (
      lib.utils.mkApp {
        package = pkgs.r2modman;
        userDirectories = [
          ".config/r2modman"
          ".config/r2modmanPlus-local"
        ];
      }
    ))
  ];
}
