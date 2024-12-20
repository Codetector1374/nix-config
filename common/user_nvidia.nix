{
  config,
  lib,
  pkgs,
  ...
} : {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      theme = "af-magic";
      customPkgs = [
        pkgs.nix-zsh-completions
      ];
      plugins = [
        "git"
        "sudo"
      ];
    };
  };
  users.users.yaotianf = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      p4
      zsh
      tmux
      fd
      ripgrep
      findutils
      git
      emacs
    ];
  };
}
