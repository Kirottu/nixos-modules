{
  inputs,
  pkgs,
  mylib,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ] ++ mylib.hostHome "packages.nix";

  home.packages = with pkgs; [
    htop

    # CLI tools
    imagemagick
    brightnessctl
    killall
    file
    libnotify
    usbutils
    cloc
    unzip

    ## Development stuff
    # Rust
    cargo
    clippy
    rustc
    rustfmt

    # C/CXX
    gcc
    pkg-config
    gdb

    # GUI apps
    gimp3-with-plugins
    discord-ptb
    nextcloud-client
    sirikali
    pavucontrol
    nautilus

    # Document related apps
    papers
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };
}
