-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Vimtex settings
-- vim.g.vimtex_compiler_method = 'latexmk'
-- vim.g.vimtex_latexmk_enabled = 1
-- vim.g.vimtex_latexmk_continuous = 1
-- vim.g.vimtex_compiler_latexmk = {
--    executable = 'latexmk',
--    args = {'-pdf', '-interaction=nonstopmode', '-synctex=1', '--lua'},
-- }
--
vim.g.vimtex_compiler_method = 'lualatex'
vim.g.vimtex_view_method = 'zathura'

