{pkgs, ... }: 
  let
    # Define shell aliases for convenience
    shellAliases = {
      zathura = "zathura --mode fullscreen";
      rebuild-switch = "sudo nixos-rebuild switch --flake ~/dotfiles/";
      flake-update = "nix flake update";
      basic-flake = "nix flake new -t github:nix-community/nix-direnv .";
    };
  in {

  programs.fish = {
    enable = true;
    inherit shellAliases;

    shellInit = ''
      # Define TokyoNight Color Palette
      set -l foreground 3760bf
      set -l selection 99a7df
      set -l comment 848cb5
      set -l red f52a65
      set -l orange b15c00
      set -l yellow 8c6c3e
      set -l green 587539
      set -l purple 7847bd
      set -l cyan 007197
      set -l pink 9854f1

      # Set syntax highlighting colors
      set -g fish_color_normal $foreground
      set -g fish_color_command $cyan
      set -g fish_color_keyword $pink
      set -g fish_color_quote $yellow
      set -g fish_color_redirection $foreground
      set -g fish_color_end $orange
      set -g fish_color_error $red
      set -g fish_color_param $purple
      set -g fish_color_comment $comment
      set -g fish_color_selection --background=$selection
      set -g fish_color_search_match --background=$selection
      set -g fish_color_operator $green
      set -g fish_color_escape $pink
      set -g fish_color_autosuggestion $comment

      # Configure completion pager colors
      set -g fish_pager_color_progress $comment
      set -g fish_pager_color_prefix $cyan
      set -g fish_pager_color_completion $foreground
      set -g fish_pager_color_description $comment
      set -g fish_pager_color_selected_background --background=$selection

      # Enable default (emacs) mode (Not Vi Controls)
      fish_default_key_bindings
    '';
  };

  programs.bash = {
    enable = true;
    inherit shellAliases;
    };

  home.packages = with pkgs; [

    btop
    wget
    sshfs

    zip # Zip Compression
    unzip # Zip Decompression
    tree # List directory contents in a tree-like format
    fd # Find Clone
  ];
}
