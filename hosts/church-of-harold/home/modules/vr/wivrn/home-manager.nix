{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.types) nullOr str;

  cfg = config.programs.wivrn;
  jsonFormat = pkgs.formats.json { };
in
{
  meta.maintainers = with lib.hm.maintainers; [ Kirottu ];

  options.programs.wivrn = {
    enable = lib.mkEnableOption "Enable WiVRn configuration";
    settings = lib.mkOption {
      type = nullOr jsonFormat.type;
      example = lib.literalExpression ''
        {
          scale = [ 0.35 0.35 ];
          bitrate = 90000000;
        }
      '';
      description = ''
        WiVRn server configuration

        NOTE: The avahi daemon must be enabled with the following config
        for WiVRn to work:
        ```
        services.avahi = {
          enable = true;
          publish.userServices = true;
        };
        ```
      '';
      default = null;
    };
    autostart = lib.mkOption {
      type = nullOr str;
      example = lib.literalExpression ''
        #!/bin/sh

        ${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --openxr --show
      '';
      description = ''
        Shell script to be ran as the WiVRn autostart application
      '';
    };
    package = lib.mkPackageOption pkgs "wivrn" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."wivrn/config.json" = {
      source = jsonFormat.generate "wivrn-config" (
        if (cfg.autostart != null) then
          let
            autostart = pkgs.writeShellScript "autostart.sh" cfg.autostart;
          in
          lib.mergeAttrs {
            application = [ autostart ];
          } cfg.settings

        else
          cfg.settings
      );
    };
  };
}
