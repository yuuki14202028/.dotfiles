{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs@{nixpkgs, home-manager, flake-utils, spicetify-nix, ...}: {
    nixosConfigurations = {
      myNixOS = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.yuuki = import ./home.nix;
	    home-manager.backupFileExtension = "backup";
	  }
        ];
	specialArgs = {
	  inherit inputs;
	};
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [
          nodePackages.prisma
	  nodePackages.npm
	  nodejs-slim
        ];
        shellHook = with pkgs; ''
          export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine"
          export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
          export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
          export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
        '';
	packages = [
	  (pkgs.writeScriptBin "nrs" "sudo nixos-rebuild switch --flake .#myNixOS")	
	];
      };
    });
}
