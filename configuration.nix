# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.bluetooth.hsphfpd.enable = true;


  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.windowManager.awesome.enable = true;

  #For internet icon
  programs.nm-applet.enable = true;

  #For Lock Screen in suspend and hibernate
  services.physlock = {
		enable = true;
		allowAnyUser = true;
	};

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  #services.pipewire = {
  #		enable = true;
  #		alsa.enable = true;
  #		alsa.support32Bit = true;
  #		pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
  #};
  services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# Enable JACK applicaitons
		# jack.enable = true;

		# Bluetooth Configuration
		media-session.config.bluez-monitor.rules = [{
			# Match all cards
			matches = [ { "device.name" = "~bluez_card.*"; } ];
			actions = {
				"update-props" = {
					"bluez5.auto-connect" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
					"bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
					# mSBC is not expected to work on all headset + adapter combinations.
					"bluez5.msbc-support" = true;
					# SBC-XQ is not expected to work on all headset + adapter combinations.
					"bluez5.sbc-xq-support" = true;
				};
			};
		} {
			matches = [
				# Match all sources
				{ "node.name" = "~bluez_input.*"; }
				# Match all outputs
				{ "node.name" = "~bluez_output.*"; }
			];
			actions = {
				"node.pause-on-idle" = false;
			};
		}];
	};

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.omar = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "libvirtd"]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     firefox
     google-chrome
     git
     kitty
     alacritty
     nodejs
	 python3
	 stow
	 unityhub
	 gnome.nautilus
	 zoom-us
	 discord
	 jetbrains.idea-ultimate
	 jetbrains.rider
	 pamixer
	 dotnet-sdk
	 msbuild
	 fd
	 openjdk
	 libreoffice
	 rofi
	 virt-manager
     ((vim_configurable.override { python = python3; }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix coc-nvim coc-pyright gruvbox vim-commentary];
        opt = [];
      };
      vimrcConfig.customRC = ''
		set number
		set tabstop=4
		set nowrap
		set nocompatible
		set backspace=indent,eol,start
		colorscheme gruvbox
		set background=dark
	
		syntax on
		
		filetype indent on 
		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
		" other plugin before putting this into your config.
		inoremap <silent><expr> <TAB>
      		\ pumvisible() ? "\<C-n>" :
   			\ <SID>check_back_space() ? "\<TAB>" :
      		\ coc#refresh()
		inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

		function! s:check_back_space() abort
  			let col = col('.') - 1
  			return !col || getline('.')[col - 1]  =~# '\s'
		endfunction

		" Use <c-space> to trigger completion.
		if has('nvim')
  			inoremap <silent><expr> <c-space> coc#refresh()
		else
  			inoremap <silent><expr> <c-@> coc#refresh()
		endif
      '';
    })
   ];

  #vert manager
  virtualisation.libvirtd.enable = true;
	programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

