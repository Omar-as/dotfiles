{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url         = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url    = "github:nix-community/home-manager";
    nixvim.url          = "github:nix-community/nixvim";

    # Doom-Emacs Packaged For Nix
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.inputs.nix-straight.follows = "nix-straight";
    nix-straight = {
      url = "github:codingkoi/nix-straight.el?ref=codingkoi/apply-librephoenixs-fix";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,

    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;

    params = {
      name = "Omar Al Asaad";
      email = "omarelassaad93@gmail.com";
      username = "omar";
      editor = "nvim";
    };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit params;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.omar = {
              imports = [

              ./home.nix 
              inputs.nixvim.homeManagerModules.nixvim 
              inputs.nix-doom-emacs.hmModule

              ];
              _module.args = {inherit params; inputs = self.inputs;};
            };
          }
        ];
      };
    };
    formatter.${system} = pkgs.alejandra;
  };
}
