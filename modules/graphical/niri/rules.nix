{ config, lib, ... }:
{
  config.hm.programs.niri.settings.window-rules = [
    {
      open-floating = false;
    }
    {
      matches = [
        {
          app-id = "^(webapp-cinny|discord)$";
        }
      ];
      open-on-workspace = "chat";
    }
    {
      matches = [
        {
          app-id = "^steam$";
        }
      ];
      open-on-workspace = "games";
    }
  ];
}
