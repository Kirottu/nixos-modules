{
  secrets,
  lib,
  pkgs,
  ...
}:
{

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
    };
    # nameservers = secrets.systemd-resolved.nameservers;
  };

  # services.resolved = {
  #   enable = true;
  #   dnsovertls = "true";
  #   extraConfig = secrets.systemd-resolved.extra-config;
  # };

  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      round_robin_upstreams = 0;
      upstream_recursive_servers = [
        {
          address_data = secrets.stubby.address;
          tls_auth_name = secrets.stubby.name;
        }
      ];
    };
  };
}
