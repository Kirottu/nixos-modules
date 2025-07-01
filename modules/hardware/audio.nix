{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.audio = {
    pipewire.enable = lib.mkEnableOption "Pipewire";
    easyeffects.enable = lib.mkEnableOption "Easyeffects";
  };

  config = lib.mkMerge [
    (lib.mkIf config.audio.pipewire.enable {
      environment.systemPackages = with pkgs; [
        pwvucontrol
        helvum
      ];

      impermanence.userDirectories = [ ".config/pulse" ];

      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    })
    (lib.mkIf config.audio.easyeffects.enable {
      hm.services.easyeffects.enable = true;
      impermanence.userDirectories = [ ".config/easyeffects" ];
    })
  ];
}
