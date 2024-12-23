{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Gotta have flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # I18N
  i18n.defaultLocale = "en_US.UTF-8";

  # Programs
  programs.zsh = {
    enable = true;
  };

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
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
