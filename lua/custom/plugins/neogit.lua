return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',

      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {
        disable_signs = true,
      }
    end,
    keys = {
      { '<leader>tg', '<cmd>Neogit<cr>', desc = 'NeoGit' },
    },
  },
}
