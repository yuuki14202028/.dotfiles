{ config, pkgs, inputs, username, ...} :{

  imports = [
    ./apps.nix
    ./browser.nix
    ./jetbrains.nix
    ./vim.nix
    ./git.nix
    ./zsh.nix
    ./starship.nix
  ];

  home = rec {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  home.packages = with pkgs; [
    bat
    bottom
    eza
    httpie
    ripgrep
  ];

  programs.home-manager.enable = true;
}
