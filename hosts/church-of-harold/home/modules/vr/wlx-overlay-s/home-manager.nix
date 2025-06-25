{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.types)
    nullOr
    listOf
    package
    path
    str
    ;

  cfg = config.programs.wlx-overlay-s;
in
{
  meta.maintainers = with lib.hm.maintainers; [ Kirottu ];

  options.programs.wlx-overlay-s = {
    enable = lib.mkEnableOption "Enable WlxOverlay-S configuration";
    watch = lib.mkOption {
      type = nullOr path;
      description = ''
        WlxOverlay-S watch config file.
      '';
      default = null;
    };
    openxrActions = lib.mkOption {
      type = nullOr path;
      description = ''
        WlxOverlay-S bindings file.
      '';
      default = null;
    };
    dashboard = {
      package = lib.mkOption {
        type = nullOr package;
        description = ''
          Package for the program to be used as the dashboard
        '';
        default = null;
      };
      args = lib.mkOption {
        type = str;
        description = ''
          Args for the dashboard program
        '';
        default = "";
      };
      env = lib.mkOption {
        type = listOf str;
        description = ''
          List of env vars for the dashboard program
        '';
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wlxoverlay/watch.yaml" = lib.mkIf (cfg.watch != null) {
      source = cfg.watch;
    };
    xdg.configFile."wlxoverlay/openxr_actions.json5" = lib.mkIf (cfg.openxrActions != null) {
      source = cfg.openxrActions;
    };
    xdg.configFile."wlxoverlay/wayvr.conf.d/dashboard.yaml" = lib.mkIf (cfg.dashboard.package != null) {
      text = ''
        dashboard:
          exec: "${lib.getExe cfg.dashboard.package}"
          args: "${cfg.dashboard.args}"
          env: [${lib.concatStrings (builtins.map (env: "\"${env}\",") cfg.dashboard.env)}]
      '';
    };
  };
}
