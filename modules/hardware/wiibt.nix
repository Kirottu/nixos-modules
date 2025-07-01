{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.wiibt.enable = lib.mkEnableOption "Wii BT support for Dolphin Emulator";

  config = lib.mkIf config.wiibt.enable {
    boot.extraModulePackages = [
      ((pkgs.callPackage ./btusb.nix { kernel = config.boot.kernelPackages.kernel; }))
    ];
  };
}
