{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./users.nix
    ./xdg.nix
    inputs.home-manager.nixosModules.home-manager
    (lib.modules.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" config.mainUser.userName ])
  ];
  config = {
    home-manager = {
      useGlobalPkgs = true;
    };
    hm = {
      home.username = config.mainUser.userName;
      home.homeDirectory = "/home/${config.mainUser.userName}";
    };
  };
}
