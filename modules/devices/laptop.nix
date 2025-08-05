{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.devices.class == "laptop") {
    battery.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
