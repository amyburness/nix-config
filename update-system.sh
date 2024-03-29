#!/usr/bin/env bash

# Fetch latest changes and deploy
# Expects this repo to be checked out in /root/nix-config
# Tim Sutton 2023

if [ "$EUID" -ne 0 ]
  then 
    echo "🛑Run this as SUDO!"
  exit
fi

nix build
nixos-rebuild switch --flake .
