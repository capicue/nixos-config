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
    ack
    chromium
    coq
    (
      emacsWithPackages (
        with emacsPackages;
        [
          proofgeneral
        ]
      )
    )
    git
    (
      haskellPackages.ghcWithHoogle (pkgs:
        [
          pkgs.cabal-install
          pkgs.ghc-mod
          pkgs.hscolour
          pkgs.pretty-show
        ]
      )
    )
    parcellite
    rcm
    tmux
    vim
    wget
    xclip
    zsh
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostName = "nixos";
    wireless.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.locate = {
    enable = true;
    interval = "1m";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    desktopManager.kde4.enable = true;
    displayManager = {
      kdm.enable = true;
      sessionCommands = "xrdb -merge /home/capicue/.XResources";
    };
    enable = true;
    layout = "us";
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
