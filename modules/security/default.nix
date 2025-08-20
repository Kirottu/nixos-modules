{
  pkgs,
  ...
}:
{
  security = {
    sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
  impermanence.userDirectories = [
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
