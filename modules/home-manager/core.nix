{config, pkgs, params, ...}: {

  # Enable home-manager
  programs.home-manager.enable = true;

  home = {
    inherit (params) username;
    homeDirectory = "/home/${params.username}";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = params.state-version;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # programs.fish.shellAbbrs = let
  #   flake-dir = config.home.sessionVariables.FLAKEDIR;
  #   nixos-flake = "${flake-dir}#${params.hostname}";
  #   home-flake = "${flake-dir}#${params.username}@${params.hostname}";
  #   nix-summary = "${pkgs.nixos-change-summary}/bin/nixos-change-summary";
  #   hm-summary = "${pkgs.home-manager-change-summary}/bin/home-manager-change-summary";
  # in {
  #   nx-boot = "sudo nixos-rebuild boot --flake ${nixos-flake} && ${nix-summary}";
  #   nx-build = "nixos-rebuild build --flake ${nixos-flake}";
  #   nx-switch = "sudo nixos-rebuild switch --flake ${nixos-flake} && ${nix-summary}";
  #   nx-summary = nix-summary;
  #   hm-build = "home-manager build --flake ${home-flake}";
  #   hm-switch = "home-manager switch --flake ${home-flake} && ${hm-summary}";
  #   hm-summary = hm-summary;
  # };

  programs.direnv = {
    enable = true;

    enableBashIntegration = true;
    # Enabled by default
    # enableFishIntegration = true;
    enableZshIntegration = true;

    nix-direnv = {
      enable = true;
    };
  };

}
