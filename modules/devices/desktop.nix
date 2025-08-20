{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.devices.class == "desktop") {
    networking.firewall.enable = false;

    # boot = {
    #   kernelPackages = (pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_zen);
    #   kernelParams = [
    #     # "mitigations=off"
    #   ];
    # };
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelPatches = [
      {
        name = "kmemleak";
        patch = null;
        extraConfig = ''
          DEBUG_KMEMLEAK y
        '';
      }
    ];

    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [
        "--autopower"
      ];
      package = pkgs.scx.rustscheds;
    };

    powerManagement.cpuFreqGovernor = "performance";
  };
}
