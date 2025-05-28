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
  };
}
