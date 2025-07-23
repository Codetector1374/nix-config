{
  config,
  lib,
  pkgs,
  ...
} : {
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Sway
  programs.sway = {
    extraOptions = [ "--unsupported-gpu" ];
    extraSessionCommands = ''
    export WLR_RENDERER=vulkan
    '';
  };

  # Firefox nvidia vaapi
  environment.variables = {
    MOZ_DISABLE_RDD_SANDBOX="1";
  };
  programs.firefox.preferences = {
    "media.ffmpeg.vaapi.enabled" = true;
    "media.rdd-ffmpeg.enabled" = true;
    "media.av1.enabled" = false; # Won't work on the 2060
    "gfx.x11-egl.force-enabled" = true;
    "widget.dmabuf.force-enabled" = true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # OpenRM
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  }; # end nvidia

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    egl-wayland
  ];

  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
  ];

}
