{
  config,
  lib,
  pkgs,
  ...
} : {
  users.users.yaotianf = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fd
      ripgrep
      findutils
      git
      emacs
    ];
  };
}
