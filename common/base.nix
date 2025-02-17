{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
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

  programs.git.enable = true;

  # Emacs
  services.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  services.lorri.enable = true;

  environment.systemPackages = with pkgs; [
    python312Full
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
  ];
}
