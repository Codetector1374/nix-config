{
  description = "A simple NixOS flake";

  inputs = {
# NixOS official package source, using the branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server?ref=8b6db451de46ecf9b4ab3d01ef76e59957ff549f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cursor-server = {
      url = "github:divyenduz/nixos-cursor-server?ref=5bfab4d795f7b7fd20d8855c507dfca2fb7e5d7d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#   hyprland = {
#     url = "github:hyprwm/Hyprland?submodules=1&ref=v0.49.0";
#     inputs.hyprutils.url = "github:hyprwm/hyprutils?ref=v0.7.1";
#   };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#   hy3 = {
#       url = "github:outfoxxed/hy3?ref=hl0.49.0"; # TODO: prob never get packaged
#       inputs.hyprland.follows = "hyprland";
#   };
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
      "chiori" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
         ./hosts/chiori/configuration.nix
        ];
      };
      "dockerhost-1" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/lab/dockerhost-1/configuration.nix
        ];
      };
    };
  };
}
