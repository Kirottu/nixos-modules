{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];
  config = {
    devices.class = "desktop";

    networking = {
      hostName = "church-of-harold";
    };
    gaming = {
      vr.enable = true;
      dolphin-emu.enable = true;
      heroic.enable = true;
      prismlauncher.enable = true;
      umu-run.enable = true;
      steam.enable = true;
      r2modman.enable = true;
    };
    # graphical.eww.enable = true;
    graphical.tv = {
      enable = true;
      desktopOutputs = [
        "DP-1"
        "DP-2"
        "DP-3"
      ];
      tvOutput = "HDMI-A-1";
      tvSink = "alsa_output.pci-0000_08_00.1.hdmi-stereo";
      tvRegex = "Navi.*\\[alsa\\]";
      tvProfile = 1;
      desktopSink = "alsa_output.pci-0000_0a_00.4.analog-stereo";

    };
    services = {
      udev = {
        # Workaround for premature wakeups
        extraRules = ''
          ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
        '';
        packages = with pkgs; [ android-udev-rules ];
      };
      lact.enable = true;
      btrfs.autoScrub.enable = true;
    };
    impermanence = {
      directories = [ "/etc/lact" ];
      userDirectories = [ ".config/lact" ];
    };

    hardware.amdgpu.overdrive.enable = true;

    programs.droidcam.enable = true;

    # Workaround for cursor corruption after suspend
    hm.programs.niri.settings.debug.disable-cursor-plane = [ ];

    hm.programs.git.signing.key = "B0640016A4BADA0FFBDBD1A57A14996A0D0109CC";

    wiibt.enable = true;

    system.stateVersion = "24.11"; # Did you read the comment?
    hm.home.stateVersion = "24.11";
  };
}
