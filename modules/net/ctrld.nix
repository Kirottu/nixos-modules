{
  config,
  secrets,
  inputs,
  lib,
  ...
}:
{
  options.net.ctrld = {
    enable = lib.mkEnableOption "CtrlD";
  };

  imports = [
    inputs.ctrld.nixosModules.ctrld
  ];

  config = lib.mkIf config.net.ctrld.enable {
    networking = {
      networkmanager.dns = lib.mkForce "none";
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
    };
    services.ctrld = {
      enable = true;
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
            endpoint = secrets.ctrld.doh;
            timeout = 5000;
          };
        };

      };
    };
  };
}
