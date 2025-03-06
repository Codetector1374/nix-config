{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Enable Graphics
  hardware.graphics.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox = {
    enable = true;
  };

  services.desktopManager.plasma6 = {
      enable = true;
  };

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  security.pam.services.sddm.kwallet.enable = true;

  xdg.menus.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.hyprland = {
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    enable = true;
  };

  # Auto mount flash drive
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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

  programs.obs-studio.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "codetector"
      "yaotianf"
    ];
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

  systemd.user.services.hyprland-hy3 = {
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      ${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/hyprctl plugin load ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
    '';
  };

  # Graphical Packages
  environment.systemPackages = with pkgs; [
    inputs.hy3.packages.x86_64-linux.hy3
    (pkgs.writeShellScriptBin "loadHy3"
      ''
      ${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/hyprctl plugin load ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
      '')
    # Hyprland
    waybar
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
    alacritty
    telegram-desktop
    signal-desktop
    (vscode.fhsWithPackages(ps: with ps; [
      rustup
      zlib
      systemd
      openssl.dev
      pkg-config
    ]))
  ];
}
