
-- require("evil_lualine")

local function lsp_client_name()
  local icon = "  "
  local msg = "No LSP"
  local buf_file_type = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then return msg end

  for _, client in ipairs(clients) do
    local file_types = client.config.filetypes
    if file_types and vim.fn.index(file_types, buf_file_type) ~= -1 then
      msg = client.name
      break
    end
  end

  return icon .. msg
end

local config = {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = {"", ""},
    section_separators = {"", ""},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {"filename"},
    lualine_x = {"encoding", "fileformat", "filetype", lsp_client_name},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- https://github.com/arkav/lualine-lsp-progress

local colors = {
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67"
}

local lsp_progress_component = {
  "lsp_progress",
  display_components = {
      "lsp_client_name",
      "spinner",
      {"title", "percentage", "message"},
  },
  colors = {
    lsp_client_name = colors.magenta,
    spinner = colors.cyan,
    title  = colors.cyan,
    percentage  = colors.cyan,
    message  = colors.cyan,
    use = true,
  },
  separators = {
    component = " ",
    lsp_client_name = { pre = "[", post = "]" },
    spinner = { pre = "", post = "" },
    title = { pre = "", post = ": " },
    percentage = { pre = "", post = "%% " },
    progress = " | ",
    message = { pre = "(", post = ")"},
  },
  timer = {
    progress_enddelay = 500,
    spinner = 1000,
    lsp_client_name_enddelay = 1000
  },
  spinner_symbols = {"🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 "},
}

table.insert(config.sections.lualine_c, lsp_progress_component)

require("lualine").setup(config)

