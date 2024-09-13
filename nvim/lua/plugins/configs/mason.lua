local options = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	pip = {
		---@since 1.0.0
		-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
		upgrade_pip = false,

		---@since 1.0.0
		-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
		-- and is not recommended.
		--
		-- Example: { "--proxy", "https://proxyserver" }
		install_args = {},
	},

	ensure_installed = {
		"lua-language-server",
		-- "stylua",
		"ruff",
		"prettier",
		"fixjson",
		-- "yamlfmt",
		-- "shfmt",
		"python-lsp-server",
		-- "bash-language-server",
		"typescript-language-server",
		-- "gopls",
	}, -- not an option from mason.nvim
	PATH = "skip",
	-- ui = {
	--   icons = {
	--     package_installed = "✓",
	--     package_pending = "➜",
	--     package_uninstalled = "✗",
	--     -- package_pending = " ",
	--     -- package_installed = " ",
	--     -- package_uninstalled = " ﮊ",
	--   },
	--   -- keymaps = {
	--   --   toggle_server_expand = "<CR>",
	--   --   install_server = "i",
	--   --   update_server = "u",
	--   --   check_server_version = "c",
	--   --   update_all_servers = "U",
	--   --   check_outdated_servers = "C",
	--   --   uninstall_server = "X",
	--   --   cancel_installation = "<C-c>",
	--   -- },
	-- },
	max_concurrent_installers = 10,
}

return options
