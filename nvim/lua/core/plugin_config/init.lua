local function fullPath(moduleName)
  local path = "/core.plugin_config"
  return path .. "." .. moduleName
end

require(fullPath("treesitter"))
require(fullPath("mason-lsp"))
require(fullPath("lsp"))
require(fullPath("nvim-tree"))
require(fullPath("telescope"))
require(fullPath("vimtex"))
require(fullPath("colorscheme"))
require(fullPath("surround"))
require(fullPath("indent-blankline"))
require(fullPath("autopairs"))
require(fullPath("lualine"))
require(fullPath("comment"))
require(fullPath("dap"))
require(fullPath("cmake-tools"))
require(fullPath("highlight-colors"))

