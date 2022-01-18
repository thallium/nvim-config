local M = {}
local noremap = function(mode, lhs, rhs, ...)
    local opts = {noremap=true}
    if arg then
        for k, v in pairs(arg[1]) do
            opts[k]=v
        end
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end
local map = function(mode, lhs, rhs, ...)
    local opts = {}
    if arg then
        for k, v in pairs(arg[1]) do
            opts[k]=v
        end
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Remove spaces at the end of lines
noremap('n', '<Space>cw', '<cmd>keeppatterns %s/\\s\\+$//e<CR>', {silent=true})

-- alt-; to exit insert mode in terminal
noremap('t', '<A-;>', '<C-\\><C-n>')

-- switch window
noremap('t', '<A-h>', '<C-\\><C-N><C-w>h')
noremap('t', '<A-j>', '<C-\\><C-N><C-w>j')
noremap('t', '<A-k>', '<C-\\><C-N><C-w>k')
noremap('t', '<A-l>', '<C-\\><C-N><C-w>l')
noremap('i', '<A-h>', '<C-\\><C-N><C-w>h')
noremap('i', '<A-j>', '<C-\\><C-N><C-w>j')
noremap('i', '<A-k>', '<C-\\><C-N><C-w>k')
noremap('i', '<A-l>', '<C-\\><C-N><C-w>l')
noremap('n', '<A-h>', '<C-w>h')
noremap('n', '<A-j>', '<C-w>j')
noremap('n', '<A-k>', '<C-w>k')
noremap('n', '<A-l>', '<C-w>l')

-- nnn
noremap('n', '<Leader>n', '<cmd>NnnPicker<CR>')

--Hop
noremap('', 's', '<cmd>HopChar2<CR>')

-- barbar
noremap('n', '<Leader>bc', '<cmd>BufferCloseAllButCurrent<CR>', {silent=true})
noremap('n', '<A-w>', '<cmd>BufferClose<CR>', {silent=true})
noremap('i', '<A-w>', '<cmd>BufferClose<CR>', {silent=true})
noremap('n', '<A-q>', '<cmd>BufferClose!<CR>', {silent=true})
noremap('n', '<A-,>', '<cmd>BufferPrevious<CR>', {silent=true})
noremap('n', '<A-.>', '<cmd>BufferNext<CR>', {silent=true})
noremap('i', '<A-,>', '<cmd>BufferPrevious<CR>', {silent=true})
noremap('i', '<A-.>', '<cmd>BufferNext<CR>', {silent=true})
noremap('n', 'gb', '<cmd>BufferPick<CR>', {silent=true})

-- settings for resize splitted window
noremap('n', '<C-w>[', '<cmd>vertical resize -3<CR>')
noremap('n', '<C-w>]', '<cmd>vertical resize +3<CR>')

-- Ctrl-a to copy all
noremap('n',  '<C-A>', '<cmd>%y+<CR>')

-- correct spelling on the fly
noremap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-- telescope
local function layout_bottom()
    return [[{
        layout_strategy = 'bottom_pane',
    }]]
end
noremap('n', '<Leader>ff', '<cmd>lua require"telescope.builtin".find_files()<cr>');
noremap('n', '<Leader>ft', '<cmd>lua require"my_telescope".find_acm_template()<CR>');
noremap('n', '<Leader>fd', '<cmd>lua require"my_telescope".find_dot_files()<CR>');
noremap('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>');
noremap('n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>');
noremap('n', 'gi', '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>');
noremap('n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references()<CR>');
noremap('n', '<Leader>ca', '<cmd>lua require"my_telescope".lsp_code_actions()<CR>');
noremap('n', '<Leader>s', '<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>');
noremap('n', '<Leader>e', '<cmd>lua require"my_telescope".diagnostics()<CR>');

-- termtogle
noremap('n', '<A-p>', '<cmd>ToggleTerm<cr>')
noremap('i', '<A-p>', '<esc><cmd>ToggleTerm<cr>')
noremap('t', '<A-p>', '<cmd>ToggleTerm<cr>')

-- compile/run/test
noremap('n', '<F4>', '<cmd>lua require"my_functions".compile(false)<cr>')
noremap('n', '<Leader>r', '<cmd>lua require"my_functions".compileAndRun(false)<cr>')
noremap('n', '<Leader>t', '<cmd>lua require"my_functions".compileAndRun(true)<cr>')


-- Sandwich
-- add
map('n', '<C-s>a', '<Plug>(operator-sandwich-add)', {silent=true})
map('x', '<C-s>a', '<Plug>(operator-sandwich-add)', {silent=true})
map('o', '<C-s>a', '<Plug>(operator-sandwich-g@)', {silent=true})

-- delete
map('x', '<C-s>d', '<Plug>(operator-sandwich-delete)', {silent=true})
map('n', '<C-s>d', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', {silent=true})
map('n', '<C-s>db', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)', {silent=true})

-- replace
map('x', '<c-s>r', '<Plug>(operator-sandwich-replace)', {silent=true})
map('n', '<C-s>r', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', {silent=true})
map('n', '<C-s>rb', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)', {silent=true})

-- dap
map('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map('n', '<leader>ds', "<cmd>lua require'dap'.repl.open()<cr>")
map('n', '<C-c>', "<cmd>lua require'dap'.continue()<cr>")
map('n', '<C-n>', "<cmd>lua require'dap'.step_over()<cr>")
map('n', '<C-s>', "<cmd>lua require'dap'.step_into()<cr>")
