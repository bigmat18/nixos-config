{ config, pkgs, lib, ...}:
let
  nvimConfigPath = ./config;
  nvimPluginsPath = nvimConfigPath + /plugins;
  luaFile = file: builtins.readFile (nvimPluginsPath + "/${file}");
in  
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      glsl_analyzer
      lua-language-server
      cmake-language-server
      xclip
      wl-clipboard
      ripgrep
      nodejs_22
      typescript
      typescript-language-server
      nil
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons

      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = luaFile "/nvim-tree.lua";
      }


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
        config = luaFile "/treesitter.lua";
        type = "lua";
      }

      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = luaFile "/gruvbox.lua";
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = luaFile "/cmp.lua";
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = luaFile "/telescope.lua";
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = luaFile "/lualine.lua";
      }

      {
        plugin = harpoon;
        type = "lua";
        config = luaFile "/harpoon.lua";
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = luaFile "/lsp.lua";
      }

      {
        plugin = nvim-autopairs;
        type = "lua";
        config = luaFile "/autopairs.lua";
      }

      {
        plugin = alpha-nvim;
        type = "lua";
        config = luaFile "/alpha.lua";
      }

      nvim-scrollbar
      vim-signify
      vim-tmux-navigator
      popup-nvim
      telescope-fzf-native-nvim
      neodev-nvim
      nerdcommenter
      zen-mode-nvim
      vim-visual-multi
      nvim-treesitter-textobjects
      indent-blankline-nvim
      oil-nvim
      luasnip
      cmp-nvim-lsp
    ];

    extraLuaConfig = ''
      ${builtins.readFile (nvimConfigPath + /options.lua)}
      ${builtins.readFile (nvimConfigPath + /keymaps.lua)}
    '';

  };

}