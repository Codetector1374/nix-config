{
  description = "A simple NixOS flake";

  inputs = {
# NixOS official package source, using the branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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
    };
  };
}
