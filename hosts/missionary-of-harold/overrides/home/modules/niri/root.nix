{ inputs, ... }: let
  inherit (inputs.niri.lib.kdl) node leaf;
in [
  # Named workspaces
  (node "workspace" "chat" [
    (leaf "open-on-output" "eDP-1")  
  ])
  (node "workspace" "web" [
    (leaf "open-on-output" "eDP-1")  
  ])

  # Output
  (node "output" "eDP-1" [
    (leaf "scale" 1.0)
  ])
]
