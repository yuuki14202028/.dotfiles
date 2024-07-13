{
  imports = [
    ./apps.nix
    ./browser.nix
    ./jetbrains.nix
  ];
  home = rec {
    username="yuuki";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };
  programs.home-manager.enable = true;
}
