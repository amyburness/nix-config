{ pkgs, ... }:

{

  environment.interactiveShellInit = ''
    # Add anything that must be in bashrc here
    echo "Nix environment with setup configs by Tim."
    neofetch
  '';

  # Example of how to add a config file in etc
  #environment.etc."starship.toml" = {
    #mode = "0555";
    #source = ../dotfiles/starship.toml;
  #};

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Example of adding aliases for bash commands
  programs.bash.shellAliases = {
    ls = "exa";
    cat = "bat";
    find = "fd";
    l = "ls -alh";
    ll = "ls -l";
    psql = "pgcli";
    open = "xdg-open";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    asciinema
    bat
    btop
    cowsay
    exa
    fd
    ffmpeg_5-full
    figlet
    git
    gotop
    iftop
    imagemagickBig
    lazydocker
    mc
    ncdu
    neofetch
    nethogs
    pgcli
    wget
  ];
}
