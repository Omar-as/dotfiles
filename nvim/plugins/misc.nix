{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;
      vim-surround.enable = true;
      lualine = {
        enable = true;
        settings.options = {
          globalstatus = true;
          icons_enabled = true;
        };
      };
      comment.enable = true;
      gitsigns = {
        enable = true;
        settings.current_line_blame = true;
      };
      todo-comments = {
        enable = true;
        settings.signs = false;
      };
      vim-matchup = {
        enable = true;
        enableSurround = true;
      };

      which-key.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      # Navigation
      vim-kitty-navigator

      # Dynamically set buffer indentation
      vim-sleuth

      # Provide additional text objects
      # Cheatsheet for targets-vim in the link below:
      # https://github.com/wellle/targets.vim/blob/master/cheatsheet.md
      targets-vim

      # Helpers for UNIX
      vim-eunuch

      # Enable repeating supported plugin maps with "."
      vim-repeat

      # Make the yanked region apparent
      vim-highlightedyank
    ];
  };
}
