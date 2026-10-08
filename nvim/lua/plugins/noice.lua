local M = {}

function M.setup()
  local ok, noice = pcall(require, "noice")
  if not ok then
    return
  end
  noice.setup({
    messages = {
      enabled = true,
    },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.apply_text_edits_to_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  })
end

return M
