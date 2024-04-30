{pkgs, ...}:
pkgs.writeShellApplication {
  name = "utils";
  runtimeInputs = [
    pkgs.bash
    pkgs.gum # UX for TUIs
    pkgs.skate # Distributed key/value store
    pkgs.onefetch # Gives stats on this git repo
    pkgs.neofetch # Gives stats on this system
    pkgs.ipfetch # Gives info on your ISP
    pkgs.cpufetch # Info about your CPU
    pkgs.ramfetch # And your RAM
    pkgs.starfetch # Tell you interesing info about a star cluster
    pkgs.octofetch # Tell you about a github user e.g. octofetch timlinux
    pkgs.sysbench # CPU Benchmarking utility
  ];
  text = builtins.readFile ./utils.sh;
}
