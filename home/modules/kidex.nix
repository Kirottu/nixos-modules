{ inputs, config, ... }:
{
  imports = [
    inputs.kidex.homeModules.kidex
  ];
  services.kidex = {
    enable = true;
    settings = {
      directories = [
        {
          path = "${config.home.homeDirectory}/Documents";
          recurse = true;
        }
        {
          path = "${config.home.homeDirectory}/Pictures";
          recurse = true;
        }
        {
          path = "${config.home.homeDirectory}/Downloads";
          recurse = false;
        }
      ];
    };
  };
}
