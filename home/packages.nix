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
    # CLI tools
    imagemagick
    brightnessctl
    killall
    file
    libnotify
    usbutils
    cloc
    steam-run
    wget
    htop
    gamescope
    android-tools
    pulseaudio
    libqalculate

    # Compression/decompression
    unzip
    p7zip
    unrar-wrapper

    # Development stuff
    ## Rust
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
    prismlauncher
    heroic
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
