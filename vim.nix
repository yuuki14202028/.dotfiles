{ config, pkgs, inputs, ... }:

{

  programs.neovim = let in {

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

  programs.home-manager.enable = true;
}
