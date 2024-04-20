{ config, pkgs, ... }:
{
  # See also home/gtk
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal   
    xorg.xcursorthemes
    theme-obsidian2
    #adementary-theme
    #lounge-gtk-theme
    #zuki-themes
    #yaru-theme
    #yaru-remix-theme
    #whitesur-gtk-theme
    #vimix-gtk-themes
    #theme-jade1
    #tela-circle-icon-theme
    #stilo-themes
    #spacx-gtk-theme
    #solarc-gtk-theme
    #sierra-gtk-theme
    #shades-of-gray-theme
    #qogir-theme
    #qogir-icon-theme
    #pop-icon-theme
    #pop-gtk-theme
    #plata-theme
    #plano-theme
    #papirus-maia-icon-theme
    #papirus-icon-theme
    #paper-icon-theme
    #paper-gtk-theme
    #pantheon.elementary-icon-theme
    #pantheon.elementary-gtk-theme
    #palenight-theme
    #orchis-theme
    #oranchelo-icon-theme
    #omni-gtk-theme
    #oceanic-theme
    #numix-sx-gtk-theme
    #numix-solarized-gtk-theme
    #numix-icon-theme-square
    #numix-icon-theme-circle
    #numix-icon-theme
    #numix-gtk-theme 
  ];
}
