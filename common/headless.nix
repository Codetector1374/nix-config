{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # VSCode Server patcher
    inputs.vscode-server.nixosModules.default
  ];

  # Need to have ssh for headless to work
  services.openssh.enable = true;

  # systemd service to patch vscode server
  services.vscode-server = {
    enable = true;
    enableFHS = true;
  };

  environment.systemPackages = with pkgs; [
    tmux
  ];
}