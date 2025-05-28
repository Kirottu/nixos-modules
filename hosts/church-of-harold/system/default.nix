{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];
  networking.hostName = "church-of-harold";
}
