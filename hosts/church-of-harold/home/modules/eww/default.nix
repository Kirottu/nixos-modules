{ pkgs, lib, ... }:
{
  systemd.user.services.eww = {
    Unit = {
      Description = "ElKowars wacky widgets";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.eww} daemon --no-daemonize";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}
