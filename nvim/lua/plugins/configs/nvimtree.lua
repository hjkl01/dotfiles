require("nvim-tree").setup {
	auto_reload_on_write = true,
	disable_netrw = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	sort_by = "name",
	root_dirs = {},
	prefer_startup_root = false,
	sync_root_with_cwd = false,
	reload_on_bufenter = false,
	respect_buf_cwd = false,
	on_attach = "default",
	select_prompts = false,
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
		side = "right",
		number = true,
		relativenumber = true,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
}
