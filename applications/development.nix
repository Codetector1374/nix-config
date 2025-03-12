{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake
    clang-tools # provides clangd
    pkg-config

    python312Packages.compiledb

    rustup
  ];
}