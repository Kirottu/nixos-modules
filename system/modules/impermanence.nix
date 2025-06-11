{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

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
        "git"

        ".cargo"
        ".zen"
        ".mozilla"

        ".local/state"
        ".local/share/fish"
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }

        ".config/Nextcloud"
        ".config/discordptb"
        ".config/dconf"
        ".config/pulse"
        ".config/nixos"

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
      ];
    };
  };
}
