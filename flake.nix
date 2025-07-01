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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
    # My bits and bops
    yand = {
      url = "github:Kirottu/yand";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kidex.url = "github:Kirottu/kidex";
    tv.url = "github:Kirottu/tv";

    hm-modules = {
      url = "path:/home/kirottu/Projects/hm-modules";
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
            inputs.lix-module.nixosModules.default
            ./hosts/church-of-harold
          ];
        };
      };
    };
}
