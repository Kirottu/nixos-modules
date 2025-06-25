let
  flake = "path:/home/kirottu/.config/nixos";
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      rb-switch = "sudo nixos-rebuild switch --flake ${flake}";
      rb-boot = "sudo nixos-rebuild boot --flake ${flake}";
      rb-upgrade = "nix flake update --flake ${flake} && sudo nixos-rebuild switch --flake ${flake} --upgrade-all";
    };
    interactiveShellInit = ''
      set fish_greeting

      if status is-login
        if test -z $WAYLAND_DISPLAY && test -z $DISPLAY && test $XDG_VTNR = 1
          exec niri-session
        end
      end'';
  };
}
