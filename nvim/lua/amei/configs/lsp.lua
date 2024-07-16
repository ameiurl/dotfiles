local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn",  text = "" },
	{ name = "DiagnosticSignInfo",  text = "" },
	{ name = "DiagnosticSignHint",  text = "󰌵" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, {
		texthl = sign.name,
		text   = sign.text,
		numhl  = "",
	})
end

local config = {
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
		spacing  = 2,
		prefix   = "⋮",
	},
	signs = {
		active = signs,
	},
	update_in_insert = true,
	severity_sort    = true,
	underline = {
		severity = {
			-- min = vim.diagnostic.severity.INFO,
		},
	},
	float = {
		focusable = false,
		style     = "minimal",
		border    = "rounded",
		source    = "if_many",
		header    = "",
		prefix    = "· ",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

require('lspconfig.ui.windows').default_options.border = "rounded"

local M = {}

---@param f fun()
local function try(f)
	return function()
		return pcall(f)
	end
end

---@param action string
local function try_fancy(action)
	local try_telescope = try(function()
		require('telescope.builtin')[action]({ show_line = false })
	end)

	local try_trouble = try(function()
		vim.api.nvim_command('Trouble ' .. action)
	end)

	return function()
		if not (try_telescope() or try_trouble()) then
			({	lsp_declarations     = vim.lsp.buf.declaration,
				lsp_definitions      = vim.lsp.buf.definition,
				lsp_type_definitions = vim.lsp.buf.type_definition,
				lsp_references       = vim.lsp.buf.references,
				lsp_implementations  = vim.lsp.buf.implementation,
			})[action]()
		end
	end
end

local function nice_diagnostics(opts)
	opts = opts or {}
	opts.scope = opts.scope or 'document'
	return function()
		if not pcall(function() vim.api.nvim_command('Trouble ' .. opts.scope .. '_diagnostics') end) then
			vim.diagnostic.setqflist { open = true }
		end
	end
end

local handlers = {}
handlers.on_attach = function(client, bufnr)
	if pcall(function() return vim.api.nvim_buf_get_var(bufnr, 'UserLspAttached') == 1 end) then
		return
	end
	vim.api.nvim_buf_set_var(bufnr, 'UserLspAttached', 1)

	-- require('user.lsp.navic').try_attach(client, bufnr)

	-- require('user.settings.keymaps').lsp_setup(client, bufnr)

	local function map(mode, lhs, rhs, opts)
		opts = vim.tbl_extend("force", opts or {}, { remap = false, silent = true, buffer = bufnr })
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	--- Custom actions from Hoffs/omnisharp-extended-lsp.nvim should be used when the client is Omnisharp
	---@param method_name string
	---@param opts? table
	---@return function
	local function maybe_omnisharp(method_name, opts)
		return client.name == 'omnisharp'
			and require('omnisharp_extended')[((opts or {}).telescope and 'telescope_' or '') .. method_name]
			or try_fancy(method_name)
	end

	map('n', 'gH', vim.lsp.buf.hover,         { desc = "LSP show information about symbol under cursor" })
	map('n', '<localleader>r',  vim.lsp.buf.code_action,   { desc = "LSP code actions" })
	map('n', '<localleader>e',  vim.diagnostic.open_float, { desc = "Show line diagnostics" })
	map('n', 'gl', maybe_omnisharp('lsp_references',  { telescope = true }), { desc = "LSP list references" })
	map('n', 'go', maybe_omnisharp('lsp_definitions', { telescope = true }), { desc = "LSP go to definition" })
    map('n', '<localleader>di', maybe_omnisharp('lsp_implementations', { telescope = true}),
		{ desc = "LSP list implementations" })

	map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP signature help" })

	map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

	map('n', '<localleader>dh', nice_diagnostics { scope = 'workspace' }, { desc = "Show workspace diagnostics" })
	map('n', '<localleader>dd', nice_diagnostics { scope = 'document' }, { desc = "Show document diagnostics" })

	map('n', '<localleader>gd', try_fancy("lsp_declarations"), { desc = "LSP go to declaration of symbol" })
	map('n', '<localleader>gn', vim.lsp.buf.rename, { desc = "LSP rename symbol" })

	-- Formatting commands
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(opts)
		local format_opts = { async = true }
		if opts.range > 0 then
			format_opts.range = {
				{ opts.line1, 0 },
				{ opts.line2, 0 },
			}
		end
		vim.lsp.buf.format(format_opts)
	end, { range = true })

	map({ 'n', 'v' }, '<leader>F', [[<Cmd>Format<CR>]])
end

handlers.capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
	handlers.capabilities = cmp_nvim_lsp.default_capabilities(handlers.capabilities)
else
	print("Couldn't load 'cmp_nvim_lsp' nor update capabilities")
end

handlers.capabilities.offsetEncoding = { 'utf-16' }

-- local handlers = require('amei.configs.lsp.handlers')
require('lspconfig').gdscript.setup {
	on_attach    = handlers.on_attach,
	capabilities = handlers.capabilities,
}

-- mason config
local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
	print("Couldn't load 'mason'")
	return
end

local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')
if not mason_lsp_ok then
	print("Couldn't load 'mason-lspconfig'")
	return
end

mason.setup {
	ui = {
		border = "rounded",
	},
}

mason_lsp.setup {
	ensure_installed = {
		-- "lua_ls",
		-- "vimls",
	},
}

mason_lsp.setup_handlers {
	-- Automatically invoke lspconfig setup for every installed LSP server
	function (server_name)
		local opts = vim.tbl_deep_extend("force", {}, handlers)
		--local has_settings, settings = pcall(require, 'amei.configs.lsp2.settings.'..server_name)
		--if has_settings then
		--	opts = vim.tbl_deep_extend("force", opts, settings)
		--end
		require('lspconfig')[server_name].setup(opts)
	end,
}
