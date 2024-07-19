local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	print("Couldn't load 'telescope'")
	return
end

--local lazytrouble = require('lazy-require').require_on_exported_call('trouble.providers.telescope')

-- local keys = require('amei.maps').telescope
local actions = require('telescope.actions')

telescope.setup {
	defaults = {
		winblend = 10,
		prompt_prefix = '> ',
		selection_caret = '> ',
		-- sorting_strategy = 'ascending',

		layout_strategy = 'flex',

		layout_config = {
			horizontal = {
				width = 0.9,
				preview_width = 0.5,
			},
			center = {
				width = 0.7,          -- TODO: bug report this not working
				preview_cutoff = 40,  -- lines
			},
			flex = {
				flip_columns = 120,
				flip_lines = 1,
			},
		},

		mappings = {
			-- n = M.normal(actions),
			-- i = M.insert(actions),
            n = {
                ['<esc>'] = actions.close,
                ['<C-e>'] = actions.close,  -- redundant, don't use.  Only here because I'm retarded
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                -- ['<C-t>'] = actions.select_tab,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<A-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
 --               ['<C-t>'] = lazytrouble.open_with_trouble,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>']   = actions.move_selection_previous,
                ['j'] = actions.move_selection_next,
                ['k'] = actions.move_selection_previous,
                ['g'] = actions.move_to_top,
                ['z'] = actions.move_to_middle,
                ['G'] = actions.move_to_bottom,
                ['dd'] = actions.delete_buffer,

                ['<PageUp>']   = actions.preview_scrolling_up,
                ['<PageDown>'] = actions.preview_scrolling_down,

                ['?'] = actions.which_key,
            },
            i = {
                ['<C-e>'] = actions.cycle_history_next,
                ['<C-r>'] = actions.cycle_history_prev,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-S-d>'] = actions.delete_buffer,

                -- ['<C-e>'] = actions.close,  -- deprecated
                ['<esc>'] = actions.close,
                ['<C-esc>'] = function() vim.api.nvim_command [[stopinsert]] end,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>']   = actions.move_selection_previous,

                ['<CR>'] = actions.select_default,
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                -- ['<C-t>'] = actions.select_tab,

                ['<C-u>'] = actions.results_scrolling_up,
                ['<C-d>'] = actions.results_scrolling_down,

                ['<PageUp>']   = actions.preview_scrolling_up,
                ['<PageDown>'] = actions.preview_scrolling_down,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<A-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
  --              ['<C-t>'] = lazytrouble.open_with_trouble,
                ['<C-l>'] = actions.complete_tag,
                ['<C-_>'] = actions.which_key,   -- keys from pressing <C-/> (what?)
	        },
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
	},

	pickers = {
		lsp_references = {
			require('telescope.themes').get_dropdown(),
			show_line = false,
		},
	},

	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_cursor(),
		},
	},
}

telescope.load_extension('ui-select')

-- telescope
local lazyscope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ta', lazyscope.live_grep,                 { desc = "Telescope live-grep all files" })
vim.keymap.set('n', '<leader>tw', lazyscope.grep_string,               { desc = "Telescope grep symbol under cursor" })
vim.keymap.set('n', '<leader>f',  lazyscope.find_files,                { desc = "Telescope fuzzy-search for files" })
vim.keymap.set('n', '<leader>ts', lazyscope.treesitter,                { desc = "Telescope list treesitter symbols in buffer" })
-- vim.keymap.set('n', '<leader>qh', lazyscope.quickfixhistory,           { desc = "Telescope list quickfix history" })
vim.keymap.set('n', '<leader>th', lazyscope.oldfiles,           		{ desc = "Telescope list history" })
-- vim.keymap.set('n', '<leader>rg', lazyscope.current_buffer_fuzzy_find, { desc = "Telescope grep inside current buffer" })
vim.keymap.set('n', '<leader>tt', lazyscope.resume,                    { desc = "Telescope resume last session" })
vim.keymap.set('n', '<leader>tm', lazyscope.marks,                    	{ desc = "Telescope list marks" })
vim.keymap.set('n', '<leader>tg', "<CMD>lua require('telescope.builtin').grep_string { search = 'n '.. vim.fn.expand('<cword>')}<CR>", { desc = "Telescope grep n+ under cursor word" })
vim.keymap.set('n', '<leader>tf', "<CMD>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>",   { desc = "Telescope list buffer" })
vim.keymap.set('n', '<Leader>tb', function()
	if not pcall(function() lazyscope.buffers() end) then
		-- This is the kind of stupid shit I have to go through just to emulate keypresses
		local cmdstr = vim.api.nvim_replace_termcodes(':ls<CR>:b', true, false, true)
		vim.api.nvim_feedkeys(cmdstr, 'n', false)
	end
end, { desc = "List open buffers in telescope, or with :ls if telescope can't be loaded" })
function _G.__telescope_buffers()
    require('telescope.builtin').buffers(
        require('telescope.themes').get_dropdown {
            previewer = false,
            only_cwd = vim.fn.haslocaldir() == 1,
            show_all_buffers = false,
            sort_mru = true,
            ignore_current_buffer = true,
            sorter = require('telescope.sorters').get_substr_matcher(),
            selection_strategy = 'closest',
            path_display = { 'shorten' },
            layout_strategy = 'center',
            winblend = 0,
            layout_config = { width = 70,height = 25 },
            color_devicons = true,
        }
    )
end
vim.keymap.set('n', '<leader>b', '<CMD>lua __telescope_buffers()<CR>',                    	{ desc = "Telescope list buffer" })
