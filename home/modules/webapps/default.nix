{
  pkgs,
  lib,
  config,
  ...
}:
let
  mkWebapp =
    profile: title: url: icon:
    let
      data-dir = "webapps/${profile}";
      firefox = (
        pkgs.wrapFirefox (
          pkgs.firefox-unwrapped.override {

          }
        )
      );
    in
    {
      xdg.dataFile = {
        "${data-dir}/user.js".source = ./firefox-profile/user.js;
        "${data-dir}/chrome/userChrome.css".source = ./firefox-profile/chrome/userChrome.css;
        "${data-dir}/places.sqlite" = {
          source = ./firefox-profile/places.sqlite;
          force = true;
        };
        "${data-dir}/search.json.mozlz4" = {
          source = ./firefox-profile/search.json.mozlz4;
          force = true;
        };
      };

      xdg.desktopEntries."webapp-${profile}" = {
        name = title;
        icon = icon;
        startupNotify = true;
        type = "Application";
        exec = lib.concatStrings [
          "/bin/sh -c \"XAPP_FORCE_GTKWINDOW_ICON=${icon} ${lib.getExe pkgs.firefox}"
          " --class webapp-${profile}"
          " --name webapp-${profile}"
          " --profile ${config.home.homeDirectory}/.local/share/${data-dir}" # FIXME: Surely there's a better way
          " --no-remote"
          " ${url}\""
        ];
        settings = {
          StartupWMClass = "webapp-${profile}";
        };
      };
    };
in
lib.mkMerge [
  {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [
        ((pkgs.callPackage ./open-in-native-client.nix { bins = [ pkgs.xdg-utils ]; }))
      ];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
      };
    };
  }
  (mkWebapp "cinny" "Cinny" "https://app.cinny.in" "dialog-messages")
]
