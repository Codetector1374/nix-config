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

  security.pam.services.sddm.enableKwallet = true;
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  xdg.menus.enable = true;

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

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "codetector" ];
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        kdePackages.fcitx5-qt
        fcitx5-chinese-addons
        fcitx5-nord
      ];
    };
  };

  # Graphical Packages
  environment.systemPackages = with pkgs; [
    inputs.hy3.packages.x86_64-linux.hy3
    (pkgs.writeShellScriptBin "loadHy3"
    ''
    ${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/hyprctl plugin load ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
    '')
    # Hyprland
    kdePackages.plasma-workspace
    rofi-wayland
    hyprpaper
    hypridle
    hyprlock
    hyprsunset
    swaynotificationcenter
    # Volume Contro
    pavucontrol
    # Generic Apps
    google-chrome
    discord
    usbutils
    kitty
    vscode-fhs
    telegram-desktop
    signal-desktop
  ];
}
