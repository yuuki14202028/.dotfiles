# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, username, locale, timezone, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./locale.nix
    ];

  nixpkgs.config.allowUnfree = true;

  hardware = {

    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    logitech = {
      wireless.enable = true;
    };

  };

  zramSwap = {
    enable = true;
    memoryPercent = 200;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;
  networking.firewall = {
   enable = true;
   # tailscaleの仮想NICを信頼する
   # `<Tailscaleのホスト名>:<ポート番号>`のアクセスが可能になる
   trustedInterfaces = ["tailscale0"];
   allowedUDPPorts = [config.services.tailscale.port];
  };


  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    videoDrivers = ["nvidia"];
  };
  console.earlySetup = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };



  environment.systemPackages = with pkgs; [

    pinentry-qt

    gnumake
    gcc

    nodejs

    fd
    gat
    genact

    solaar

    dex2jar
    apktool

    wineWowPackages.stable

    hypnotix

    jdk
    prismlauncher

    glib

    openssl

    gh

    claude-code

    p7zip

    fuse

    uv

  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {

    nix-ld = {
      enable = true;
      dev.enable = false;
      libraries = with pkgs; [
        libGL
	flite
	libpulseaudio
	alsa-lib
        fuse
	fuse3
      ];
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    zsh = {
      enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.hack
      migu
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
	sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
	monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
	emoji = ["Noto Color Emoji"];
      };
      localConf = ''
       <?xml version="1.0"?>
       <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
       <fontconfig>
         <description>Change default fonts for Steam client</description>
         <match>
           <test name="prgname">
             <string>steamwebhelper</string>
           </test>
           <test name="family" qual="any">
             <string>sans-serif</string>
           </test>
           <edit mode="prepend" name="family">
             <string>Migu 1P</string>
           </edit>
         </match>
       </fontconfig>
     '';
    };
  };

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
  system.stateVersion = "24.06"; # Did you read the comment?
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
