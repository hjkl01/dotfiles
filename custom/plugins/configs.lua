local M = {}

M.onedark = {
	require("onedark").setup({
    -- :help highlight-args
		commentStyle = "italic",
		keywordStyle = "bold",
		functionStyle = "underlineline",
		-- variableStyle = "bold",
		-- transparent = true,
		-- hideInactiveStatusline = true,
		sidebars = { "qf", "vista_kind", "terminal", "packer" },
	}),
}

M.mason = {
	ensure_installed = {
		"python-lsp-server",
		-- "lua-language-server",
		-- "stylua",
		"typescript-language-server",
		"bash-language-server",
		"prettier",
		"pylint",
		"black",
		"shfmt",
	}, -- not an option from mason.nvim
}

M.treesitter = {
	ensure_installed = {
		"lua",
		"python",
		"go",
		"bash",
		"javascript",
		"typescript",
	},
}

M.nvimtree = {
	view = {
		width = 25,
		hide_root_folder = false,
		side = "right",
		preserve_window_proportions = false,
		number = true,
		relativenumber = true,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {
				-- user mappings go here
				{ key = "v", action = "vsplit" },
				{ key = "s", action = "split" },
			},
		},
	},
}

return M
