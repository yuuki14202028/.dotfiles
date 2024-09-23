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

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
         name = "onedark";
         src = inputs.plugin-onedark;
        };
        config = "colorscheme onedark";
      }
    ];
  };

  programs.home-manager.enable = true;
}
