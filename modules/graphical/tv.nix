{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.graphical.tv;
in
{
  options.graphical.tv = {
    enable = lib.mkEnableOption "TV switching support";
    desktopOutputs = lib.mkOption {
      description = "Outputs for desktop mode";
      type = with lib.types; listOf nonEmptyStr;
    };
    tvOutput = lib.mkOption {
      description = "Outputs for TV mode";
      type = lib.types.nonEmptyStr;
    };
    desktopSink = lib.mkOption {
      description = "Audio sink for the desktop";
      type = lib.types.nonEmptyStr;
    };
    tvSink = lib.mkOption {
      description = "Audio sink for the TV";
      type = lib.types.nonEmptyStr;
    };
  };

  config = lib.mkIf config.graphical.tv.enable (
    let
      mkScript =
        toTv: toDesktop:
        let
          stateFile = "/tmp/tv.state";

        in
        pkgs.writeShellScript "tv.sh" ''
          #!/bin/sh

          if [ -f "${stateFile}" ]; then
            rm "${stateFile}"
            ${pkgs.pulseaudio}/bin/pactl set-default-sink ${cfg.desktopSink}

            ${toDesktop}
          else
            touch "${stateFile}"
            ${pkgs.pulseaudio}/bin/pactl set-default-sink ${cfg.tvSink}

            ${toTv}
          fi
        '';
    in
    lib.mkMerge [
      (lib.mkIf config.graphical.niri.enable (
        let
          niri = lib.getExe pkgs.niri;
          workspaces = config.hm.programs.niri.settings.workspaces;
          wsToTv = lib.concatStrings (
            lib.mapAttrsToList (name: value: ''
              ${niri} msg action move-workspace-to-monitor --reference ${name} ${cfg.tvOutput}
            '') workspaces
          );
          desktopMonsOff = lib.concatStrings (
            builtins.map (output: ''
              ${niri} msg output ${output} off
            '') cfg.desktopOutputs
          );
          desktopMonsOn = lib.concatStrings (
            builtins.map (output: ''
              ${niri} msg output ${output} on
            '') cfg.desktopOutputs
          );
          wsToDesktop = lib.concatStrings (
            lib.mapAttrsToList (name: value: ''
              ${niri} msg action move-workspace-to-monitor --reference ${name} ${value.open-on-output}
            '') workspaces
          );
          fixDesktopOrder = lib.concatStrings (
            lib.flatten (
              builtins.map (
                output:
                lib.imap (i: attrs: ''
                  ${niri} msg action move-workspace-to-index --reference ${attrs.name} ${toString i}
                '') (builtins.filter (attrs: attrs.value.open-on-output == output) (lib.attrsToList workspaces))

              ) cfg.desktopOutputs
            )
          );
          fixTvOrder = lib.concatStrings (
            lib.imap (i: attrs: ''
              ${niri} msg action move-workspace-to-index --reference ${attrs.name} ${toString i}
            '') (lib.attrsToList workspaces)
          );

          script =
            mkScript
              ''
                ${niri} msg output ${cfg.tvOutput} on
                sleep 1
                ${wsToTv}
                sleep 1
                ${desktopMonsOff}
                ${fixTvOrder}
              ''
              ''
                ${desktopMonsOn}
                sleep 1
                ${wsToDesktop}
                sleep 1
                ${niri} msg output ${cfg.tvOutput} off
                ${fixDesktopOrder}
              '';
        in
        {
          hm.programs.niri.settings.binds = with config.hm.lib.niri.actions; {
            "Mod+T".action = spawn "${script}";
          };
        }
      ))
    ]
  );
}
