local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'
local previewers = require 'telescope.previewers'
require("telescope").setup {
	defaults = {
		theme = "dropdown",
		--sorting_strategy = "ascending",
		layout_config = {
			--prompt_position = "top",
		},
		--prompt_prefix = "🔭 ",
		prompt_prefix = " ",
		selection_caret = " ",
		preview_width = 0.6,
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
		mappings = {
			i = {
				['<ESC>'] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous
			},
			n = { ['<ESC>'] = actions.close },
		},
		file_ignore_patterns = {
			'%.gif',
			'%.jpg',
			'%.jpeg',
			'%.png',
			'%.svg',
			'%.otf',
			'%.ttf',
			'%.ico',
			'%.woff',
			'%.woff2',
			'%.eot',
		},
		file_sorter = sorters.get_fzy_sorter,
		generic_sorter = sorters.get_fzy_sorter,
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
		layout_strategy = 'flex',
		--winblend = 7,
		set_env = { COLORTERM = 'truecolor' },
		color_devicons = true,
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	}
}

-- fuzzyfind 模糊搜索 快捷键
function _G.__telescope_files()
	require('telescope.builtin').find_files{
	    path_display = {},
	    layout_strategy = 'horizontal',
	    layout_config = { preview_width = 0.55 },
    }
end
function _G.__telescope_buffers()
	require('telescope.builtin').buffers {
		sort_mru = true,
		ignore_current_buffer = true,
		sorter = require('telescope.sorters').get_substr_matcher(),
		path_display = { 'shorten' },
		layout_strategy = 'horizontal',
		layout_config = { preview_width = 0.65 },
		show_all_buffers = true,
		color_devicons = true,
	}
end
function _G.__telescope_grep()
	require('telescope.builtin').live_grep {
		path_display = {},
		layout_strategy = 'horizontal',
		layout_config = { preview_width = 0.55 },
	}
end
function _G.__telescope_commits()
	require('telescope.builtin').git_commits {
		layout_strategy = 'horizontal',
		layout_config = { preview_width = 0.55 },
	}
end
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
    "n", 
    "<Leader>h", 
    ":<C-u>Telescope oldfiles<CR>", 
    opts
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>b',
	'<cmd>lua __telescope_buffers()<CR>',
	opts
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>f',
	'<cmd>lua __telescope_files()<CR>',
	opts
)
vim.api.nvim_set_keymap(
    'n', 
    '<C-g>', 
    '<cmd>Telescope git_status<CR>', 
    opts
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>ss',
	'<cmd>lua __telescope_grep()<CR>',
	opts
)
vim.api.nvim_set_keymap(
    "n", 
    "<leader>sw", 
    "<CMD>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>')}<CR>", 
    opts
)
vim.api.nvim_set_keymap(
    "n", 
    "<leader>sf", 
    "<CMD>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", 
    opts
)
vim.api.nvim_set_keymap(
    "n", 
    "<leader>sg", 
    "<CMD>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<CR>", 
    opts
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>c',
	'<cmd>lua __telescope_commits()<CR>',
	opts
)
vim.api.nvim_set_keymap(
    "n", 
    "<Space>f", 
    "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<CR>", 
    opts
)
-- vim.api.nim_set_keymap(
--     'n', 
--     '<Space>s',
--     "<cmd>lua require('telescope').extensions.frecency.frecency({layout_strategy = 'vertical'})<CR>",
-- opts
-- )
-- vim.api.nvim_set_keymap(
	--'n',
	--',h',
	-- path_display = {},
	-- layout_strategy = 'horizontal',
	-- layout_config = { preview_width = 0.55 },
	-- '<cmd>lua require "telescope.builtin".help_tags()<CR>',
	-- opts
--)
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	',pr',
-- 	'<cmd>lua require "telescope.builtin".extensions.pull_request()<CR>',
-- 	opts
-- )
