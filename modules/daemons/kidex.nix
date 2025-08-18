{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.daemons.kidex;
in
{
  options.daemons.kidex.enable = lib.mkEnableOption "Kidex";

  config = lib.mkIf cfg.enable {
    hm.imports = [
      inputs.kidex.homeModules.kidex
    ];
    hm.services.kidex = {
      enable = true;
      settings = {
        directories = [
          {
            path = "${config.hm.home.homeDirectory}/Documents";
            recurse = true;
          }
          {
            path = "${config.hm.home.homeDirectory}/Pictures";
            recurse = true;
          }
          {
            path = "${config.hm.home.homeDirectory}/Downloads";
            recurse = false;
          }
        ];
      };
    };
  };
}
