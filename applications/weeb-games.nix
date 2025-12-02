{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
#    inputs.aagl.nixosModules.default
  ];

#  nix.settings = inputs.aagl.nixConfig;

#  programs.anime-game-launcher.enable = true;
#  programs.anime-games-launcher.enable = true;
}
