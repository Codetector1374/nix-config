{
  config,
  lib,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    nix-diff
    tree
    git
    sudo
    vim
    wget
    curl
  ];
}
