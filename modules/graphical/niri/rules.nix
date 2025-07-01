{ config, lib, ... }:
{
  config.hm.programs.niri.settings.window-rules = [
    {
      open-floating = false;
    }
  ];
}
