local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, 
        { name = 'buffer' },
    }),
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }, 
    })
})

-- Set up lspconfig.

mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
})
--lspconfig setup
local servers = {
    'texlab',
    'lua_ls',
    'pylsp',
    'gopls',
    'nil_ls',
    'html',
    'biome',
    'tsserver',
    'cssls',
    'tailwindcss',
    'volar',
    'cmake',
    'docker_compose_language_service',
    'dockerls',
    'rust_analyzer',
    'arduino_language_server',
}
for _, server in ipairs(servers) do
    lspconfig[server].setup {
        capabilities = capabilities,
    }
end

lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = { 'clangd', '--compile-commands-dir=build'},
    filetypes = { 'c', 'cpp' },
    root_dir = function() return vim.fn.getcwd() end,
    on_attach = function(client, bufnr)
        -- Set compiler flags
        vim.api.nvim_buf_set_option(bufnr, 'makeprg', 'clang\\ -Wall\\ -Wextra\\ -O3\\ %')
        vim.api.nvim_buf_set_option(bufnr, 'errorformat', '%f:%l:%c:\\ %tarning:\\ %m,%f:%l:%c:\\ %trror:\\ %m')
    end,
}
lspconfig.sqls.setup {
    capabilities = capabilities,
    root_dir = function() return vim.fn.getcwd() end,
}
