{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./modules
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];
  networking = {
    hostName = "church-of-harold";
    firewall.enable = false;
  };
}
