{ lib, config, ... }:

let
  cfg = config.perf.s76-scheduler;
in
{
  options.perf.s76-scheduler = {
    enable = lib.mkEnableOption "system76-scheduler";
  };

  config = lib.mkIf cfg.enable {
    services.system76-scheduler = {
      enable = true;
      assignments = {
        batch.matchers = [ "nix-daemon" ];
      };
    };
  };
}
