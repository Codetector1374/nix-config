{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lm_sensors
    qbittorrent
    parsec-bin
  ];
}
