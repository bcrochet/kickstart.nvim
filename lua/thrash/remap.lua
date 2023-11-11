vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>i', 'i_<Esc>r')
vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'LSP: Type Definition' })
