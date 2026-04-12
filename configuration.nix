# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Plymouth boot splash
  boot.plymouth = {
    enable = true;
    theme = "tech_b";
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "tech_b" ];
      })
    ];
  };
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_level=3" "vt.global_cursor_default=0" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kud = {
    isNormalUser = true;
    description = "kud";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };
  
  programs.zsh.enable = true;
  users.users.kud.shell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Force Electron apps to use native Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    brightnessctl
    firefox
    vim
    wl-clipboard
    wtype
    grim
    slurp
    virt-viewer
    kitty
    waybar
    wofi
    hyprpaper
    git
    wget
    nodejs
    procps
  ]) ++ [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        backgroundFill = "#000000";
        basicTextColor = "#000000";
        passwordInputBackground = "#000000";
        passwordInputCursorVisible = true;
        passwordCursorColor = "#44def5";
        passwordTextColor = "#ffffff";
        passwordInputRadius = 0;
        passwordInputWidth = 0.3;
        passwordFontSize = 48;
        passwordCharacter = "*";
        passwordMask = true;
        font = "Ubuntu Sans Mono";
        showSessionsByDefault = false;
        showUsersByDefault = false;
        usersFontSize = 1;
        sessionsFontSize = 1;
        hideCursor = false;
        cursorBlinkAnimation = true;
        helpFont = "Ubuntu Sans Mono";
        helpFontSize = 1;
      };
    })
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "where_is_my_sddm_theme";
    extraPackages = [
      pkgs.kdePackages.qt5compat
      pkgs.kdePackages.qtsvg
    ];
  };


  services.upower.enable = true;
  services.tailscale.enable = true;

  # Polkit agent for GUI authentication prompts
  systemd.user.services.polkit-kde-agent = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  
}
