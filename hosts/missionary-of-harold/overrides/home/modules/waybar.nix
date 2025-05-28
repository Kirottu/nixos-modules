{
  programs.waybar.settings.mainBar = {
    modules-left = [
      "niri/workspaces"
      "tray"
    ];
    modules-center = [

    ];
    modules-right = [
      "pulseaudio"
      "backlight"
      "battery"
      "clock"
    ];
    "niri/workspaces".format-icons = {
      "chat" = "󰭹";
      "web" = "󰖟";
    };
  };
}
