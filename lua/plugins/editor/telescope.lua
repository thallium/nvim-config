return {
    'nvim-telescope/telescope.nvim',
    dependencies = {'plenary.nvim', 'telescope-fzy-native.nvim'},
    config = function()
        require('telescope').setup({
            extensions = {
                aerial = {
                    -- Set the width of the first two columns (the second
                    -- is relevant only when show_columns is set to 'both')
                    col1_width = 4,
                    -- How to format the symbols
                    -- format_symbol = function(symbol_path, filetype)
                    --     if filetype == "json" or filetype == "yaml" then
                    --         return table.concat(symbol_path, ".")
                    --     else
                    --         return symbol_path[#symbol_path]
                    --     end
                    -- end,
                    -- Available modes: symbols, lines, both
                    show_columns = "symbols",
                },
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                }
            }
        })
        require("telescope").load_extension("aerial")
        require('telescope').load_extension('fzy_native')
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
            {'<Leader>fs', require"telescope.builtin".find_files},
            -- {'<Leader>fb', require"telescope.builtin".buffers},
            {'<C-p>', require"telescope.builtin".find_files},
            -- {'gd', require"telescope.builtin".lsp_definitions},
            -- {'gi', require"telescope.builtin".lsp_implementations},
            -- {'gr', require"telescope.builtin".lsp_references},
            {'<Leader>ft', find_acm_template},
            {'<Leader>fd', find_dot_files},
            -- {'<Leader>s', require'telescope'.extensions.aerial.aerial},
            -- {'<Leader>fe', diagnostics}
        }
    end
}
