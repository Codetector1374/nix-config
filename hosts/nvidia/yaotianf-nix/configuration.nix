{ 
  config, 
    lib, 
    pkgs, 
    ... 
}: {
  imports = [
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

  networking.hostName = "yaotianf-nix"; 
  networking.domain = "dyn.nvidia.com"; 
  networking.networkmanager.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkb.options in tty.
# };

# Enable the X11 windowing system.
# services.xserver.enable = true;

# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable sound.
# hardware.pulseaudio.enable = true;
# OR
# services.pipewire = {
#   enable = true;
#   pulse.enable = true;
# };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.yaotianf = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        fd
        ripgrep
        findutils
        git
        emacs
      ];
  };

  environment.systemPackages = with pkgs; [
    nix-diff
    tree
    git
    sudo
    vim
    wget
    curl
  ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

  services.openssh.enable = true;

  networking.firewall.enable = false;
  system.stateVersion = "24.05"; # Don't touch this
}

