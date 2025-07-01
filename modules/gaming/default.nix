{
  imports = [
    ./vr
    ./applications.nix
  ];

  config = {
    # Various persistent directories needed by games
    impermanence.userDirectories = [
      "Games"
      ".factorio"
      ".renpy"
    ];
  };
}
