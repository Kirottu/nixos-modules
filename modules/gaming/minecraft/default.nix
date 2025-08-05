{
  config,
  pkgs,
  lib,
  ...
}:
let
  glfw = pkgs.glfw3-minecraft.overrideAttrs {
    patches = [
      ./glfw-patches/0001-Key-Modifiers-Fix.patch
      ./glfw-patches/0002-Fix-duplicate-pointer-scroll-events.patch
      ./glfw-patches/0003-Implement-glfwSetCursorPosWayland.patch
      ./glfw-patches/0004-Fix-Window-size-on-unset-fullscreen.patch
      ./glfw-patches/0005-Add-warning-about-being-an-unofficial-patch.patch
      ./glfw-patches/0006-Avoid-error-on-startup.patch
      ./glfw-patches/0007-Fix-fullscreen-location.patch
      ./glfw-patches/0008-Fix-forge-crash.patch
    ];

  };
in
{
  options.gaming.prismlauncher.enable = lib.mkEnableOption "Prismlauncher";

  config = lib.mkIf config.gaming.prismlauncher.enable lib.utils.mkApp {
    package = pkgs.prismlauncher.override {
      glfw3-minecraft = glfw;
    };
    userDirectories = [ ".local/share/PrismLauncher" ];
  };
}
