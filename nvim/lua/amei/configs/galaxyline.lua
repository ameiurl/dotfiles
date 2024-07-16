local status_ok, gl = pcall(require, 'galaxyline')
if not status_ok then
	print("Couldn't load 'galaxyline'")
	return
end

gl.short_line_list = { 'NvimTree', 'Outline', 'Trouble', 'qf' }

local M = {}

--- Defines primary, secondary, foreground and background colors for a Vim mode
---@class ModeTheme
---@field primary string
---@field secondary string
---@field bg string
---@field light string
---@field dark string

--- Defines color palletes for all vim modes
---@class VimModeColors
---@field normal ModeTheme
---@field visual ModeTheme
---@field insert ModeTheme
---@field replace ModeTheme
---@field terminal ModeTheme
---@field command ModeTheme
---@field none ModeTheme

M.signs = {
	icons = {
		vim   = '  ',
		git   = '  ',
		git_changes = '±',
		line  = '  ',
		unix  = ' ',
		dos   = ' ',
		space = '•',
		tab   = 'ﬀ ',
		modified = 'פֿ',
		readonly = '',
	},
	separators = {
		right = ' ',
		right_thin = ' ',
		left = '',
		left_thin = '',
	},
	diagnostics = {
		lsp = ' ',
		error = ' ',
		warn = ' ',
	},
}

M.modecolors = {  ---@type VimModeColors
	command = {
		primary   = "#f8e087",
		secondary = "#5f5044",
		bg        = "#201010",
		light     = "#fcf0dc",
		dark      = "#453a22",
	},
	visual = {
		primary   = "#77c0ff",
		secondary = "#354fed",
		bg        = "#112060",
		light     = "#afe8ff",
		dark      = "#2040a0",
	},
	insert = {
		primary   = "#2bff9a",
		secondary = "#277e40",
		bg        = "#003322",
		light     = "#aaffdd",
		dark      = "#005010",
	},
	replace = {
		primary   = "#f76842",
		secondary = "#893401",
		bg        = "#201000",
		light     = "#ffdda0",
		dark      = "#43200a",
	},
	terminal = {
		primary   = "#8f4466",
		secondary = "#50302e",
		bg        = "#2a180b",
		light     = "#ffddee",
		dark      = "#4f0a05",
	},
	normal = {
		primary   = "#cbcbcb",
		secondary = "#535353",
		bg        = "#1e1e1e",
		light     = "#f0f0f0",
		dark      = "#343434",
	},
	none = {
		primary   = "#2b3c66",
		secondary = "#203044",
		bg        = "#0a0a1c",
		light     = "#a0b0c0",
		dark      = "#3a405b",
	},
}

-- return M

-- local theme = require 'user.galaxyline.theme'
-- local colors      = theme.modecolors
-- local icons       = theme.signs.icons
-- local separators  = theme.signs.separators
local colors      = M.modecolors
local icons       = M.signs.icons
local separators  = M.signs.separators

local M = {}

local gl = package.loaded.galaxyline

M.buffer_not_empty = function()
	return #vim.fn.bufname('%') > 0
end

local sections = { left = 0, mid = 0, right = 0, short_line_left = 0, short_line_right = 0 }

--- Declares a section of Galaxyline dynamically, so code can be moved around easily
---@param pos string Which part of Galaxyline this section belongs to
---@param tbl table The section's properties
M.section = function(pos, tbl)
	sections[pos] = sections[pos] + 1
	gl.section[pos][sections[pos]] = tbl
end

M.update_colors = function(statusline)
	vim.api.nvim_command('hi StatusLine guibg=' .. statusline .. ' gui=nocombine')
	for pos, _ in pairs(sections) do
		for i = 1, #gl.section[pos] do
			for k, v in pairs(gl.section[pos][i]) do
				local function none() return 'NONE' end
				local fg = v.highlight[1] or none
				local bg = v.highlight[2] or none
				local style = v.highlight[3] or none
				local cmd = 'hi! Galaxy' .. k
				          .. ' gui=' .. style()
				          .. ' guifg=' .. fg()
				          .. ' guibg=' .. bg()
				vim.api.nvim_command(cmd)
			end
		end
	end
end

-- return M

-- local U = require 'M.util'
local condition = require 'galaxyline.condition'

local mode_lookup = {
	n = colors.normal,
	i = colors.insert,
	v = colors.visual,
	V = colors.visual,
	[''] = colors.visual,
	r = colors.replace,
	R = colors.replace,
	t = colors.terminal,
	c = colors.command,
}
local mode = colors.normal

