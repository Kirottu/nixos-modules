{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.secrets.sops = {
    enable = lib.mkEnableOption "sops-nix";
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = lib.mkIf config.secrets.sops.enable {
    impermanence.userDirectories = [ ".config/sops" ];
    environment.systemPackages = with pkgs; [ sops ];

    sops.age.keyFile =
      let
        path = "/home/${config.mainUser.userName}/.config/sops/age/keys.txt";
      in
      if config.impermanence.enable then "/persistent${path}" else path;
  };
}
