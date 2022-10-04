local nvim_lsp = require('lspconfig')
local map = require('key_maps').map

-- update diagnostics in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- underline=false,
        update_in_insert = true,
    }
)

local custom_lsp_attach = function(client, bufnr)
    local function buf_set_keymap(mode, lhs, rhs)
        map(mode, lhs, rhs, { buffer = bufnr, silent = true })
    end

    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- buf_set_keymap('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')

    buf_set_keymap('n', '<Leader>ca', vim.lsp.buf.code_action)
    buf_set_keymap('n', 'K', vim.lsp.buf.hover)
    buf_set_keymap('n', '<Leader>cn', vim.lsp.buf.rename)
    buf_set_keymap('n', '[e', vim.diagnostic.goto_prev)
    buf_set_keymap('n', ']e', vim.diagnostic.goto_next)
    buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help)
    buf_set_keymap('n', '<Leader>e', vim.diagnostic.open_float)
    buf_set_keymap('n', '<space>q', vim.diagnostic.setloclist)
    buf_set_keymap('n', '<Leader>F', vim.lsp.buf.formatting)

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require'completion'.on_attach()
    require'lsp_signature'.on_attach({
        bind = true,
        -- floating_window = false,
        -- hint_enable = true,
        hint_prefix = '',
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local servers = require'custom'.lsp_servers

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup{
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = custom_lsp_attach,
    }
end

require'custom'.custom_lsp_setup()

-- require'lspconfig'.jdtls.setup{
--     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     on_attach = custom_lsp_attach,
--     -- root_dir = vim.fn.getcwd()
--     -- {
--     --     {
--     --       '.project',
--     --       'build.xml', -- Ant
--     --       'pom.xml', -- Maven
--     --       'settings.gradle', -- Gradle
--     --       'settings.gradle.kts', -- Gradle
--     --     },
--     --     -- Multi-module projects
--     --     { 'build.gradle', 'build.gradle.kts' },
--     --   } or 
-- }

