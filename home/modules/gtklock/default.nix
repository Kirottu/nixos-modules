let
  wallpaper = ../theming/marker-of-harold.png;
in
{
  imports = [
    ./home-manager.nix
  ];

  programs.gtklock = {
    enable = true;
    settings.main = {
      start-hidden = false;
      follow-focus = true;
      time-format = "%H:%M:%S";
    };
    style = ''
      @define-color l4 #1a000d;
      @define-color l3 #33001a;
      @define-color l2 #4d0026;
      @define-color l1 #660033;

      window {
        background-image: url("${wallpaper}");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        background-color: black;
      }

      #input-label {
        font-size: 0px;
      }

      entry {
        min-height: 40px;
        background:
          linear-gradient(45deg, transparent 200px, @l3 200px, @l3 230px, transparent 230px),
          @l1;
        border: none;
        box-shadow: 0 0 5px black;
        border-radius: 0;
      }

      button {
        color: transparent;
        background: transparent;
        font-size: 0px;
        min-width: 0px;
      }
    '';
  };
}
