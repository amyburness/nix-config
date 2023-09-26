{ config, pkgs, ... }:

{
   #xfce
   services.xserver.desktopManager.xfce.enable  = true;
   services.xserver.displayManager.defaultSession  = "xfce";
   xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment = {
    systemPackages = with pkgs; [
      blueman
      chromium
      drawing
      elementary-xfce-icon-theme
      evince
      font-manager
      gnome.file-roller
      gnome.gnome-disk-utility
      libqalculate
      orca
      pavucontrol
      qalculate-gtk
      wmctrl
      xclip
      xcolor
      xcolor
      xdo
      xdotool
      xfce.catfish
      xfce.orage
      xfce.gigolo
      xfce.xfburn
      xfce.xfce4-appfinder
      xfce.xfce4-clipman-plugin
      xfce.xfce4-cpugraph-plugin
      xfce.xfce4-dict
      xfce.xfce4-fsguard-plugin
      xfce.xfce4-genmon-plugin
      xfce.xfce4-netload-plugin
      xfce.xfce4-panel
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-weather-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-xkb-plugin
      xfce.xfdashboard
      xorg.xev
      xsel
      xwinmosaic
      zuki-themes
    ];
  };

}
