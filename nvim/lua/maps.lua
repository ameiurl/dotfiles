-- Utility functions
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts = vim.tbl_extend('keep', opts, { remap = false, silent = true })
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Normal -----------------------------------------------------------------------------
-- Better window navigation
map('n', '<C-h>', [[<C-w>h]])
map('n', '<C-j>', [[<C-w>j]])
map('n', '<C-k>', [[<C-w>k]])
map('n', '<C-l>', [[<C-w>l]])

-- Fast scrolling
map('n', '<C-e>', [[5<C-e>]])
map('n', '<C-y>', [[5<C-y>]])
map('n', 'K', [[<Esc>5<up>]])
map('n', 'J', [[<Esc>5<down>]])

map('n', 'k', [[gk]])
map('n', 'gk', [[k]])
map('n', 'j', [[gj]])
map('n', 'gj', [[j]])

map('n', 'n', [[nzz]])
map('n', 'N', [[Nzz]])
map('n', '*', [[*zz]])
map('n', '#', [[#zz]])
map('n', 'g*', [[g*zz]])

-- Move lines
-- map('n', '<S-j>', [[<Cmd>move .+1<CR>==]])
-- map('n', '<S-k>', [[<Cmd>move .-2<CR>==]])

-- Bbye commands
map('n', '<Leader>q', [[<Cmd>:q<CR>]])
map('n', '<Leader>d', [[<Cmd>Bdelete<CR>]])
map('n', '<C-o>', [[<Cmd>b#<CR>]])
map('n', 'U', [[<C-r>]])
map('n', 'gj', [[J]])
map('n', 'gh', [[/<c-r>=expand("<cword>")<CR><CR>N]])
map('n', '<leader>/', [[:nohls<CR>]])
map('n', '<leader>w', [[:w<CR>]])
map('n', '<leader>sa', [[ggVG]])

-- Window resizing with CTRL-Arrowkey
map('n', '<C-S-Up>'   , [[2<C-w>-]])
map('n', '<C-S-Down>' , [[2<C-w>+]])
map('n', '<C-S-Left>' , [[2<C-w><]])
map('n', '<C-S-Right>', [[2<C-w>>]])

-- Navigate buffers
map('n', '<C-n>', [[<Cmd>bnext<CR>]])
map('n', '<C-p>', [[<Cmd>bprev<CR>]])


-- Visual -----------------------------------------------------------------------------

-- Stay in indent mode
map('v', '<', [[<gv]])
map('v', '>', [[>gv]])

-- Move text up and down
map('v', '<C-j>', [[:move '>+1<CR>gv=gv]])
map('v', '<C-k>', [[:move '<-2<CR>gv=gv]])

-- insert -----------------------------------------------------------------------------
map('i', '<C-h>', [[<Left>]])
map('i', '<C-j>', [[<Down>]])
map('i', '<C-k>', [[<Up>]])
map('i', '<C-l>', [[<Right>]])

-- Overwrite paste
-- map('v', 'p', [["vdp]])
-- map('v', 'P', [["vdP]])
map('x', 'p', [["_dP]])

-- Select Last Copy
map('n', 'gV', [[`[v`] ]])

-- Replace text command
local function replace_all()
	local query = vim.fn.strcharpart(
		vim.fn.getline(vim.fn.line('.')),
		vim.fn.min({
			vim.fn.charcol('.'),
			vim.fn.charcol('v'),
		}) - 1,
		vim.fn.abs(vim.fn.charcol('.') - vim.fn.charcol('v')) + 1
	)

	vim.fn.inputsave()
	local answer = vim.fn.input("Replace text: ", query)
	vim.api.nvim_command(
		'%s/\\V' .. query:gsub('/','\\/') .. '/' .. answer:gsub('/','\\/') .. '/ge'
	)
	vim.fn.inputrestore()
	vim.api.nvim_feedkeys('v', 'n', false)
end
map('x', '<C-r>', replace_all, { desc = "Replace all selected text in buffer" })

-- Plugin keybinds --------------------------------------------------------------------

-- vim-expand-region
map('v', 'v', [[<Plug>(expand_region_expand)]])
map('v', 'v', [[<Plug>(expand_region_expand)]])

-- vim-easy-align
map('n', '<Leader>a', [[<Plug>(EasyAlign)]])
map('v', '<Leader>a', [[<Plug>(EasyAlign)]])

-- vim-eft
map('n', ';', [[<Plug>(eft-repeat)]])
map('x', ';', [[<Plug>(eft-repeat)]])
map('n', 'f', [[<Plug>(eft-f)]])
map('x', 'f', [[<Plug>(eft-f)]])
map('o', 'f', [[<Plug>(eft-f)]])
map('n', 'F', [[<Plug>(eft-F)]])
map('x', 'F', [[<Plug>(eft-F)]])
map('o', 'F', [[<Plug>(eft-F)]])
map('n', 't', [[<Plug>(eft-t)]])
map('x', 't', [[<Plug>(eft-t)]])
map('o', 't', [[<Plug>(eft-t)]])
map('n', 'T', [[<Plug>(eft-T)]])
map('x', 'T', [[<Plug>(eft-T)]])
map('o', 'T', [[<Plug>(eft-T)]])

-- nvim-tree
map('n', '<Tab>', [[<Cmd>NvimTreeToggle<CR>]])

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

map('n', '<C-Left>', [[<Cmd>exec ':NvimTreeResize ' . v:lua.dec_width_ind()<CR>]])
map('n', '<C-Right>', [[<Cmd>exec ':NvimTreeResize ' . v:lua.inc_width_ind()<CR>]])

-- symbol
map('n', '<leader>e', [[<Cmd>SymbolsOutline<CR>]])

-- lazyGit
map('n', '<leader>gg', [[<Cmd>LazyGit<CR>]])