{
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs.niri.lib.kdl) leaf plain;
in
[
  (plain "Mod+T" [
    (leaf "spawn" [
      "${inputs.tv.packages.${pkgs.system}.tv}/bin/tv"
      "toggle"
    ])
  ])
  (plain "Mod+W" [
    (leaf "spawn" [
      "${inputs.tv.packages.${pkgs.system}.tv}/bin/tv"
      "fix-workspace-order"
    ])
  ])
]
