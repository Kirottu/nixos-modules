{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./modules
  ];
  networking.hostName = "missionary-of-harold";

}
