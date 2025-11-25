# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../hardware/scanner.nix
      ../../hardware/audio/jbl305p.nix
      ../../common/base.nix
      ../../common/graphical.nix
      ../../applications/development.nix
      ../../applications/misc.nix
      ../../applications/weeb-games.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    enable = true;
    configurationLimit = 30;
    efiSupport = true;
    device = "nodev";
    efiInstallAsRemovable = true;
  };

  networking.hostName = "chiori"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Los_Angeles";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.codetector = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp" ]; # Enable ‘sudo’ for the user.
    packages = [
      (pkgs.callPackage ../../applications/ida-pro/ida-pro.nix {})
    ];
  };

  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  system.stateVersion = "25.05"; # Did you read the comment?
}
