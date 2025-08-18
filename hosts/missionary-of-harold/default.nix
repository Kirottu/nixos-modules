{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    devices.class = "laptop";

    networking = {
      hostName = "missionary-of-harold";
      # networkmanager.wifi.powersave = false;
    };

    gaming = {
      heroic.enable = true;
      prismlauncher.enable = true;
      umu-run.enable = true;
      steam.enable = true;
    };

    services.btrfs.autoScrub.enable = true;

    hm.programs.git.signing.key = "B533007F762CC944EE90C544121FC25B5BCEC10E";

    system.stateVersion = "24.11"; # Did you read the comment?
    hm.home.stateVersion = "24.11";
  };
}
