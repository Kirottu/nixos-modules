{
  programs.git = {
    enable = true;
    userEmail = "arnovaara@gmail.com";
    userName = "Kirottu";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
  };
}
