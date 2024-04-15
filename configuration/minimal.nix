{ config,pkgs,... }: 
{
  imports = [
    ./base.nix
    ../modules/gnome-desktop-wayland.nix
    ../modules/gnome-desktop-gdm.nix
    ../modules/gnome-desktop-apps.nix
    ../modules/gnome-desktop-extensions.nix
    ../modules/gnome-desktop-themes.nix
  ];
}
