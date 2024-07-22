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
        dependencies = { 
            "nvim-lua/plenary.nvim",
            {"nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        }
    },

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

    -- bufferline
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",

	-- Statusline
    {
		"glepnir/galaxyline.nvim",
		event = "BufEnter",
		requires = { "nvim-web-devicons" },
    },

    -- A pretty list for showing diagnostics
	"folke/trouble.nvim",

    -- A tree like view for symbols
	"simrat39/symbols-outline.nvim",

	-- Git
	"lewis6991/gitsigns.nvim",
	'kdheepak/lazygit.nvim',
    'tpope/vim-fugitive',

	-- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
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

    -- Cursor-word highlighter + text objects
	"RRethy/vim-illuminate",

    -- match-up is a plugin that lets you highlight
	"andymass/vim-matchup",
  	
    -- Select increasingly larger regions of text using the same key combination
    "terryma/vim-expand-region",
 	-- A simple, easy-to-use Vim alignment plugin	
    "junegunn/vim-easy-align",

    -- The Multicursor Plugin for Neovim extends the native Neovim text editing capabilities
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {
            'nvimtools/hydra.nvim',
        },
        opts = {},
        cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
        keys = {
            {
                mode = { 'v', 'n' },
                '<C-m>',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
    },
    -- This plugin provides f/t/F/T mappings that can be customized by your setting
    "hrsh7th/vim-eft",
   	-- a plugin to place, toggle and display marks
    "kshenoy/vim-signature",
})
