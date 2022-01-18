require('telescope').setup {
    defaults = {
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        mappings = {
            i = {
                ['<c-j>'] = 'move_selection_next',
                ['<c-k>'] = 'move_selection_previous',
            }
        }
    },
    extensions = {
        fzy_native = {
            override = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }
}
require('telescope').load_extension('fzy_native')

local M={}

function M.find_acm_template()
    require('telescope.builtin').find_files {
        prompt_title = "Templates",
        search_dirs = { "~/github/acm-algorithm-template/code" },
        cwd = "~/github/acm-algorithm-template/code"
    }
end

function M.find_dot_files()
    require('telescope.builtin').find_files {
        prompt_title = "Dot Files",
        search_dirs={"~/.config"}
    }
end

local layout_cursor = {
    layout_strategy = 'cursor',
    layout_config = {
        height=10,
        width=80
    }
}

local layout_bottom = {
    layout_strategy = 'bottom_pane',
    layout_config = {
        height = 0.3,
        preview_width = 0.4
    }
}
function M.lsp_code_actions()
    require"telescope.builtin".lsp_code_actions(layout_cursor)
end
function M.diagnostics()
    require"telescope.builtin".diagnostics(layout_bottom)
end
return M
