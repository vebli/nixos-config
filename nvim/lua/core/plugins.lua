local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'startup-nvim/startup.nvim'
    use 'lervag/vimtex'
    use 'kylechui/nvim-surround'
    use 'lambdalisue/suda.vim'
    -- IDE
    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'jakemason/ouroboros' -- Switching between c++ header and source files
    use 'numToStr/Comment.nvim'
    use 'j-morano/buffer_manager.nvim'
    use 'brenoprata10/nvim-highlight-colors'
    -- Debug
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    -- Building
    use 'Civitasv/cmake-tools.nvim'

    -- LSP
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    })
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason-lspconfig.nvim'
    use 'williamboman/mason.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'folke/trouble.nvim'
    -- snipped engine for code completion 
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Colorschemes 
    use 'nyoom-engineering/oxocarbon.nvim'
    use 'Mofiqul/dracula.nvim'
    use 'tanvirtin/monokai.nvim'
      -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)
