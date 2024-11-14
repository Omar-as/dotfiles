{pkgs, ...}: {

  imports = [

    ./modules/home-manager/git.nix
    ./modules/home-manager/nvim
    ./modules/home-manager/shell.nix
    ./modules/home-manager/kitty.nix
    ./modules/home-manager/core.nix

    # ./modules/home-manager/emacs
  ];

  programs.zathura = {
    enable = true;
    options = {
      recolor = false;
    };
  };

  home.packages = with pkgs; [
    vim
    google-chrome
    libreoffice
    zoom-us
    git
    discord
    gnome-tweaks
    gnome-extension-manager
    vlc
    vscode
    brave
    gparted
    tmux
    qbittorrent
    syncplay
  ];
}
