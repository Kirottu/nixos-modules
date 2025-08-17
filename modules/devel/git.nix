{
  config = {
    hm.programs.git = {
      enable = true;
      userEmail = "arnovaara@kirottu.com";
      userName = "Arno Vaara";
      signing.signByDefault = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    hm.programs.gh = {
      enable = true;
    };
    impermanence.userFiles = [
      ".config/gh/hosts.yml"
    ];
  };
}
