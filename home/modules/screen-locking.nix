{ pkgs, lib, ... }:
let
  command = "${lib.getExe pkgs.gtklock} -d";
in
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        inherit command;
      }
      {
        event = "lock";
        inherit command;
      }
    ];
  };
}
