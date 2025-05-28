{
  inputs,
  lib,
  hostname,
  ...
}:
let
  hostHome =
    path:
    lib.optional (builtins.pathExists ../hosts/${hostname}/overrides/home/${path}) (import ../hosts/${hostname}/overrides/home/${path});
  hostSystem =
    path:
    lib.optional (builtins.pathExists ../hosts/${hostname}/overrides/system/${path}) (import ../hosts/${hostname}/overrides/system/${path});
in
{
  hostHome = path: hostHome path;
  hostHome' = path: args: builtins.map (mod: mod args) (hostHome path);
  hostSystem = path: hostSystem path;
  hostSystem' = path: args: builtins.map (mod: mod args) (hostSystem path);
}
