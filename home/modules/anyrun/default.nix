{ pkgs, inputs, ... }:
{
  # home.packages = with anyrun.packages.${system}; [
  #   anyrun-with-all-plugins
  # ];

  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.2;
      };
      width = {
        absolute = 800;
      };
      hidePluginInfo = true;
      ignoreExclusiveZones = true;
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/libkidex.so"
      ];
    };

    extraCss = (builtins.readFile ./style.css);
  };
}
