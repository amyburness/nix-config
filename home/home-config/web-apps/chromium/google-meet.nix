{
  config,
  pkgs,
  ...
}: let
  siteUrl = "https://meet.google.com";
  appName = "Google Meet";
  iconName = "google-meet.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."google_meet_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    gmailApp = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="${siteUrl}"'';
      icon = iconPath;
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Video"];
    };
  in [meetApp];
}
