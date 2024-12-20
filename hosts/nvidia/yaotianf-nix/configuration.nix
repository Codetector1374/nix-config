{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../common/base.nix
    ../../../common/headless.nix
    ../../../common/work-dev.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    gfxmodeEfi = "1280x800";
    enable = true;
    configurationLimit = 30;
    efiSupport = true;
    device = "nodev";
  };

  users.users.yaotianf = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  networking = {
    hostName = "yaotianf-nix";
    domain = "dyn.nvidia.com";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  services.ddclient = {
    enable = true;
    interval = "1min";
    protocol = "nsupdate";
    server = "nsupdate.nvidia.com";
    ssl = false;
    usev4 = "ifv4, if=enp6s0";
    usev6 = "disabled";
    zone = "dyn.nvidia.com";
    domains = [ "yaotianf-nix.dyn.nvidia.com" ];
    passwordFile = "${pkgs.writeText "" ""}";
  };
# TODO: upstream this fix, usev6 should find ifv4 not if.
  systemd.services.ddclient.path = [ pkgs.iproute2 ];

  system.stateVersion = "24.05"; # Don't touch this
}

