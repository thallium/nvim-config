return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      preview = {
        horizontal = "right:50%",
      }
    },
    files = {
      formatter      = "path.filename_first",
    },
    buffers = {
      formatter      = "path.filename_first",
    }
  },
  keys = function()
    return {
      { '<Leader>ff', require('fzf-lua').files },
      { '<Leader>fb', require('fzf-lua').buffers },
      { '<Leader>fe', require('fzf-lua').diagnostics_document },
      { '<Leader>s', require('fzf-lua').lsp_document_symbols },
      { 'gi', require('fzf-lua').lsp_implementations },
      { 'gd', require('fzf-lua').lsp_definitions },
      { 'gr', require('fzf-lua').lsp_references },
    }
  end
}
