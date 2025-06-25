{ lib, mylib, ... }:
{
  imports = [ ] ++ mylib.hostSystem "modules/kernel";

  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    kernel.sysctl."kernel.sysrq" = 1;
  };
}
