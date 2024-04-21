{ config, pkgs, ... }:

{
  # make the tailscale command usable to users
  environment.systemPackages = [ pkgs.tailscale ];

  # enable the tailscale service
  services.tailscale.enable = true;


  # Optional (default: 41641):
  services.tailscale.port = 41641;

  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.checkReversePath = "loose";

  # Now configure from the command line like this:
  # systemctl status tailscale

  # Finally, perform an initial authentication for this machine and you’re done.
  # sudo tailscale login
  # sudo tailscale up

  # Validate:
  # ip link show tailscale0
  # journalctl -fu tailscale

  #
  # Last important note:
  # On the adguard/pihole host in your network
  # you need to tell it NOT to use the DNS servers from 
  # tailscale for external DNS resolution otherwise
  # we will get stuck in a recursion hole. To do this
  # (only on the adguard host) do rather:
  # tailscale up --accept-dns=false

}

