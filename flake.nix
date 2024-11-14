{
  description = "ASUS ROG Strix G513QY_G513QY Configuration";

  # Systmem Details
  #   Memory = 32Gib
  #   Processor = AMD Ryzen™ 9 5980HX with Radeon™ Graphics × 16
  #   Graphics = AMD Radeon™ Graphics
  #   OS Type 64-Bit

  inputs = {

    # Nixpkgs
    nixpkgs.url         = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Configure Neovim with Nix
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Base-16 Theming
    nix-colors.url = "github:misterio77/nix-colors";

    # Nix Index Database
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # # Doom-Emacs Packaged For Nix
    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    # nix-doom-emacs.inputs.nix-straight.follows = "nix-straight";
    # nix-straight = {
    #   url = "github:codingkoi/nix-straight.el?ref=codingkoi/apply-librephoenixs-fix";
    #   flake = false;
    # };

  };
  outputs = { self, nixpkgs, home-manager, nix-colors, nixvim, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      params = {
        hostname = "nixos";
        username = "omar";
        name = "Omar Al Asaad";
        email = "omarelassaad93@gmail.com";
        state-version = "22.05";
        editor = "nvim";
        browser = "brave";
        timezone = "Asia/Riyadh";
        shell = "fish";
        terminal = "kitty";
        theme = "ayu-dark";
      };
    in {
      # NixOS configuration entrypoint with Home Manager included
      nixosConfigurations.${params.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs params inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Home Manager user configuration
            home-manager.users.${params.username} = {
              imports = [
                ./home.nix
                inputs.nix-colors.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
                # # Enable Doom-Emacs if required
                # inputs.nix-doom-emacs.hmModule
              ];
              _module.args = { inherit params pkgs inputs; };
            };
          }
        ];
      };

      # Additional formatter tool
      formatter.${system} = pkgs.alejandra;
    };
}
