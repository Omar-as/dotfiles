{...}: {

  # Enable Fish and define its alisases
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild-switch = "sudo nixos-rebuild switch --flake ~/dotfiles/";
      flake-update   = "nix flake update";
      basic-flake    = "nix flake new -t github:nix-community/nix-direnv .";
    };

  };
}
