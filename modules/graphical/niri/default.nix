{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.graphical.niri = {
    enable = lib.mkEnableOption "Niri compositor";
    extraOptions = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  imports = [
    inputs.niri.nixosModules.niri
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  config = lib.mkIf config.graphical.niri.enable {
    cli.getty.dm.command = lib.mkIf config.cli.getty.dm.enable "niri-session";

    graphical = {
      screenLocking = {
        gtklock.enable = true;
        swayidle.enable = true;
      };
      waybar.enable = true;
      yand.enable = true;
      terminals.alacritty.enable = true;
    };
    hm.services.wpaperd.enable = true;

    programs.niri.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;

    xdg.portal = {
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    hm.systemd.user.services.xwayland-satellite = {
      Unit = {
        Description = "Xwayland outside your Wayland";
        BindsTo = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
      Service = {
        Type = "notify";
        NotifyAccess = "all";
        ExecStart = lib.getExe pkgs.xwayland-satellite;
        StandardOutput = "journal";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    impermanence.userDirectories = [
    ];

    services.system76-scheduler.assignments = {
      desktop-environment = {
        matchers = [ "niri" ];
      };
    };

    hm.imports = [
      inputs.system76-scheduler-niri.homeModules.system76-scheduler-niri
    ];

    hm.services.system76-scheduler-niri.enable = config.perf.s76-scheduler.enable;

    environment.systemPackages = with pkgs; [
      nautilus # Required for desktop portal file picking
      pulseaudio # Used by TV switching script
      libsecret
      wayland-utils
      wl-clipboard
    ];
  };
}
