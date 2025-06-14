{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld.url = "github:Mic92/nix-ld";
    flake-utils.url = "github:numtide/flake-utils";
    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
  };

  outputs = inputs@{nixpkgs, home-manager, flake-utils, nix-ld, ...}: 
  let
    # 共通変数の定義
    username = "yuuki";
    hostname = "myNixOS";
    locale = "ja_JP.UTF-8";
    timezone = "Asia/Tokyo";
  in {
    nixosConfigurations = {
      ${hostname} = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.${username} = import ./home.nix;
            home-manager.backupFileExtension = "bu";
            home-manager.extraSpecialArgs = {
              inherit inputs username locale timezone;
            };
	  }
	  nix-ld.nixosModules.nix-ld
        ];
	specialArgs = {
	  inherit inputs username locale timezone;
	};
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { 
      inherit system;
    };
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [
          nodePackages.prisma
	  nodePackages.npm
          nodejs-slim
          fortune
        ];
        shellHook = with pkgs; ''
          export DIRENV_LOG_FORMAT=""
          export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine"
          export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
          export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
          export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
          fortune
        '';
	packages = [
	  (pkgs.writeScriptBin "nrs" "sudo nixos-rebuild switch --flake .#${hostname}")	  
	];
      };
    });
}
