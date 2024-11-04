{ 
  params, 
  lib, 
  ... 
}: {

  imports = [

    # inputs.nixvim.homeManagerModules.nixvim

    ./autocmd.nix
    ./settings.nix
    ./theme.nix
    ./keybindings.nix

    ./plugins/completion.nix
    ./plugins/lsp.nix
    ./plugins/misc.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/winshift.nix
  ];

  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
    };
    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };
  };

  home.sessionVariables = lib.mkIf (builtins.elem params.editor ["nvim" "neovim"]) {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

}
