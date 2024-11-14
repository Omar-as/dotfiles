{inputs, config, ... }: {

  # imports = [
  #   inputs.nix-colors.homeManagerModules.default
  # ]

  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;

  programs.kitty = {
    enable = true;

    settings = {

     # Disable terminal bell
      enable_audio_bell = "no";

      # Default layout is "splits"
      # Use "stack" to imitate the pane zooming feature of tmux
      enabled_layouts = "splits, stack";

      # Tab style
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index}: {title}";

      # Colors based on your scheme
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
      selection_background = "#${config.colorScheme.palette.base02}";
      selection_foreground = "#${config.colorScheme.palette.base05}";
      cursor = "#${config.colorScheme.palette.base05}";
      cursor_text_color = "#${config.colorScheme.palette.base00}";

      # Set colors for text and UI elements
      active_border_color = "#${config.colorScheme.palette.base04}";
      inactive_border_color = "#${config.colorScheme.palette.base01}";

      # Define normal colors
      color0 = "#${config.colorScheme.palette.base00}"; # Black
      color1 = "#${config.colorScheme.palette.base08}"; # Red
      color2 = "#${config.colorScheme.palette.base0B}"; # Green
      color3 = "#${config.colorScheme.palette.base0A}"; # Yellow
      color4 = "#${config.colorScheme.palette.base0D}"; # Blue
      color5 = "#${config.colorScheme.palette.base0E}"; # Magenta
      color6 = "#${config.colorScheme.palette.base0C}"; # Cyan
      color7 = "#${config.colorScheme.palette.base05}"; # White

      # Define bright colors
      color8 = "#${config.colorScheme.palette.base03}"; # Bright Black (Gray)
      color9 = "#${config.colorScheme.palette.base08}"; # Bright Red
      color10 = "#${config.colorScheme.palette.base0B}"; # Bright Green
      color11 = "#${config.colorScheme.palette.base0A}"; # Bright Yellow
      color12 = "#${config.colorScheme.palette.base0D}"; # Bright Blue
      color13 = "#${config.colorScheme.palette.base0E}"; # Bright Magenta
      color14 = "#${config.colorScheme.palette.base0C}"; # Bright Cyan
      color15 = "#${config.colorScheme.palette.base07}"; # Bright White
    };
  };

}
