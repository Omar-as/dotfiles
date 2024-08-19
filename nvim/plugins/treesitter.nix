{...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      folding = true;
      settings.indent.enable = true;
    };
    rainbow-delimiters.enable = true;
    ts-context-commentstring.enable = true;
    indent-blankline = {
      enable = true;
      settings.scope.enabled = true;
      settings.exclude.buftypes = ["terminal" "nofile" "quickfix" "prompt" "help"];
    };
    nvim-autopairs = {
      enable = true;
      settings.check_ts = true;
      settings.disable_in_macro = true;
      settings.disable_in_visualblock = true;
    };
    ts-autotag.enable = true;
  };
}
