{
  description = "Iuyi's Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-auth = {
      url = "github:numtide/nix-auth";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      system = "aarch64-darwin";
      config = { lib, ... }: {
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 6;
        nixpkgs.hostPlatform = system;
        nixpkgs.overlays = [ inputs.nur.overlays.default ];
        nixpkgs.config.allowUnfreePredicate = pkg: lib.warn "unfree package '${lib.getName pkg}'" true;
      };
      darwinSystem = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          config
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "back";
              users.iuyi = import ./home.nix;
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              autoMigrate = true;
              user = "iuyi";
              # Optional: Enable fully-declarative tap management
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;
              # Optional: Declarative Homebrew tap trust entries.
              # Note: The trust entries are _not_ removed if you remove them from those lists!
              # Use the `brew untrust` command to remove a trust entry.
              trust = {
                formulae = [ ];
                casks = [ ];
                commands = [ ];
                taps = [ ];
              };
            };
          }
        ];
      };
      pkgs = darwinSystem.pkgs;
    in
    {
      darwinConfigurations."HUAWEI-MateBook-GT-14" = darwinSystem;
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixd
          nil
          nixfmt
        ];
      };
    };
}
