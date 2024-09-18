
{pkgs, ...}: {
  programs.ncspot.enable = true;

  home.packages = with pkgs; [
    discord
    slack
  ];
}
