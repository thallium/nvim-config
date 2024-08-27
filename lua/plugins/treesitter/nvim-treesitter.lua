return {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = {"lua", "java", "c", "cpp", "rust", "bash", "css", "latex", "html", "toml", "yaml", "markdown", "help" },
        highlight = {
            enable = true,              -- false will disable the whole extension
            disable = { "javascript" }
        },
        textobjects = {
            select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            },
            -- swap = {
            --   enable = true,
            --   swap_next = {
            --     ["<leader>a"] = "@parameter.inner",
            --   },
            --   swap_previous = {
            --     ["<leader>A"] = "@parameter.inner",
            --   },
            -- },
        },
    }
}
