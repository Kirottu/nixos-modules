{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    mainUser = {
      userName = lib.mkOption {
        default = "kirottu";
        description = "Username";
        type = lib.types.nonEmptyStr;
      };
      hashedPassword = lib.mkOption {
        type = lib.types.nonEmptyStr;
        description = "Password hash for user";
      };
      extraGroups = lib.mkOption {
        type = with lib.types; listOf nonEmptyStr;
        default = [ ];
        description = "Extra groups for the main user";
      };
      shell = lib.mkOption {
        type = lib.types.package;
        description = "Login shell";
      };
    };
  };

  config = {
    users = {
      mutableUsers = false;
      users.${config.mainUser.userName} = {
        isNormalUser = true;
        hashedPassword = config.mainUser.hashedPassword;
        shell = config.mainUser.shell;
        extraGroups = config.mainUser.extraGroups ++ [
          "wheel"
          "video"
          "input"
          "audio"
        ];
      };
    };
  };
}
