
{pkgs, ...}: let
  plugins = [
    "ideavim"
    "nixidea"
    "github-copilot"
  ];
  patched-idea = with pkgs; (jetbrains.plugins.addPlugins jetbrains.idea-ultimate plugins);
in {
  home.packages = with pkgs; [
    android-studio
  ] ++ [patched-idea];
}
