{...}: {

 nix = {

    settings = {

      # Enable experimental features (flakes, new `nix` commands)
      experimental-features = "nix-command flakes";

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

    };

    # Auto garbage-collection to save disk space
    gc = {

      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 90d";

    };

  };

} 
