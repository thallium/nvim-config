vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function ()
        vim.highlight.on_yank({higroup="IncSearch", timeout=250})
    end
})


local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    require("lazy").update({
      show = false,
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local function buf_set_keymap(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true })
        end

        -- defaults:
        -- https://neovim.io/doc/user/news-0.11.html#_defaults

        -- map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        -- map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")


        buf_set_keymap('n', '<Leader>ca', vim.lsp.buf.code_action)
        buf_set_keymap('n', 'K', vim.lsp.buf.hover)
        buf_set_keymap('n', '<Leader>cn', vim.lsp.buf.rename)
        buf_set_keymap('n', '[e', vim.diagnostic.goto_prev)
        buf_set_keymap('n', ']e', vim.diagnostic.goto_next)
        buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help)
        buf_set_keymap('n', '<Leader>e', vim.diagnostic.open_float)
        buf_set_keymap('n', '<space>q', vim.diagnostic.setloclist)
        buf_set_keymap('n', '<Leader>F', function()
          vim.lsp.buf.format({ async = true })
        end)

        local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            -- When cursor stops moving: Highlights all instances of the symbol under the cursor
            -- When cursor moves: Clears the highlighting
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            -- When LSP detaches: Clears the highlighting
            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end
    end,

})
