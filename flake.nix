{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
    persist-retro.url = "github:Geometer1729/persist-retro";

    # My bits and bops
    yand = {
      url = "github:Kirottu/yand";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kidex = {
      url = "github:Kirottu/kidex";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm-modules = {
      url = "github:Kirottu/hm-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      secrets = builtins.fromTOML (builtins.readFile ./secrets.toml);
      # Overlay with some utilities
      lib = import ./lib { inherit inputs lib; };
    in
    {
      nixosConfigurations = {
        church-of-harold = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs lib secrets;
          };
          modules = [
            ./hosts/church-of-harold
          ];
        };
        missionary-of-harold = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs lib secrets;
          };
          modules = [
            ./hosts/missionary-of-harold
          ];
        };
      };
    };
}
