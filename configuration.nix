# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports =
    [ 
      ## this needs to be first
      config/console-apps.nix
      config/bootsplash.nix
      config/appimage.nix
      #config/android-sdk.nix
      #config/blocky.nix # Ad blocker
      #config/upgrades.nix
      # Use direnv in arduino dev folder rather
      #config/arduino.nix
      config/avahi.nix
      config/biometrics.nix
      #config/ccache.nix
      #config/cron-crest.nix
      config/dir-env.nix
      #config/distrobox.nix
      config/docker.nix
      config/fwupd.nix
      config/fonts.nix
      config/games.nix
      config/display-server.nix
      #../../config/kde-plasma6.nix
      config/gnome-desktop-wayland.nix
      config/gnome-desktop-gdm.nix
      config/gnome-desktop-apps.nix
      config/gnome-desktop-extensions.nix
      config/gnome-desktop-themes.nix
      #config/gnome-desktop-x11.nix
      #config/deepin-desktop.nix
      #config/budgie-deskop.nix
      #config/plasma-desktop.nix
      #config/xfce-desktop.nix
      #config/pantheon-desktop.nix
      config/gui-apps.nix
      config/harden.nix
      config/iphone.nix
      config/locale-pt-en.nix
      config/keepassxc.nix
      #config/locale-za-en.nix
      config/localsend.nix
      # Dont enable when using wayland - causes screen flickr
      #config/nvidia.nix
      #config/nagios.nix
      config/ntfs.nix
      config/obs.nix
      #config/postgres.nix
      #config/nixos-conf-editor.nix
      config/printing.nix
      #config/python.nix
      #config/qtcreator.nix
      config/qgis.nix # Upstream packaged version
      config/quickemu.nix # Run VMS easily
      #../../config/qgis-dev.nix # My own overlay mainsha256-xpOF/0qFuvTUWQ1I8x/gy5qSLKzSgcQahS47PG+bTRA=
      #config/tilemaker.nix 
      #config/rstudio.nix
      config/screen-control.nix
      config/ssh.nix
      config/starship.nix
      config/steam.nix
      config/syncthing.nix
      config/tailscale.nix
      config/trezor.nix
      config/uxplay.nix
      config/vim.nix
      #config/yubikey.nix #using biometrics rather
      config/vscode.nix
      #config/wacom.nix
      config/unstable-apps.nix
      config/wine.nix
      config/virt.nix
      config/zfs.nix
      users/all.nix
      users/tim.nix
      users/guest.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid
  # for notes on how I set up zfs
  services.zfs.autoScrub.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.requestEncryptionCredentials = true;
  
  networking.hostName = "crest"; # Define your hostname.
  networking.hostId = "d13e0d41"; # needed for zfs

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   home-manager 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ### Flakes support
      
  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  ###
  ### Bleeding edge kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;


}