local fn = vim.fn

-- Install Packer if missing
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- update plugins on file save 
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Plugins
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" 
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "windwp/nvim-autopairs"
  use "kyazdani42/nvim-tree.lua"
  use "numToStr/Comment.nvim"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "folke/which-key.nvim"
  use "akinsho/toggleterm.nvim"

  -- Themes
  use "joshdick/onedark.vim"
  use "marko-cerovac/material.nvim"
  use ({"catppuccin/nvim", as = "catppuccin"})
  
  -- Cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path" 
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip" 
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets" 

  -- Lsp
  use "neovim/nvim-lspconfig" 
  use "williamboman/nvim-lsp-installer"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"
 
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  use "nvim-lualine/lualine.nvim"
  use "kyazdani42/nvim-web-devicons"

  use "lewis6991/gitsigns.nvim"

  -- Markdown reader
  use "ellisonleao/glow.nvim"

  -- Alpha
  use "goolord/alpha-nvim"

  -- Comment strings
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
