{ pkgs, lib, ... }:
{
  # !!! DISABLED
  services.wivrn = {
    enable = true;
    defaultRuntime = true;
    autoStart = true;
    config = {
      enable = true;
      json = {
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
        application = [
          (pkgs.writeShellApplication {
            name = "wivrn-autostart";
            text = ''
              #!/bin/sh

              ${pkgs.pulseaudio}/bin/pactl set-default-sink wivrn.sink

              ${lib.getExe pkgs.wlx-overlay-s} --openxr
            '';
          })
        ];
      };
    };
  };
}
