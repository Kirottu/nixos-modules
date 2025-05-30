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
        padding-right: 40px;
        padding-left: 40px;
        background:
          linear-gradient(135deg, transparent 30px, @l1 30px, @l1 100px, transparent 100px),
          linear-gradient(-45deg, transparent 30px, @l1 30px, @l1 70px, @l3 70px, @l3 100px, @l1 100px, @l1 200px, transparent 200px);
        border: none;
        box-shadow: none;
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
