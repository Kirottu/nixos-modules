{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.gaming.vr.enable = lib.mkEnableOption "VR";

  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  config = lib.mkIf config.gaming.vr.enable {
    # Needed for WiVRn
    services.avahi = {
      enable = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    environment.systemPackages = [
      pkgs.bs-manager
    ];

    impermanence.userDirectories = [
      ".config/bs-manager"
      ".config/wlxoverlay"
      ".config/wivrn"
      ".local/share/wayvr-dashboard"
      ".local/share/dev.oo8.wayvr-dashboard"
    ];

    hm.imports = [
      inputs.hm-modules.homeModules.wivrn
      inputs.hm-modules.homeModules.wlx-overlay-s
    ];

    hm.programs.wivrn = {
      enable = true;
      autostart = ''
        #!/bin/sh

        ${pkgs.pulseaudio}/bin/pactl set-default-sink wivrn.sink

        ${lib.getExe pkgs.wlx-overlay-s} --openxr
      '';
      settings = {
        scale = 0.35;
        bitrate = 90000000;
        encoders = [
          {
            encoder = "vaapi";
            codec = "h265";
            width = 0.5;
            height = 0.25;
            offset_x = 0.0;
            offset_y = 0.0;
            group = 0;
          }
          {
            encoder = "vaapi";
            codec = "h265";
            width = 0.5;
            height = 0.75;
            offset_x = 0.0;
            offset_y = 0.25;
            group = 0;
          }
          {
            encoder = "vaapi";
            codec = "h265";
            width = 0.5;
            height = 1.0;
            offset_x = 0.5;
            offset_y = 0.0;
            group = 0;
          }
        ];
        openvr-compat-path = "${pkgs.xrizer}/lib/xrizer";
        tcp-only = false;
      };
    };

    hm.programs.wlx-overlay-s = {
      enable = true;
      watch = ./watch.yaml;
      openxrActions = ./openxr_actions.json5;
      dashboard.package = pkgs.wayvr-dashboard;
    };
  };
}
