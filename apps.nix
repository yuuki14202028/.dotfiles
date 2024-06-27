
{pkgs, ...}: {
  programs.ncspot.enable = true;

  home.packages = with pkgs; [
    discord
    discord-ptb
    slack
    spotify
  ];
}
