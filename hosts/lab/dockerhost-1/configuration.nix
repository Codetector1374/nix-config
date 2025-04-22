# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../../services/docker.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "dockerhost-1"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  networking.interfaces.ens18 = {
    name = "ens18";
    useDHCP = false;
    ipv4.addresses = [{
      address = "10.45.1.200";
      prefixLength = 16;
    }];
    wakeOnLan.enable = false;
  };
  networking.defaultGateway = "10.45.0.1";
  networking.nameservers = ["1.1.1.1" "1.0.0.1" "8.8.8.8"];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}
