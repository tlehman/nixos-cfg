# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.download-buffer-size = 524288000;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eligius"; # St. Eligius is the patron saint of metalworkers, I chose him because this is my baremetal m
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true; # use xkb.options in tty.
  services.xserver.xkb.options = "ctrl:nocaps";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Use the proprietary NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;        # Optional: set true if you want power management
      powerManagement.finegrained = false;   # Optional: set true for fine-grained power management (Turing or newer)
      open = false;                          # Use proprietary (recommended for RTX 2070)
      nvidiaSettings = true;                 # Installs nvidia-settings and nvidia-smi
      package = config.boot.kernelPackages.nvidiaPackages.stable; # Use stable driver for RTX 2070
    };
  };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.tobi = {
    isNormalUser = true;
    description = "Tobi";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    home = "/home/tobi";
    packages = with pkgs; [
      bash-language-server
      bat
      direnv
      fd
      fzf
      gcc
      ghc
      git
      go
      gopls
      haskell-language-server
      htop
      macchina
      ncdu
      neovim
      pciutils
      ripgrep
      shellcheck
      starship
      tailscale
      tmux
      tree
      watch
      yazi
      zoxide
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     wget
     tmux
     zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
  #programs.git {
  #  enable = true;
  #  userName = "Tobi Lehman";
  #  userEmail = "mail@tobilehman.com";
  #  aliases = {
  #    co = "checkout";
  #    s = "status";
  #    a = "add";
  #  };
  #};

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the Tailscale daemon
  services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

