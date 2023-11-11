return {
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',

      'nvim-telescope/telescope.nvim',
    },
    opts = {
      disable_signs = true,
      kind = 'auto',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>tg', '<cmd>Neogit<cr>', desc = '[T]oggle Neo[G]it UI' },
    },
  },
}
