{
  config,
  pkgs,
  ...
}: {

  imports = [
    ./git/git.nix
    ./nvim/nvim.nix
    ./fish/fish.nix
  ];

  home.username = "omar";
  home.homeDirectory = "/home/omar";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

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

  programs.zathura = {
    enable = true;
    options = {
      recolor = false;
    };
  };

  home.packages = with pkgs; [
    btop
    vim
    wget
    google-chrome
    kitty
    libreoffice
    zoom-us
    slack
    git
    discord
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    gnome.gnome-tweaks
    gnome-extension-manager
    alacritty
    openconnect
    vlc
    sshfs
    firefox
    unzip
    obs-studio
    vscode
    brave
    spotify
    fd
    gparted
    ripgrep
    tmux
    qbittorrent
    syncplay
    telegram-desktop
  ];
}
