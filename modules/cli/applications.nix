{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        imagemagick
        tree
        killall
        file
        libnotify
        usbutils
        cloc
        steam-run
        wget
        htop
        gamescope
        android-tools
        pulseaudio
        unzip
        p7zip
        unrar-wrapper
        yt-dlp
      ];

      programs.nh = {
        enable = true;

        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 10";
        };
        flake = "/home/${config.mainUser.userName}/Projects/nixos";
      };
    }
    (lib.utils.mkApp {
      package = pkgs.openssh;
      userDirectories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    })
    (lib.utils.mkApp {
      package = pkgs.gnupg;
      userDirectories = [
        {
          directory = ".gnupg";
          mode = "0700";
        }
      ];
    })
    (lib.utils.mkApp {
      package = pkgs.libqalculate; # TODO: HM module
      userDirectories = [ ".config/qalculate" ];
    })
    (lib.utils.mkApp {
      package = pkgs.wineWowPackages.waylandFull;
      userDirectories = [ ".wine" ];
    })
  ];
}
