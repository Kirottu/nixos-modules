{ config, lib, ... }:
{
  options.net.networkmanager.enable = lib.mkEnableOption "NetworkManager";

  imports = [
    ./stubby.nix
    ./ctrld.nix
  ];

  config = lib.mkIf config.net.networkmanager.enable {
    networking.networkmanager.enable = true;
    hm.services.network-manager-applet.enable = true;
    impermanence.directories = [ "/etc/NetworkManager/system-connections" ];
    mainUser.extraGroups = [ "networkmanager" ];
  };
}
