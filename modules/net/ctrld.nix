{
  config,
  inputs,
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

  cfg = config.net.ctrld;
in
{
  options.net.ctrld = {
    enable = lib.mkEnableOption "CtrlD";
    upstream = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
    };
  };

  imports = [
    inputs.ctrld.nixosModules.ctrld
  ];

  config = lib.mkIf cfg.enable {
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
        if (cfg.upstream != null) then
          settings
          // {
            upstream."0" = {
              endpoint = cfg.upstream;
              type = "doh";
              timeout = 5000;
            };
          }
        else
          settings;
    };
  };
}
