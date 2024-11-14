{...}: {

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./virt-manager/virt-manager.nix
    ./docker/docker.nix

    ./modules/nixos/nix-index.nix
    ./modules/nixos/core.nix
    ./modules/nixos/power.nix
    ./modules/nixos/nix.nix
    ./modules/nixos/networking.nix
    ./modules/nixos/gnome.nix
    ./modules/nixos/bluetooth.nix
    ./modules/nixos/pipewire.nix
    ./modules/nixos/keyboard.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
