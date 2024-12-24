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
    clang_19
    pkg-config

    python312Packages.compiledb

    rustup
  ];
}