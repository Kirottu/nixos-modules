{
  environment.persistence."/persistent" = {
    directories = [
      "/etc/lact"
    ];
    users.kirottu = {
      directories = [
        ".librewolf"

        ".config/dolphin-emu"
        ".config/wivrn"
        ".config/wlxoverlay"
        ".config/lact"
        ".config/bs-manager"

        ".local/share/dolphin-emu"
        ".local/share/wayvr-dashboard"
        ".local/share/dev.oo8.wayvr-dashboard"
      ];
    };
  };
}
