{ inputs, ... }:
{
  imports = [
    inputs.yand.homeModules.yand
  ];

  services.yand = {
    enable = true;
    settings = {
      width = 400;
      spacing = 10;
      output = "eDP-1";
      timeout = 5;
    };
    style = ./style.css;
  };
}
