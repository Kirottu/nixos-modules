{ pkgs, config, ... }:
{
  boot = {
    kernelPackages = (pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_zen);
    extraModulePackages = [
      ((pkgs.callPackage ./btusb.nix { kernel = config.boot.kernelPackages.kernel; }))
    ];
    kernelParams = [
      "mitigations=off"
    ];
  };
}
