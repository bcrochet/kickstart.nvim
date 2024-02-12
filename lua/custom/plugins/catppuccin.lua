return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 10010,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  }
}
