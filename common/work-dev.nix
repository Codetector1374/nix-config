{
  config,
  lib,
  pkgs,
  ...
} : {
  environment.systemPackages = with pkgs; [
    autossh
    p4
  ];
}
