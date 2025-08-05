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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    impermanence.url = "github:nix-community/impermanence";
    persist-retro.url = "github:Kirottu/persist-retro";

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

    ctrld = {
      url = "github:Kirottu/ctrld-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system76-scheduler-niri = {
      url = "github:Kirottu/system76-scheduler-niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      # Overlay with some utilities
      lib = import ./lib { inherit inputs lib; };
    in
    {
      nixosConfigurations = {
        church-of-harold = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs lib;
          };
          modules = [
            ./hosts/church-of-harold
          ];
        };
        missionary-of-harold = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs lib;
          };
          modules = [
            ./hosts/missionary-of-harold
          ];
        };
      };
    };
}
