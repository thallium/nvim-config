return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  lazy = true,
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  config = function()
    require("luasnip").setup({
      enable_autosnippets = true,
    })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

    local map = vim.keymap.set
    local ls = require('luasnip')
    map('i', '<c-j>', function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end)
    map('n', '<Leader><Leader>s', function()
        require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
    end)
    map({ 'i', 's' }, '<c-n>', function ()
        if ls.choice_active() then
            ls.change_choice(1)
        else
            vim.api.nvim_input('<c-n>')
        end
    end)
    map({ 'i', 's' }, '<c-p>', function ()
        if ls.choice_active() then
            ls.change_choice(-1)
        else
            vim.api.nvim_input('<c-p>')
        end
    end)
  end
}
