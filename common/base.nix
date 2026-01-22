{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://an-anime-team.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "an-anime-team.cachix.org-1:nr9QXfYG5tDXIImqxjSXd1b6ymLfGCvviuV8xRPIKPM="
    ];
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  hardware.enableAllFirmware = true;
  
  # Gotta have flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # No IPv6, god knows how it works
  networking.enableIPv6 = false;

  # Gotta use VIM
  environment.variables.EDITOR = "vim";

  environment.etc."tmpfiles.d/thp.conf".text = ''
    w /sys/kernel/mm/transparent_hugepage/enabled         - - - - always
  '';

  # I18N
  i18n.defaultLocale = "en_US.UTF-8";

  # Programs
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  users.defaultUserShell = pkgs.zsh;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Emacs
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.lorri.enable = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    nixfmt-classic
    python3
    direnv
    pciutils
    gawk
    diffutils
    fd
    rsync
    openssh
    ripgrep
    findutils
    emacs
    htop
    nix-diff
    killall
    file
    zip
    unzip
    tree
    sudo
    vim
    wget
    cmake
    meson
    cpio
    curl

    uv
    conda
    tmux

    ncdu

    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
