# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    dropbox-cli
    dmenu
    git
    gnupg
    haskellPackages.xmonad
    pass
    pinentry
    rcm
    ruby_2_2_2
    rxvt_unicode
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostname = "nixos";
    wireless.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.virtualbox.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    autorun = true;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager = {
      sessionCommands = "xrdb -merge /home/capicue/.XResources";
      slim = {
        enable = true;
        defaultUser = "capicue";
      };
    };
    enable = true;
    layout = "us";
    windowManager = {
      default = "xmonad";
      xmonad = {
        enable = true;
      };
    };
    xkbOptions = "eurosign:e";
    xkbVariant = "dvorak";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.capicue = {
    description = "Stacey Touset";
    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
    name = "capicue";
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
  };
}
