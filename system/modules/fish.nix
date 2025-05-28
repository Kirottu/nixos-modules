{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
  };

  # Prevents very long man-cache step on build
  documentation.man.generateCaches = false;
}
