{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.aagl.nixosModules.default
  ];

  programs.anime-games-launcher.enable = true;
}