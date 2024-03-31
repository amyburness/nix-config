{ config, pkgs, ... }:
{
  # Inspired by https://discourse.nixos.org/t/grub-theme-help/24384/2
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "1";
    src = pkgs.fetchFromGitHub {
      owner = "kartoza";
      repo = "kartoza-grub-theme";
      rev = "main";
      hash = "";
    };
    installPhase = "ls -lah themes; mkdir nixos; tar -xf themes/nixos.tar -C nixos; ls -lah; cp -r nixos $out/";
  };
}
