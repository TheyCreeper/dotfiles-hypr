{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

# Define user
  # main-user.enable = true;
  # main-user.userName = "TheyCreeper";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;   

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = true;


  # Remove gnome programs
  environment.gnome.excludePackages = with pkgs; [
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-maps
    gnome-music
    gnome-weather
    gnome-tour
    gnome-photos
    cheese
    epiphany
    geary
    yelp
  ];   

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.theycreeper = {
    isNormalUser = true;
    description = "theycreeper";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	  pkgs.brave
	  pkgs.vesktop
	  pkgs.vscode
	  pkgs.chezmoi
	  pkgs.git
    pkgs.micro
    pkgs.ghostty
    pkgs.neovim
    pkgs.google-chrome
    pkgs.telegram-desktop
    pkgs.home-manager
  ];     

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  home-manager = {
  	extraSpecialArgs = { inherit inputs; };
  	users= {
  		"theycreeper" = import ./home.nix;
  	};
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";   
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "25.11"; # Did you read the comment?

  fileSystems."/mnt/alpha" = {
    device = "/dev/disk/by-uuid/803E85593E8548DC";
    fsType = "ntfs";
    options = [ "defaults" "nofail" ];
  };   
}
