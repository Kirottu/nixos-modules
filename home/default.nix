{ config, ... }:
let
  mkNextcloud = name: {
    source = config.lib.file.mkOutOfStoreSymlink "/home/kirottu/Nextcloud/${name}";
  };
in
{
  imports = [
    ./modules
    ./services.nix
    ./packages.nix
  ];

  home = {
    username = "kirottu";
    homeDirectory = "/home/kirottu";

    stateVersion = "24.11";
    # Paths linked to Nextcloud

    file."Documents" = mkNextcloud "Documents";
    file."Pictures" = mkNextcloud "Pictures";
  };
}
