local nvim_lsp = require('lspconfig')
local noremap = require('key_maps').noremap

-- update diagnostics in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- underline=false,
        update_in_insert = true,
    }
)

local custom_lsp_attach = function(client, bufnr)
    -- See `:help nvim_buf_set_keymap()` for more information

    local function buf_set_keymap(mode, lhs, rhs)
        noremap(mode, lhs, rhs, { buffer = bufnr, slient = true })
    end

    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- buf_set_keymap('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_set_keymap('n', '<Leader>ca', vim.lsp.buf.code_action)
    -- buf_set_keymap('n', '<space>s', vim.lsp.buf.document_symbol)
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

local servers = { "clangd", "vimls", "gopls", "bashls", "pyright", "texlab", "rust_analyzer"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup{
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = custom_lsp_attach,
    }
end

local sumneko_root_path = "/Users/tuogengchen/github/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
}
