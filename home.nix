{ config, pkgs, ... }:

{
	home.username = "omar";
	home.homeDirectory = "/home/omar";

	home.stateVersion = "22.05";

	programs.home-manager.enable = true;
	
	programs.fish.enable = true;	
	programs.neovim.enable = true;

	home.packages = with pkgs; [ 
		btop
		vim
		wget
		google-chrome	
		kitty
		libreoffice
		zoom-us	
		openconnect
		slack
		git
		discord
		jetbrains.idea-ultimate	
		racket
		jetbrains.pycharm-professional
		gnome.gnome-tweaks
  		gnome-extension-manager
	];
}
