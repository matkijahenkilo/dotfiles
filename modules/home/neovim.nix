{ pkgs, lib, ... }: {
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      clang
      fd
      ripgrep

      # Clipboard
      wl-clipboard
      xclip

      # Commonly used LSPs
      clang-tools
      jdt-language-server
      lua-language-server
      nixd
      pyright
      texlab
    ];

    extraLuaPackages = lps: with lps; [
      luautf8
      jsregexp
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      cmp-buffer
      cmp-cmdline
      cmp-conjure
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      cmp-rg
      cmp-treesitter
      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./neovim/plugins/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./neovim/plugins/telescope.lua;
      }
      telescope-fzy-native-nvim

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./neovim/plugins/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      luasnip
      friendly-snippets

      lualine-nvim
      lualine-lsp-progress
      nvim-web-devicons

      plenary-nvim
      markdown-preview-nvim
      Coqtail
      conjure
      emmet-vim
      symbols-outline-nvim
      nvim-web-devicons
      vimspector
      undotree
      nerdcommenter
      tagbar
      vim-fugitive
      auto-pairs

      {
        plugin = nerdtree;
        config = ''
          nnoremap <leader>e :NERDTreeFocus<CR>
          nnoremap <Space>e :NERDTree<CR>
          nnoremap <Space>t :NERDTreeToggle<CR>
          nnoremap <Space>f :NERDTreeFind<CR>
        '';
      }
      vim-devicons
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./neovim/options.lua}
    '';
  };

  home.sessionVariables = {
    EDITOR = lib.mkDefault "nvim";
  };
}
