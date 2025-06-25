{ pkgs, lib, ... }:
{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      assistant = {
        enabled = false;
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };
        nix = {
          binary = {
            path = lib.getExe pkgs.nix;
          };
        };
      };

      theme = {
        mode = "dark";
        dark = "Ayu Dark";
        light = "Ayu Light";
      };

      vim_mode = true;
      load_direnv = "shell_hook";

    };
  };
}
