return {
    'saghen/blink.cmp',
     version = '1.*',
    event = "InsertEnter",
    opts = {
        keymap = { 
            preset = 'enter',
            ['<C-j>'] = { 'snippet_forward', 'fallback' },
            ['<C-k>'] = { 'snippet_backward', 'fallback' },
        },
        completion = { documentation = { auto_show = true } },
    }
}
