{
  lib,
  config,
  ...
}:
let
  cfg = config.srv.nextcloud;
in
{
  options.srv.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud";
    config = {
      configureRedis = true;
    };
  };

  config = lib.mkIf cfg.enable {
    srv.nginx.enable = true;

    services.nextcloud = {
      enable = true;
    };
  };
}
