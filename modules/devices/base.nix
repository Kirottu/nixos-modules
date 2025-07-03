{
  pkgs,
  secrets,
  ...
}:
{
  config = {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      package = pkgs.lixPackageSets.latest.lix;
    };

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "Europe/Helsinki";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "fi_FI.UTF-8";
      LC_IDENTIFICATION = "fi_FI.UTF-8";
      LC_MEASUREMENT = "fi_FI.UTF-8";
      LC_MONETARY = "fi_FI.UTF-8";
      LC_NAME = "fi_FI.UTF-8";
      LC_NUMERIC = "fi_FI.UTF-8";
      LC_PAPER = "fi_FI.UTF-8";
      LC_TELEPHONE = "fi_FI.UTF-8";
      LC_TIME = "fi_FI.UTF-8";
    };

    console.keyMap = "fi";

    graphical = {
      niri.enable = true;
      waybar.enable = true;
      webapps = {
        enable = true;
        webapps.cinny = {
          title = "Cinny";
          url = "https://app.cinny.in";
          icon = "dialog-messages";
        };
      };
      browsers = {
        zen.enable = true;
        default = "zen-beta.desktop";
      };
    };
    mainUser = {
      userName = "kirottu";
      hashedPassword = secrets.users.pass-hash;
    };
    cli = {
      starship.enable = true;
      fish.enable = true;
      getty = {
        enable = true;
        dm.enable = true;
      };
    };
    net = {
      stubby.enable = true;
      networkmanager.enable = true;
    };
    impermanence = {
      enable = true;
      userDirectories = [
        "Projects"
        "Downloads"
        "git"
        ".config/dconf"
        ".local/share/flatpak" # Used for screen share tokens
        ".local/share/keyrings"
        ".local/state"
        ".cache"
        {
          directory = ".pki";
          mode = "0700";
        }
      ];
      userFiles = [
        ".config/gtk-3.0/bookmarks"
      ];
    };
    audio = {
      pipewire.enable = true;
      easyeffects.enable = true;
    };
    automounting.enable = true;
    bluetooth.enable = true;
    theming.plymouth.enable = true;

    nixpkgs.config.allowUnfree = true;

    zramSwap.enable = true;

    programs.command-not-found.enable = true;

    boot.kernel.sysctl."kernel.sysrq" = 1;
  };
}
