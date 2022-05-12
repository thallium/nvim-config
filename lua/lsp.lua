-- local formatter = {
--     lua=true,
-- }

local nvim_lsp = require('lspconfig')

-- update diagnostics in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- underline=false,
        update_in_insert = true,
    }
)

-- Mapping options
local opts = { noremap=true, silent=true }

local custom_lsp_attach = function(client, bufnr)
    -- See `:help nvim_buf_set_keymap()` for more information

    local function buf_set_keymap(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end

    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- buf_set_keymap('n', 'gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- buf_set_keymap('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', '<Leader>cn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>')
    -- if (formatter)
    buf_set_keymap('n', '<Leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>')


    -- Use LSP as the handler for omnifunc.
    -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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

local servers = { "clangd", "vimls", "gopls", "bashls", "pyright", "texlab"}
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
