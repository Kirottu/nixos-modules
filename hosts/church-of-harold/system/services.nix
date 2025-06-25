{ pkgs, ... }:
{
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.udev = {
    # Workaround for premature wakeups
    extraRules = ''
      ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
    '';
    packages = with pkgs; [ android-udev-rules ];
  };

  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;

  services.scx = {
    enable = true;
    scheduler = "scx_flash";
  };
}
