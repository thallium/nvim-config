local nvim_lsp = require('lspconfig')
local map = require('key_maps').map

-- update diagnostics in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- underline=false,
        update_in_insert = true,
    }
)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local function buf_set_keymap(mode, lhs, rhs)
            map(mode, lhs, rhs, { buffer = ev.buf, silent = true })
        end

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

        -- For plugins with an `on_attach` callback, call them here. For example:
        -- require'completion'.on_attach()
        require 'lsp_signature'.on_attach({
            bind = true,
            -- floating_window = false,
            -- hint_enable = true,
            hint_prefix = '',
        })
    end
})

local servers = {
    clangd = {
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        }
        -- on_attach = function(client, bufnr)
        --     client.server_capabilities.semanticTokensProvider = nil
        -- end
    },
    gopls = {},
    pyright = {},
    texlab = {},
    rust_analyzer = {
        exec = "rust-analyzer"
    },
    lua_ls = {
        exec = "lua-language-server",
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
}

if require('utils').has_custom() then
    local cwd = vim.fn.getcwd()
    for _, config in pairs(require 'custom'.project_config) do
        if cwd:match(config.path) then
            for name, lsp_config in pairs(config.lsp_config) do
                servers[name] = vim.tbl_extend("force", servers[name], lsp_config)
            end
        end
    end
end

for name, config in pairs(servers) do
    if vim.fn.executable(config.exec or name) == 1 then
        if not config.disabled then
            nvim_lsp[name].setup(config)
        end
    end
end
