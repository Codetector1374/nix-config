{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Enable Graphics
  hardware.graphics.enable = true;

  programs.firefox = {
    enable = true;
  };
  programs.waybar.enable = true;

  services.desktopManager.plasma6 = {
      enable = true;
  };

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.hyprland = {
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-mono
    dina-font
    nerdfonts
    font-awesome
  ];

  # Graphical Packages
  environment.systemPackages = with pkgs; [
    inputs.hy3.packages.x86_64-linux.hy3
    (pkgs.writeShellScriptBin "loadHy3"
    ''
    ${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/hyprctl plugin load ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
    '')
    # Hyprland
    rofi-wayland
    # Generic Apps
    kitty
    vscode-fhs
  ];
}