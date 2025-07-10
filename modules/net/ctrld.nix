{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let

  settings = {
    listener = {
      "0" = {
        ip = "127.0.0.1";
        port = 53;
      };
    };
    upstream = {
      "0" = {
        type = "doh";
        endpoint = "https://freedns.controld.com/p2";
        timeout = 5000;
      };
    };
  };
in
{
  options.net.ctrld = {
    enable = lib.mkEnableOption "CtrlD";
  };

  imports = [
    inputs.ctrld.nixosModules.ctrld
  ];

  config = lib.mkIf config.net.ctrld.enable {
    sops = lib.mkIf config.secrets.sops.enable {
      secrets."dns/doh/${config.networking.hostName}" = {
        sopsFile = ../../secrets/dns.yaml;
      };

      templates."ctrld-config.toml".file = (pkgs.formats.toml { }).generate "ctrld-placeholder.toml" (
        settings
        // {
          upstream."0" = {
            endpoint = config.sops.placeholder."dns/doh/${config.networking.hostName}";
            type = "doh";
            timeout = 5000;
          };
        }
      );

    };

    networking = {
      networkmanager.dns = lib.mkForce "none";
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
    };
    services.ctrld = {
      enable = true;
      settings =
        if config.secrets.sops.enable then config.sops.templates."ctrld-config.toml".path else settings;
    };
  };
}
