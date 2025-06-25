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
  };

  outputs =
    inputs:
    let
      inherit (inputs)
        home-manager
        lix-module
        nixpkgs
        ;
      inherit (nixpkgs) lib;

      secrets = builtins.fromTOML (builtins.readFile ./secrets.toml);

      mkSystem =
        hostname: system:
        let
          mylib = import ./mylib { inherit inputs hostname lib; };
        in
        lib.nixosSystem {
          inherit system;
          modules = [
            ./system
            ./hosts/${hostname}/system
            lix-module.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs mylib secrets; };
              home-manager.users.kirottu = {
                imports = [
                  ./home
                  ./hosts/${hostname}/home
                ];
              };
            }
          ];

          specialArgs = { inherit inputs mylib secrets; };
        };
    in
    {
      nixosConfigurations = {
        missionary-of-harold = mkSystem "missionary-of-harold" "x86_64-linux";
        church-of-harold = mkSystem "church-of-harold" "x86_64-linux";
      };
    };
}
