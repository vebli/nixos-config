require('mason').setup({
    pip = {
      upgrade_pip = true,
    },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {'lua_ls', 'rust_analyzer',  'cmake', 'pylsp', 'clangd', 'jsonls', 'html', 'sqlls'},
})

--Keymap
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
local function nkeymap(key, map)
  keymap('n', key, map, opts)
end

nkeymap('gd' ,':lua vim.lsp.buf.definitions()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')
