{
  config,
  lib,
  pkgs,
  inputs,
  pkgs-unstable,
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

  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services.gnome.gnome-keyring.enable = true;

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  security.rtkit.enable = true;

  xdg.menus.enable = true;
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "wlr";
      };
    };

    wlr.enable = true;
    wlr.settings.screencast = {
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Auto mount flash drive
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-mono
    dina-font
    nerd-fonts.fira-mono
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
        qt6Packages.fcitx5-chinese-addons
        fcitx5-nord
      ];
    };
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Graphical Packages
  environment.systemPackages = with pkgs; [
    yazi

    # Sway
    waybar
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wlsunset
    vanilla-dmz

    kdePackages.plasma-workspace
    rofi

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
    vscode
    meld
    ookla-speedtest
    xdot
  ];
}
