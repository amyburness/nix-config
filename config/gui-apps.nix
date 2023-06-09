{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-kde-theme
    audacity
    blender
    dbeaver
    deja-dup
    drawio
    firefox
    flameshot
    gimp
    # Needed for gnome boxes
    qemu_kvm
    virt-manager
    gnucash
    google-chrome
    inkscape
    kdenlive
    keepassxc
    libreoffice-fresh
    # For multilingual spell check in logseq, edit 
    # vim ~/.config/Logseq/Preferences
    # and add e.g.
    # {"spellcheck":{"dictionaries":["en-GB","pt"],"dictionary":""}}
    # TODO is to automate this with home manager....
    logseq
    mpv # videa player
    nextcloud-client
    obs-studio
    paperwork
    qtcreator
    slack
    synfigstudio
    tdesktop
    xournalpp
    zap #Java application for web penetration testing
  ];
}

