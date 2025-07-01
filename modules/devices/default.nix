{ lib, ... }:
{
  options.devices = {
    class = lib.mkOption {
      description = "Class of device";
      type = lib.types.enum [
        "desktop"
        "laptop"
      ];
    };
  };

  imports = [
    ./desktop.nix
    ./laptop.nix
    ./base.nix
  ];
}
