{
  pkgs,
  lib,
  mylib,
  ...
}:
let
  hostConfigOption = mylib.hostHome "modules/noisetorch.nix";
in
{
  systemd.user.services.noisetorch-microphone = lib.mkIf (builtins.length hostConfigOption > 0) {
    Unit = {
      Description = "Noisetorch microphone suppression";
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };
    Service =
      let
        hostConfig = builtins.elemAt hostConfigOption 0;
      in
      {
        Type = "simple";
        RemainAfterExit = "yes";
        ExecStart = "${lib.getExe pkgs.noisetorch} -i -s ${hostConfig.microphone} -t ${builtins.toString hostConfig.voiceActivation}";
        ExecStop = "${lib.getExe pkgs.noisetorch} -u";
      };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
