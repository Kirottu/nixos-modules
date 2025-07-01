{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./users.nix
    inputs.home-manager.nixosModules.home-manager
    (lib.modules.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" config.mainUser.userName ])
  ];
  config = {
    home-manager = {
      useGlobalPkgs = true;
      # users.${config.mainUser.userName}.imports = config.hm.modules ++ [
      #   lib.mkHm
      #   {
      #     home.username = config.mainUser.userName;
      #     home.homeDirectory = "/home/${config.mainUser.userName}";

      #     home.stateVersion = config.hm.stateVersion;
      #   }
      # ];
    };
    hm = {
      home.username = config.mainUser.userName;
      home.homeDirectory = "/home/${config.mainUser.userName}";
    };
  };
}
