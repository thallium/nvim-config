return {
    'saghen/blink.cmp',
     version = '1.*',
    event = "InsertEnter",
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
        snippets = { preset = 'luasnip' },
        keymap = { 
            preset = 'enter',
            ['<C-j>'] = { 'snippet_forward', 'fallback' },
            ['<C-k>'] = { 'snippet_backward', 'fallback' },
        },
        completion = { documentation = { auto_show = true } },
    }
}
