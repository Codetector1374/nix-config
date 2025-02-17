# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ../../common/base.nix
      ../../common/graphical.nix
      ../../applications/embedded.nix
      ../../applications/weeb-games.nix
      ../../applications/misc.nix
      ../../applications/development.nix
      ../../hardware/audio/jbl305p.nix
      ./hardware-configuration.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    gfxmodeEfi = "1280x800";
    enable = true;
    configurationLimit = 30;
    efiSupport = true;
    device = "nodev";
  };

  nix.settings = {
    max-jobs = 0;
    cores = 8;
  };

  nix.buildMachines = [
    {
      hostName = "nixdev";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 4;
      speedFactor = 4;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
	  builders-use-substitutes = true
	'';

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "shintel"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.codetector = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  # Add codetector to group
  users.groups  = {
    plugdev.members = ["codetector"];
    dialout.members = ["codetector"];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

