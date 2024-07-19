local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --"wbthomason/packer.nvim",
    -- Common utilities
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    -- Colorschema
    "ameiurl/seoul256.vim",

    -- Treesitter
    {
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/playground" },
	},

	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    },
    "nvim-telescope/telescope-ui-select.nvim",

    -- LSP
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "Issafalcon/lsp-overloads.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- cmp: Autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"ameiurl/friendly-snippets",

	-- File manager
    {	
        "kyazdani42/nvim-tree.lua",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
    },

	-- Statusline
    {
		"glepnir/galaxyline.nvim",
		event = "BufEnter",
		requires = { "nvim-web-devicons" },
    },

    -- A pretty list for showing diagnostics
	"folke/trouble.nvim",

    -- Cursor-word highlighter + text objects
	"RRethy/vim-illuminate",

	-- Git
	"lewis6991/gitsigns.nvim",
	'kdheepak/lazygit.nvim',
    'tpope/vim-fugitive', 						  -- it's the premier Git plugin for Vim

	-- Markdown Preview
    {
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
    },

	-- autopairs
	"windwp/nvim-autopairs",

    -- comment
	"numToStr/Comment.nvim",

    -- a smooth scrolling neovim plugin written in lua
    {
		"karb94/neoscroll.nvim",
		config = function()
            require('neoscroll').setup {}
        end, 
    },

    -- bufferline
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",

    -- A tree like view for symbols
	"simrat39/symbols-outline.nvim",

    -- match-up is a plugin that lets you highlight
    {
		"andymass/vim-matchup",
        commit = nil,
        event = 'VimEnter',
        config = function()
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_offscreen = {}
        end,
    },

    'terryma/vim-expand-region',  				  -- Select increasingly larger regions of text using the same key combination
    'junegunn/vim-easy-align', 					  -- A simple, easy-to-use Vim alignment plugin	
    {
        'mg979/vim-visual-multi', 					  -- It's called vim-visual-multi in analogy with visual-block
        commit = nil,
        config = function()
            vim.g.VM_maps = {
                ["Find Under"]         = '<C-m>',
                ["Find Subword Under"] = '<C-m>',
                ["Find Next"]          = '',
                ['Find Prev']          = '',
                ['Remove Region']      = 'q',
                ['Skip Region']        = '<C-n>',
                ["Undo"]               = 'l',
                ["Redo"]               = '<C-r>',
                ["Add Cursor Down"]    = '<A-Down>',
                ["Add Cursor Up"]      = '<A-Up>',
            }
        end,
    },
    'hrsh7th/vim-eft',
    'kshenoy/vim-signature',   					      -- a plugin to place, toggle and display marks
    {
        'lambdalisue/suda.vim',
        config = function()
            vim.g.suda_smart_edit=1
        end,
    },
})
