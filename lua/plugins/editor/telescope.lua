return {
    'nvim-telescope/telescope.nvim',
    dependencies = {'plenary.nvim'},
    config = function(_, opts)
        require("telescope").load_extension("aerial")
        require('telescope').setup(opts)
    end,
    keys = function()
        local layout_bottom = {
            layout_strategy = 'bottom_pane',
            layout_config = {
                height = 0.3,
                preview_width = 0.4
            }
        }

        function find_acm_template()
            require('telescope.builtin').find_files {
                prompt_title = "Templates",
                search_dirs = { "~/github/algo/master/src" },
                cwd = "~/github/algo/master/src"
            }
        end

        function find_dot_files()
            require('telescope.builtin').find_files {
                prompt_title = "Dot Files",
                search_dirs={"~/.config"}
            }
        end

        function diagnostics()
            require"telescope.builtin".diagnostics(layout_bottom)
        end
        return {
            {'<Leader>ff', require"telescope.builtin".find_files},
            {'<Leader>fb', require"telescope.builtin".buffers},
            {'<C-p>', require"telescope.builtin".find_files},
            {'gd', require"telescope.builtin".lsp_definitions},
            {'gi', require"telescope.builtin".lsp_implementations},
            {'gr', require"telescope.builtin".lsp_references},
            {'gb', require"telescope.builtin".buffers},
            {'<Leader>ft', find_acm_template},
            {'<Leader>fd', find_dot_files},
            {'<Leader>s', require'telescope'.extensions.aerial.aerial},
            {'<Leader>e', diagnostics}
        }
    end
}
