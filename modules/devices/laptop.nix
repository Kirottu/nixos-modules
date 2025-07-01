{ config, lib, ... }:
{
  config = lib.mkIf (config.devices.class == "laptop") {
    battery.enable = true;
  };
}
