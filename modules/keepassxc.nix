# See also this video for setting up HMAC 
# YubiKey based access https://www.youtube.com/watch?v=ATvNK5LKpv8
{  system ? builtins.currentSystem, pkgs, config, ... }:
let
	unstable = import
		(builtins.fetchTarball {
                   url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
                   sha256="1g8wq4bfq9y1h2qch8nac31sas3lgrbxra7lcc5hj9jgyrzjsm3y";
                })
		# reuse the current configuration
		{ 
                   inherit system;
                   config = config.nixpkgs.config; };
in
{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    unstable.keepassxc
  ];
}

