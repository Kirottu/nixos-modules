{ pkgs, config, ... }:
{
  boot = {
    kernelPackages = (pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_zen); 
    # kernelPatches = [
    #   {
    #     name = "ignore_wii_bt";
    #     patch = ./ignore_wii_bt.patch;
    #   }
    # ];
    extraModulePackages = [
      ((pkgs.callPackage ./btusb.nix { kernel = config.boot.kernelPackages.kernel; }).overrideAttrs (_: {
        patches = [ ./ignore_wii_bt.patch ];
      }))
    ];
  };
}
