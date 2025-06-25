{ inputs, mylib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ] ++ mylib.hostSystem "modules/impermanence.nix";

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/systemd/coredump"
      "/var/lib/nixos"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.kirottu = {
      directories = [
        "Nextcloud"
        "Downloads"
        "Projects"
        "Games"
        "git"

        ".cargo"
        ".zen"
        ".mozilla"
        ".steam"
        ".cache"
        ".wine"

        ".factorio"
        ".renpy"

        # Basically application managed state
        # Should be fine to glob like this
        ".local/state"
        ".local/share"

        ".config/Nextcloud"
        ".config/discordptb"
        ".config/dconf"
        ".config/pulse"
        ".config/nixos"
        ".config/easyeffects"
        ".config/heroic"

        {
          directory = ".pki";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".gnupg";
          mode = "0700";
        }
      ];
      files = [
        ".config/gh/hosts.yml"
        ".config/gtk-3.0/bookmarks"
      ];
    };
  };
}
