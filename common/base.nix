{
  config,
  lib,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    nix-diff
    killall
    file
    zip
    unzip
    rofi-wayland
    kitty
    tree
    git
    sudo
    vim
    wget
    cmake
    meson
    cpio
    curl
  ];
}
