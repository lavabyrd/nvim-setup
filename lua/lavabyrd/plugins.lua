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
  
  -- Themes
  use "joshdick/onedark.vim"
  use "marko-cerovac/material.nvim"
  
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

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
