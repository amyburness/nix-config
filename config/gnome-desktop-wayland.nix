{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Currently I have issues running wayland like flashing windows etc.
  # if enabling this with the nvidia driver so be sure to 
  # switch off nvidia dribers in configuration.nix if using this
  services.xserver.displayManager.gdm.wayland = true;

  programs.xwayland.enable = true;
  
  environment.variables = {
    # Hack for broken drag and drop in Qt apps (including QGIS) - only works in wayland
    QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    QT_STYLE_OVERRIDE = "adwaita";
  };

  #qt.platformTheme = "gnome";
  # Set the background by default to Kartoza branding
  # Note that it will not override the setting if it already exists
  # so only visible on new installs
  environment.etc."kartoza-wallpaper.png" = {
    mode = "0555";
    source = ../resources/kartoza-wallpaper.png;
  };
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.background]
    picture-uri='file:///etc/kartoza-wallpaper.png'
    picture-uri-dark='file:///etc/kartoza-wallpaper.png'
  '';
  environment.interactiveShellInit = ''
    # Set manually like this (once for light theme, once for dark)
    gsettings set org.gnome.desktop.background picture-uri file:///etc/kartoza-wallpaper.png
    gsettings set org.gnome.desktop.background picture-uri-dark file:///etc/kartoza-wallpaper.png
  '';
  nixpkgs.overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope' (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or []) ++ [
              (let
                bg = pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/timlinux/nix-config/main/resources/kartoza-wallpaper.png";
                  sha256 = "sha256-HC7mzX/iLSHbK9sz8DVPj98skSWrzIbXc2Am29mMyOM=";
                };
              in pkgs.writeText "bg.patch" ''
                --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
                 /* Login Dialog */
                 .login-dialog {
                   background-color: $_gdm_bg;
                +  background-image: url('file://${bg}');
                 }
              '')
            ];
          });
        }); 
      })
  ];
  # Things we do not want installed
  environment.gnome.excludePackages = with pkgs.gnome; [
    # baobab      # disk usage analyzer
    # cheese      # photo booth
    # eog         # image viewer
    # epiphany    # web browser
    # gedit       # text editor
    # simple-scan # document scanner
    # totem       # video player
    # yelp        # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    geary       # email client
    # seahorse    # password manager

    # these should be self explanatory
    # gnome-calculator 
    gnome-calendar 
    # gnome-characters 
    # gnome-clocks 
    # gnome-contacts
    # gnome-font-viewer 
    # gnome-logs 
    gnome-maps 
    # gnome-music 
    # gnome-photos 
    # gnome-screenshot
    # gnome-system-monitor 
    # gnome-weather 
    # gnome-disk-utility 
    pkgs.gnome-connections
  ];

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xdg-desktop-portal   
    theme-obsidian2
    adementary-theme
    lounge-gtk-theme
    zuki-themes
    yaru-theme
    yaru-remix-theme
    xorg.xcursorthemes
    whitesur-gtk-theme
    vimix-gtk-themes
    theme-jade1
    tela-circle-icon-theme
    stilo-themes
    spacx-gtk-theme
    solarc-gtk-theme
    sierra-gtk-theme
    shades-of-gray-theme
    qogir-theme
    qogir-icon-theme
    pop-icon-theme
    pop-gtk-theme
    plata-theme
    plano-theme
    papirus-maia-icon-theme
    papirus-icon-theme
    paper-icon-theme
    paper-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.elementary-gtk-theme
    palenight-theme
    orchis-theme
    oranchelo-icon-theme
    omni-gtk-theme
    oceanic-theme
    numix-sx-gtk-theme
    numix-solarized-gtk-theme
    numix-icon-theme-square
    numix-icon-theme-circle
    numix-icon-theme
    numix-gtk-theme 
    
  ];

}
