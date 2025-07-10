{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.net.stubby = {
    enable = lib.mkEnableOption "Stubby DNS resolving";
  };

  config = lib.mkIf config.net.stubby.enable {
    networking.networkmanager.dns = lib.mkForce "none";

    services.stubby = {
      enable = true;
      settings = pkgs.stubby.passthru.settingsExample // {
        round_robin_upstreams = 0;
        upstream_recursive_servers = [
          {
            # address_data = secrets.stubby.address;
            # tls_auth_name = secrets.stubby.name;
          }
        ];
      };
    };
  };
}
