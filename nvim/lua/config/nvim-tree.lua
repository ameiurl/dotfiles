local status_ok, tree = pcall(require, 'nvim-tree')
if not status_ok then
	print("Couldn't load 'nvim-tree'")
	return
end

local my_on_attach = function(bufnr)
	local api = require('nvim-tree.api')

	-- BEGIN_DEFAULT_ON_ATTACH
	local opts = function(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set('n', 'l',  api.node.open.edit,                    opts('Open'))
	vim.keymap.set('n', 'h',  api.node.navigate.parent_close,        opts('Close Directory'))
	vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
	vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
	vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
	vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
	vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
	vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
	vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
	vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
	vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
	-- vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
	vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
	vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
	vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
	vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
	vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
	vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
	vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
	vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
	vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
	vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
	vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
	vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
	vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
	vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
	vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))

	-- vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
	-- vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
	vim.keymap.set('n', ']d',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
	vim.keymap.set('n', '[d',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))

	vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
	vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
	vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
	vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
	vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
	vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
	vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
	vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
	vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
	vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
	vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
	vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
	vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
	vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
	vim.keymap.set('n', '<Tab>', api.tree.close,                        opts('Close'))
	vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
	vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
	vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
	vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
	vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
	vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
	vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
	vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
	vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
	vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
	vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
	-- END_DEFAULT_ON_ATTACH
end

tree.setup {
	disable_netrw = true,
	hijack_cursor = true,
	reload_on_bufenter = true,
	prefer_startup_root = true,
	hijack_directories = {
		enable = false,
		auto_open = true,
	},
	open_on_tab = false,
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { 'help' },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = false,
		icons = {
          error = "",
          warning = "",
          info = "",
          hint = "󰌵",
		},
	},
	git = {
		show_on_dirs = true,
		show_on_open_dirs = false,
	},
	view = {
		side = "left",
		width = "20%",
		adaptive_size = false,
		preserve_window_proportions = true,
	},
	renderer = {
		add_trailing = true,
		group_empty = true,
		full_name = true,
		root_folder_label = false,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				edge   = "│",
				item   = "├",
				corner = "└",
				none   = " ",
			},
		},
		highlight_git = true,
		icons = {
			show = {
				git = true,
				folder_arrow = false,
			},
			git_placement = "before",
			glyphs = {
				git = {
                --  unstaged = "✗",
                 unstaged = "●",
                 staged = "✓",
                 unmerged = "",
                 renamed = "➜",
                 untracked = "★",
                 deleted = "",
                 ignored = "◌",
				},
                -- git = {
                  -- unstaged = " ", -- 
                  -- staged = "",
                  -- unmerged = "",
                  -- renamed = " ",
                  -- untracked = " ",
                  -- deleted = " ",
                  -- ignored = "◌",
                -- },
                --git = {
                --    unstaged = " ",
                --    staged = " ",
                --    unmerged = "",
                --    renamed = "➜",
                --    untracked = " ",
                --    deleted = " ",
                --    ignored = "◌",
                --},
			},
		},
	},
 
    on_attach = my_on_attach,
}

-- Because reload_on_bufenter doesn't work (when defining on_attach?)
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('NvimTreeAutoRefresh', { clear = true }),
	desc = 'Refresh NvimTree on BufEnter',
	pattern = 'NvimTree*',
	callback = function() require('nvim-tree.api').tree.reload() end,
})

-- Recipe for opening on startup:
vim.api.nvim_create_autocmd('VimEnter', {
	group = vim.api.nvim_create_augroup('NvimTreeAutoOpen', { clear = true }),
	desc = 'Open nvim-tree on startup',
	callback = function(opts)
		local directory = vim.fn.isdirectory(opts.file) == 1
		if not directory then
			return
		end

		vim.cmd.cd(opts.file)

		require('nvim-tree.api').tree.open()
	end,
})

-- nvim-tree
-- vim.keymap.set('n', '<Tab>', [[<Cmd>NvimTreeToggle<CR>]])

vim.g.nvim_tree_width = 45
local g = vim.g

function _G.inc_width_ind()
    g.nvim_tree_width = g.nvim_tree_width + 5
    return g.nvim_tree_width
end

function _G.dec_width_ind()
    g.nvim_tree_width = g.nvim_tree_width - 5
    return g.nvim_tree_width
end

vim.keymap.set('n', '<C-Left>', [[<Cmd>exec ':NvimTreeResize ' . v:lua.dec_width_ind()<CR>]])
vim.keymap.set('n', '<C-Right>', [[<Cmd>exec ':NvimTreeResize ' . v:lua.inc_width_ind()<CR>]])
