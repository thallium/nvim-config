return {
  "neovim/nvim-lspconfig",
  -- event = "VeryLazy",
  -- dependencies = {
    --   "mason.nvim",
    --   { "williamboman/mason-lspconfig.nvim", config = function() end },
    -- },
    opts = function()
      return {
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        diagnostics = {
          update_in_insert = true,
        },
        servers = {
          clangd = {
            mason = false,
            cmd = {"clangd", "--header-insertion=never"}
          },
          plx = {
            mason = false,
          },
        },
        setup = {}
      }
    end,

    config = function(_, opts)
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local function buf_set_keymap(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true })
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

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end
  }
