{...}: {
  programs.nixvim.plugins.cmp.settings = {
    enable = true;
    completion = {
      autocomplete = ["TextChanged"];
      keywordLength = 1;
    };
    sources = [
      {name = "nvim_lsp";}
      {name = "nvim_lua";}
      {name = "path";}
      {name = "buffer";}
    ];
    mapping = {
      "<tab>"   = "cmp.mapping.select_next_item()";
      "<s-tab>" = "cmp.mapping.select_prev_item()";
      "<c-n>"   = "cmp.mapping.select_next_item()";
      "<c-p>"   = "cmp.mapping.select_prev_item()";
    };
  };
}
