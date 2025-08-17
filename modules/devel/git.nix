{
  config = {
    hm.programs.git = {
      enable = true;
      userEmail = "arnovaara@gmail.com";
      userName = "Kirottu";
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
