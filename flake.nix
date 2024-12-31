{
  description = "A simple NixOS flake";

  inputs = {
# NixOS official package source, using the branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    vscode-server.url = "github:nix-community/nixos-vscode-server?ref=8b6db451de46ecf9b4ab3d01ef76e59957ff549f";
    hyprland.url = "github:hyprwm/Hyprland?submodules=1&ref=v0.46.2"; # TODO: prob never get packaged
    aagl.url = "github:ezKEa/aagl-gtk-on-nix?ref=release-24.11";
    hy3 = {
        url = "github:outfoxxed/hy3?ref=hl0.46.0"; # TODO: prob never get packaged
        inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self, 
    nixpkgs, 
    ... 
  } @ inputs: let
  inherit (self) outputs;

  systems = [
    "x86_64-linux"
  ];

  forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    nixosConfigurations = {
      nix-dev = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/nix-dev/nix-dev.nix
        ];
      };
      "yaotianf-nix" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/nvidia/yaotianf-nix/configuration.nix
        ];
      };
      "shintel" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/shintel/configuration.nix
        ];
      };
    };
  };
}
