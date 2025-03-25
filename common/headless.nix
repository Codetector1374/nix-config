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
    inputs.cursor-server.nixosModules.default
  ];

# Need to have ssh for headless to work
  services.openssh.enable = true;

# Required to be FHS, since cursor does not ship a non FHS binary
  services.cursor-server.enable = true;

# systemd service to patch vscode server
  services.vscode-server = {
    enable = true;
    enableFHS = false;
  };

  environment.systemPackages = with pkgs; [
    tmux
      yazi
  ];
}
