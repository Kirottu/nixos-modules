{ inputs, mylib, ... }:
{
  imports = [
    inputs.yand.homeModules.yand
  ] ++ mylib.hostHome "modules/yand.nix";

  services.yand = {
    enable = true;
    settings = {
      width = 400;
      spacing = 10;
      timeout = 5;
    };
    style = ./style.css;
  };
}
