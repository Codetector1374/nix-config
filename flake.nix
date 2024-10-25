{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nix-dev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nix-dev/nix-dev.nix
      ];
    };
  };
}
