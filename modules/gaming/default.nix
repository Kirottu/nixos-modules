{
  imports = [
    ./vr
    ./applications.nix
  ];

  config = {
    # Various persistent directories needed by games
    impermanence.userDirectories = [
      ".factorio"
      ".renpy"
    ];
  };
}
