{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      # theme = "hud_space";
      # themePackages = with pkgs; [
      #   (adi1090x-plymouth-themes.override {
      #     selected_themes = [ "hud_space" ];
      #   })
      # ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    loader.timeout = 0;
  };
}
