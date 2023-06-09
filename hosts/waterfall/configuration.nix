# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #../../config/android-sdk.nix
      ../../config/upgrades.nix
      ../../config/arduino.nix
      ../../config/ccache.nix
      ../../config/console-apps.nix
      ../../config/cron-waterfall.nix
      ../../config/dir-env.nix
      ../../config/display-server.nix
      ../../config/docker.nix
      ../../config/fonts.nix
      ../../config/games.nix
      #../../config/plasma-desktop.nix
      #../../config/gnome-desktop.nix
      ../../config/pantheon-desktop.nix
      ../../config/gui-apps.nix
      ../../config/locale-pt-en.nix
      ../../config/nvidia.nix
      ../../config/obs.nix
      ../../config/printing.nix
      ../../config/ntfs.nix
      ../../config/postgres.nix
      ../../config/python.nix
      ../../config/qgis.nix
      ../../config/qgis-dev.nix
      ../../config/ssh.nix
      ../../config/starship.nix
      ../../config/syncthing.nix
      ../../config/tailscale.nix
      ../../config/uxplay.nix
      ../../config/vim.nix
      ../../config/yubikey.nix
      ../../config/vscode.nix
      ../../users/all.nix
      ../../users/tim.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "waterfall"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  ## Tweak by Tim to use adguard home
  #networking.nameservers = [ "100.100.68.130" ];
  # These last two are the public adguard services to block
  # ads, adult content etc. They will be overwritten by
  # tailscale if it is running, so they are just a backup for
  # when tailscale is down...
  # See https://adguard-dns.io/kb/general/dns-providers/?utm_campaign=dns_kb_providers&utm_medium=ui&utm_source=home
  networking.nameservers = [ "94.140.14.15" "94.140.15.16" ];

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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     neovim
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     libimobiledevice # Iphone support
     ifuse # optional, to mount using 'ifuse' for iPhone
     # task tray for gnome
     gnomeExtensions.appindicator
     xf86_input_wacom
     usbutils
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

  ### 
  ### Additions by Tim (see also pkgs sections above)
  ###
  
  ### Flakes support
      
  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ###
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;

  ##
  ## iPhone Support
  ## 
  services.usbmuxd.enable = true;


}
