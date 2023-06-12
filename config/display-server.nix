{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #hardware.opengl.enable = true;
  programs.xwayland.enable = true;

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xdg-desktop-portal   
  ];

}
