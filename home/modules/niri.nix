{
  inputs,
  pkgs,
  lib,
  mylib,
  ...
}:
let
  inherit (inputs.niri.lib.kdl)
    node
    plain
    leaf
    flag
    ;
in
{
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };
    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = lib.getExe pkgs.xwayland-satellite;
      StandardOutput = "journal";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.niri.config = builtins.concatLists [
    (mylib.hostHome' "modules/niri/root.nix" { inherit inputs; })
    [
      (plain "environment" [
        (leaf "DISPLAY" ":0") # Has to be set here for it magically disappears elsewhere
        (leaf "NIXOS_OZONE_WL" "1")
      ])

      # Window rules
      (plain "window-rule" [
        (leaf "match" { app-id = "discord"; })
        (leaf "open-on-workspace" "Chat")
        (leaf "open-maximized" true)
      ])
      (plain "window-rule" [
        (leaf "match" { app-id = "zen"; })
        (leaf "open-maximized" true)
      ])
      (plain "window-rule" [
        (leaf "open-floating" false)
      ])

      # Overview things
      (plain "gestures" [
        (plain "hot-corners" [
          (flag "off")
        ])
      ])
      (plain "overview" [
        (leaf "zoom" 0.25)
        (leaf "backdrop-color" "#101010")
      ])

      # Input config
      (plain "input" [
        (plain "keyboard" [
          (plain "xkb" [
            (leaf "layout" "fi")
          ])
          (leaf "repeat-delay" 300)
          (leaf "repeat-rate" 40)
        ])
        (plain "touchpad" [
          (flag "tap")
          (flag "dwt")
          (leaf "scroll-factor" 0.8)
        ])
      ])

      # Layout
      (plain "layout" [
        (leaf "gaps" 10)
        (plain "focus-ring" [
          (flag "off")
        ])
        (plain "border" [
          (leaf "width" 4)
          (leaf "active-color" "#660033")
          (leaf "inactive-color" "#000000")
        ])
      ])

      # Ask clients to omit client side decorations
      (flag "prefer-no-csd")

      (plain "binds" (
        builtins.concatLists [
          (mylib.hostHome' "modules/niri/binds.nix" { inherit inputs; })
          (lib.flatten (
            builtins.genList (i: [
              (plain "Mod+${(builtins.toString i)}" [ (leaf "focus-workspace" i) ])
              (plain "Mod+Shift+${builtins.toString i}" [ (leaf "move-column-to-workspace" i) ])
            ]) 9
          ))
          [
            # Application binds
            (plain "Mod+Return" [ (leaf "spawn" "alacritty") ])
            (plain "Mod+D" [ (leaf "spawn" "anyrun") ])

            (node "Mod+R" { repeat = false; } [ (flag "toggle-overview") ])
            (node "Mod+N" { repeat = false; } [
              (leaf "spawn" [
                "swaync-client"
                "-t"
              ])
            ])

            # Window management
            (plain "Mod+Shift+Q" [ (flag "close-window") ])
            (plain "Mod+Up" [ (flag "focus-column-left") ])
            (plain "Mod+Down" [ (flag "focus-column-right") ])
            (plain "Mod+Shift+Up" [ (flag "move-column-left") ])
            (plain "Mod+Shift+Down" [ (flag "move-column-right") ])

            (plain "Mod+F" [ (flag "maximize-column") ])
            (plain "Mod+Shift+F" [ (flag "fullscreen-window") ])

            (plain "Mod+Comma" [ (leaf "set-column-width" "-10%") ])
            (plain "Mod+Period" [ (leaf "set-column-width" "+10%") ])

            (plain "Print" [ (flag "screenshot") ])
            (plain "Mod+Shift+E" [ (flag "quit") ])
          ]
        ]
      ))
    ]
  ];
}
