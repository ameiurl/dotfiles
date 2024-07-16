-- Automatically run: PackerCompile
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

return require("packer").startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")

	-- Common utilities
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	use("tjdevries/lazy-require.nvim")

	-- Icons
	use("nvim-tree/nvim-web-devicons")

	-- Colorschema
	use("ameiurl/seoul256.vim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("amei.configs.treesitter")
		end,
	})

	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("amei.configs.telescope")
		end,
	})
	use("nvim-telescope/telescope-ui-select.nvim")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("amei.configs.lsp")
		end,
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("Issafalcon/lsp-overloads.nvim")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- cmp: Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("amei.configs.cmp")
		end,
	})
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("amei.configs.luasnip")
		end,
	})
	use("saadparwaiz1/cmp_luasnip")
	use("ameiurl/friendly-snippets")

	-- File manager
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("amei.configs.nvim-tree")
		end,
	})

	-- Statusline
	use({
		"glepnir/galaxyline.nvim",
		event = "BufEnter",
		config = function()
			require("amei.configs.galaxyline")
		end,
		requires = { "nvim-web-devicons" },
	})

	-- Show colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("amei.configs.trouble")
		end,
	})

    -- LazyGit
	use('kdheepak/lazygit.nvim')

    -- Cursor-word highlighter + text objects
	use({
		"RRethy/vim-illuminate",
		config = function()
			require("amei.configs.illuminate")
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("amei.configs.gitsigns")
		end,
	})

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("amei.configs.autopairs")
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("amei.configs.comment")
        end, 
    })

	use({
		"karb94/neoscroll.nvim",
		config = function()
            require('neoscroll').setup {}
        end, 
    })

	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("amei.configs.bufferline")
        end, 
    })
	use("moll/vim-bbye")

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("amei.configs.symbols-outline")
        end, 
    })

	use({
		"andymass/vim-matchup",
        commit = nil,
        event = 'VimEnter',
        config = function()
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_offscreen = {}
        end,
    })

    use('terryma/vim-expand-region')  				  -- Select increasingly larger regions of text using the same key combination
    use('junegunn/vim-easy-align') 					  -- A simple, easy-to-use Vim alignment plugin	
    use({
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
    })
    use('hrsh7th/vim-eft')
    use('tpope/vim-fugitive') 						  -- it's the premier Git plugin for Vim
    use('kshenoy/vim-signature')   					      -- a plugin to place, toggle and display marks
    use({
        'lambdalisue/suda.vim',
        config = function()
            vim.g.suda_smart_edit=1
        end,
    })

end)
