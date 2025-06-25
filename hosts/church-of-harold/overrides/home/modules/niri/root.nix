{ inputs, ... }:
let
  inherit (inputs.niri.lib.kdl)
    plain
    node
    flag
    leaf
    ;
in
[
  (node "workspace"
    [ "utils" ]
    [
      (leaf "open-on-output" [ "DP-3" ])
    ]
  )
  (node "workspace"
    [ "chat" ]
    [
      (leaf "open-on-output" [ "DP-3" ])
    ]
  )
  (node "workspace"
    [ "games" ]
    [
      (leaf "open-on-output" [ "DP-2" ])
    ]
  )
  (node "workspace"
    [ "vr" ]
    [
      (leaf "open-on-output" [ "DP-1" ])
    ]
  )
  (node "workspace"
    [ "web-dp1" ]
    [
      (leaf "open-on-output" [ "DP-1" ])
    ]
  )
  (node "workspace"
    [ "web-dp2" ]
    [
      (leaf "open-on-output" [ "DP-2" ])
    ]
  )
  (node "workspace"
    [ "web-dp3" ]
    [
      (leaf "open-on-output" [ "DP-3" ])
    ]
  )

  (node "output"
    [ "DP-1" ]
    [
      (leaf "mode" [ "1920x1080@74.986000" ])
    ]
  )
  (node "output"
    [ "DP-2" ]
    [
      (leaf "mode" [ "1920x1080@99.930000" ])
    ]
  )
  (node "output"
    [ "DP-3" ]
    [
      (leaf "mode" [ "1280x1024@75.025002" ])
    ]
  )
  (node "output"
    [ "HDMI-A-1" ]
    [
      (leaf "mode" [ "3840x2160@60" ])
      (leaf "scale" [ 2.0 ])
      (flag "off")
    ]
  )

  (plain "window-rule" [
    (leaf "match" [ { app-id = "^aslains_wows_modpack.*"; } ])
    (leaf "open-floating" [ true ])
  ])

  (plain "debug" [
    (flag "disable-cursor-plane")
  ])
]
