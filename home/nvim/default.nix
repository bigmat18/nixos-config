{ config, pkgs, lib, inputs, ...}:
{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";

    nvimConfigPath = ./config;
    nvimPluginsPath = nvimConfigPath + /plugins;
  in  
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      cmake-language-server
      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-c
          p.tree-sitter-make
          p.tree-sitter-cmake
          p.tree-sitter-cuda
          p.tree-sitter-cpp
        ]));
        config = toLuaFile (nvimPluginsPath + /treesitter.lua);
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      {
        plugin = nvim-cmp;
        config = toLuaFile (nvimPluginsPath + /cmp.lua);
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile (nvimPluginsPath + /telescope.lua);
      }

      {
        plugin = nvim-tree-lua;
        config = toLuaFile (nvimPluginsPath + /nvim-tree.lua);
      }

      {
        plugin = lualine-nvim;
        config = toLuaFile (nvimPluginsPath + /lualine.lua);
      }

      {
        plugin = harpoon;
        config = toLuaFile (nvimPluginsPath + /harpoon.lua);
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile (nvimPluginsPath + /lsp.lua);
      }

      {
        plugin = nvim-autopairs;
        config = toLuaFile (nvimPluginsPath + /autopairs.lua);
      }

      {
        plugin = alpha-nvim;
        config = toLuaFile (nvimPluginsPath + /alpha.lua);
      }

      nvim-scrollbar
      vim-signify
      vim-tmux-navigator
      nvim-web-devicons
      popup-nvim
      telescope-fzf-native-nvim
      neodev-nvim
      nerdcommenter
      zen-mode-nvim
      vim-visual-multi
      # blink-ripgrep-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile (nvimConfigPath + /options.lua)}
      ${builtins.readFile (nvimConfigPath + /keymaps.lua)}
    '';

  };

}