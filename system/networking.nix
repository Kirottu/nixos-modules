{ secrets, lib, ... }:
{

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
    };
    nameservers = secrets.systemd-resolved.nameservers;
  };

  services.resolved = {
    enable = true;
    dnsovertls = "true";
    extraConfig = secrets.systemd-resolved.extra-config;
  };
}
