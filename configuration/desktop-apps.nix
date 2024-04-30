{
  config,
  pkgs,
  ...
}: {
  #TODO: Move this to modules? It doesnt inherit base...
  imports = [
    ../modules/appimage.nix
    ../modules/avahi.nix
    ../modules/biometrics.nix
    ../modules/bluetooth.nix
    ../modules/dir-env.nix
    ../modules/docker.nix
    ../modules/flatpak.nix
    ../modules/fetchers.nix
    ../modules/fwupd.nix
    ../modules/fonts.nix
    ../modules/games.nix
    ../modules/gui-apps.nix
    ../modules/iphone.nix
    ../modules/localsend.nix
    ../modules/ntfs.nix
    ../modules/obs.nix
    #../modules/postgres.nix
    ../modules/printing.nix
    ../modules/python.nix
    ../modules/quickemu.nix # Run VMS easily
    ../modules/tlp.nix
    # Use it from nix shell rather
    #../modules/rstudio.nix
    ../modules/screen-control.nix
    ../modules/sound.nix
    ../modules/ssdtrim.nix
    ../modules/steam.nix
    ../modules/syncthing.nix
    ../modules/trezor.nix
    ../modules/yubikey.nix
    # For logging in using yubikey
    #../modules/yubikey-auth.nix
    ../modules/wine.nix
    ../modules/virt.nix
    ../modules/zfs-sanoid.nix
  ];
}
