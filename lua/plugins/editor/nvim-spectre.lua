return {
  'windwp/nvim-spectre',
  build = false,
  cmd = "Spectre",
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>S', function() require('spectre').open() end },
    { '<leader>fw', function() require('spectre').open_visual({select_word=true}) end }
  }
}
