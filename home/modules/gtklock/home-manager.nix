{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.types)
    nullOr
    either
    path
    lines
    ;
  cfg = config.programs.gtklock;
  iniFormat = pkgs.formats.ini { };
in
{
  meta.maintainers = with lib.hm.maintainers; [ Kirottu ];

  options.programs.gtklock = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable gtklock

        Note that PAM must be manually configured to allow
        gtklock to perform authentication.

        This can be done by adding
        ```nix
        security.pam.services.swaylock = { };
        ```
        to your system settings portion.
      '';
    };
    settings = lib.mkOption {
      type = iniFormat.type;
      default = { };
      example = lib.literalExpression ''
        {
          main = {
            time-format = "%H:%M:%S";
            follow-focus = true;
          };
        };
      '';
      description = ''
        The configuration for gtklock
      '';
    };
    style = lib.mkOption {
      type = nullOr (either path lines);
      default = null;
      description = ''
        CSS style for gtklock
      '';
    };
    package = lib.mkPackageOption pkgs "gtklock" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."gtklock/config.ini" = lib.mkIf (cfg.settings != { }) {
      source = iniFormat.generate "gtklock-config" cfg.settings;
    };
    xdg.configFile."gtklock/style.css" = lib.mkIf (cfg.style != null) {
      source =
        if builtins.isPath cfg.style || lib.isStorePath cfg.style then
          cfg.style
        else
          pkgs.writeText "gtklock/style.css" cfg.style;
    };
  };
}