M.section('left', {
	VimIcon = {
		provider = function()
			mode = mode_lookup[vim.fn.mode()] or colors.normal
			M.update_colors(mode.bg)
			return icons.vim
		end,
		highlight = {
			function() return mode.bg end,
			function() return mode.primary end,
		},
	}
})
M.section('left', {
	VimSeparator = {
		provider = function() return separators.right end,
		highlight = {
			function() return mode.primary end,
			function() return condition.check_git_workspace() and mode.secondary or mode.bg end,
		},
	}
})
M.section('left', {
	GitBranch = {
		condition = condition.check_git_workspace,
		provider = function()
			local branch = require('galaxyline.provider_vcs').get_git_branch()
			return branch and branch:gsub('detached at ', '') or ''
		end,
		icon = icons.git,
		highlight = {
			function() return mode.primary end,
			function() return mode.secondary end,
		},
	}
})
M.section('left', {
	GitChanges = {
		condition = condition.check_git_workspace,
		provider = function()
			local vcs = require('galaxyline.provider_vcs')
			local changes = (vcs.diff_modified() or 0) + (vcs.diff_add() or 0) + (vcs.diff_remove() or 0)
			return changes > 0 and changes or ''
		end,
		icon = icons.git_changes,
		highlight = {
			function() return mode.bg end,
			function() return mode.secondary end,
		},
	}
})
M.section('left', {
	GitBranchSeparator = {
		condition = condition.check_git_workspace,
		provider = function() return separators.right end,
		highlight = {
			function() return mode.secondary end,
			function() return mode.bg end,
		},
	}
})
M.section('left', {
	FileName = {
		condition = M.buffer_not_empty,
		provider = function() return vim.fn.expand('%:.') .. ' ' end,
		highlight = {
			function() return mode.light end,
			function() return mode.bg end,
		},
	}
})
M.section('left', {
	FileModified = {
		condition = M.buffer_not_empty,
		provider = function() return vim.bo.modified and icons.modified or '' end,
		highlight = {
			function() return '#e2eb0a' end,
			function() return mode.bg end,
		},
	}
})
M.section('left', {
	FileReadOnly = {
		condition = function() return not vim.bo.modifiable end,
		provider = function() return icons.readonly end,
		highlight = {
			function() return '#ee0a02' end,
			function() return mode.bg end,
		},
	}
})

M.section('mid', {
	Diagnostics = {
		condition = function()
			return M.buffer_not_empty() and vim.bo.buftype ~= 'terminal'
		end,
		provider = function()
			if next(vim.lsp.buf_get_clients()) == nil then return '' end
			local all = vim.diagnostic.get(0)
			local errs = vim.tbl_filter(function(d)
				return d.severity == vim.diagnostic.severity.ERROR
			end, all)
			local warns = vim.tbl_filter(function(d)
				return d.severity == vim.diagnostic.severity.WARN
			end, all)
			-- return theme.signs.diagnostics.error .. #errs .. ' ' .. theme.signs.diagnostics.warn .. #warns
		end,
		highlight = {
			function() return mode.secondary end,
			function() return mode.bg end,
		},
	}
})

M.section('right', {
	Indentation = {
		condition = function()
			return M.buffer_not_empty() and vim.bo.buftype ~= 'terminal'
		end,
		provider = function()
			return (vim.bo.expandtab and icons.space or icons.tab) .. vim.bo.shiftwidth .. ' '
		end,
		highlight = {
			function() return mode.secondary end,
			function() return mode.bg end,
		},
	}
})
M.section('right', {
	RightSectionSeparator = {
		provider = function() return separators.left end,
		highlight = {
			function() return mode.dark end,
			function() return mode.bg end,
		},
	}
})
M.section('right', {
	FileFormat = {
		provider = function() return icons[vim.bo.fileformat] end,
		highlight = {
			function() return mode.primary end,
			function() return mode.dark end,
		},
	}
})
M.section('right', {
	FileTypeSeparator = {
		condition = function()
			return M.buffer_not_empty() and vim.bo.buftype ~= 'terminal'
		end,
		provider = function() return separators.left_thin .. ' ' end,
		highlight = {
			function() return mode.bg end,
			function() return mode.dark end,
		},
	}
})
M.section('right', {
	FileType = {
		condition = function()
			return M.buffer_not_empty() and vim.bo.buftype ~= 'terminal'
		end,
		provider = function()
			local ft = vim.bo.filetype
			if ft == 'typescriptreact' then
				ft = 'tsx'
			elseif ft == 'javascriptreact' then
				ft = 'jsx'
			end
			return ' ' .. ft .. ' '
		end,
		highlight = {
			function() return mode.primary end,
			function() return mode.dark end,
			function() return 'italic' end,
		},
	}
})
M.section('right', {
	LinePosSeparator = {
		provider = function() return separators.left_thin .. ' ' end,
		highlight = {
			function() return mode.primary end,
			function() return mode.dark end,
			function() return 'bold' end,
		},
	}
})
M.section('right', {
	LinePosition = {
		provider = function()
			return icons.line .. vim.fn.line('.') .. ':' .. vim.fn.col('.') .. ' '
		end,
		highlight = {
			function() return mode.primary end,
			function() return mode.dark end,
			function() return 'bold' end,
		},
	}
})

M.section('short_line_left', {
	ShortBufferLabel = {
		condition = M.buffer_not_empty,
		provider = function()
            local output = vim.bo.buftype == 'nofile' and vim.bo.filetype or vim.fn.expand('%:.')
			if vim.bo.modified then output = output .. ' * ' end
			return output
		end,
		highlight = {
			function() return "black" end,
			function() return colors.normal.dark end,
			function() return 'bold,italic' end,
		},
		separator = separators.right,
		separator_highlight = {
			colors.normal.dark,
			"black",
		},
	}
})
