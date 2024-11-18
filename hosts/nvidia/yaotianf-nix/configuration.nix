{ 
  config, 
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../common/base.nix
    ../../../common/user_nvidia.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    gfxmodeEfi = "1280x800";
    enable = true;
    configurationLimit = 30;
    efiSupport = true;
    device = "nodev";
  };

  networking = {
    hostName = "yaotianf-nix";
    domain = "dyn.nvidia.com";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Don't touch this
}

