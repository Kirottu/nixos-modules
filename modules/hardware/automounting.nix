{ config, lib, ... }:
{
  options.automounting.enable = lib.mkEnableOption "Automounting";

  config = lib.mkIf config.automounting.enable {
    services.udisks2.enable = true;
    hm.services.udiskie = {
      enable = true;
      tray = "auto";
    };
  };
}
