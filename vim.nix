{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [

    ];

    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
