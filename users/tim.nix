{
  config,
  desktop,
  hostname,
  inputs,
  lib,
  outputs,
  pkgs,
  stateVersion,
  username,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  isLima = builtins.substring 0 5 hostname == "lima-";
  isWorkstation =
    if (desktop != null)
    then true
    else false;
  isTimMachine =
    if (hostname == "crest" || hostname == "waterfall" || hostname == "valley")
    then true
    else false;
in {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from tim.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    initialPassword = "timlinux";
    description = "Tim Sutton";
    extraGroups = [
      "wheel"
      "disk"
      "libvirtd"
      "dialout" # needed for arduino
      "docker"
      "audio"
      "video"
      "input"
      "systemd-journal"
      "networkmanager"
      "network"
      "davfs2"
      "adbusers"
      "scanner"
      "lp"
      "lpadmin"
      "i2c"
    ];
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./public-keys/id_ed25519_tim.pub)
    ];
    packages = with pkgs; [
      popcorntime
      freetube
    ];
  };

  # Shameless hardcoding here for now
  # We want this folder mounted in a location
  # That will be the same for all users and hosts
  # so that we can share OBS scene configs
  fileSystems."/home/KartozaInternal" = {
    device = "/home/timlinux/Syncthing/KartozaInternal";
    fsType = "none";
    options = ["bind" "rw"];
  };

  home-manager = {
    users.timlinux.home.stateVersion = "23.11";
    users.timlinux = {
      imports = [
        ../home
        # Not provisioned to all users...
        ../home/home-config/web-apps/chromium/proton-mail.nix
      ];
      programs = {
        git = {
          userName = "Tim Sutton";
          userEmail = "tim@kartoza.com";
          extraConfig = {
            github.user = "timlinux";
            gitlab.user = "tim@kartoza.com";
          };
          # rest of git is configured in ../home/git..
        };
      };
    };
  };
}
