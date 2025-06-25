{
  programs.waybar.settings.mainBar = {
    modules-left = [
      "niri/workspaces"
      "tray"
    ];
    modules-center = [

    ];
    modules-right = [
      "cpu"
      "memory"
      "clock"
    ];
    "niri/workspaces".format-icons = {
      "chat" = "󰭹";
      "web-dp1" = "󰖟";
      "web-dp2" = "󰖟";
      "web-dp3" = "󰖟";
      "utils" = "";
      "games" = "󰸻";
      "vr" = "󰢔";
    };
  };
}
