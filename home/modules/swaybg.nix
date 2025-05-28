{ pkgs, config, ... }:
{
  systemd.user.services.swaybg = {
    Unit = {
      Description ="Swaybg systemd user service";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      # FIXME: Reproducible wallpaper
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/Nextcloud/Documents/marker-of-harold.png -m fill";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
