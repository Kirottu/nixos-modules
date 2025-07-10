{
  imports = [
    ./sops.nix
  ];

  security = {
    sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}
