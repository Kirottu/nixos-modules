{ pkgs, lib, ... }:
{
  # Short service declarations
  
  services.udiskie = {
    enable = true;
    tray = "auto";
  };
  # services.mako = {
  #   enable = true;
  #   settings = {
  #     default-timeout = 10000;
  #   };
  # };
  services.network-manager-applet = {
    enable = true;
  };

  systemd.user.services.blueman-applet = {
    Unit = {
      Description = "Blueman applet";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe' pkgs.blueman "blueman-applet";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
