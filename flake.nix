{
  description = "A simple NixOS flake";

  inputs = {
# NixOS official package source, using the branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    hyprland.url = "github:hyprwm/Hyprland?submodules=1&ref=v0.46.0"; # TODO: prob never get packaged
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
