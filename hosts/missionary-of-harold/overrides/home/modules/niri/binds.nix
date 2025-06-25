{ inputs, pkgs, ... }:
let
  inherit (inputs.niri.lib.kdl) plain leaf;
in
[
  (plain "Mod+F1" [
    (leaf "spawn" [
      "wpctl"
      "set-mute"
      "@DEFAULT_SINK@"
      "toggle"
    ])
  ])
  (plain "Mod+F2" [
    (leaf "spawn" [
      "wpctl"
      "set-volume"
      "@DEFAULT_SINK@"
      "5%-"
    ])
  ])
  (plain "Mod+F3" [
    (leaf "spawn" [
      "wpctl"
      "set-volume"
      "@DEFAULT_SINK@"
      "5%+"
    ])
  ])

  (plain "Mod+Shift+F2" [
    (leaf "spawn" [
      "${pkgs.brightnessctl}"
      "s"
      "5%-"
    ])
  ])
  (plain "Mod+Shift+F3" [
    (leaf "spawn" [
      "${pkgs.brightnessctl}"
      "s"
      "+5%"
    ])
  ])
]
