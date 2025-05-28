{
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/kirottu/.config/nixos";
      rebuild-upgrade = "sudo nixos-rebuild switch --upgrade-all --flake /home/kirottu/.config/nixos";
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
