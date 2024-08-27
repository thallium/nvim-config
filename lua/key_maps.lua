local M = {}

M.map = vim.keymap.set

local map = M.map

-- Remove spaces at the end of lines
map('n', '<Space>cw', '<cmd>keeppatterns %s/\\s\\+$//e<CR>', {silent=true})

-- alt-; to exit insert mode in terminal
map('t', '<A-;>', '<C-\\><C-n>')

-- switch window
map({'t', 'i'}, '<A-h>', '<C-\\><C-N><C-w>h')
map({'t', 'i'}, '<A-j>', '<C-\\><C-N><C-w>j')
map({'t', 'i'}, '<A-k>', '<C-\\><C-N><C-w>k')
map({'t', 'i'}, '<A-l>', '<C-\\><C-N><C-w>l')
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')

-- Paste without overiding your register
map('x', '<leader>p', '"_dP')

-- Yank to system clipboard
map({'n', 'v'}, '<leader>y', '"+y')

--Hop
map('', 's', '<cmd>HopChar2<CR>')

-- buffer
map({'n', 'i'}, '<A-w>', '<cmd>bdelete<CR>', {silent=true})
map('n', '<A-q>', '<cmd>bdelete!<CR>', {silent=true})

-- settings for resize splitted window
map('n', '<C-w>[', '<cmd>vertical resize -3<CR>')
map('n', '<C-w>]', '<cmd>vertical resize +3<CR>')

-- Ctrl-a to copy all
-- map('n',  '<C-A>', '<cmd>%y+<CR>')
map('n',  '<C-A>', require('utils').expand_cpp)

map('i', '<C-l>', function()
    if vim.o.spell then -- correct spell error if spell check is on
        vim.api.nvim_input('<c-g>u<Esc>[s1z=`]a<c-g>u')
    else -- otherwise do noh
        vim.cmd('noh')
    end
end, { silent = true })

-- compile/run/test
map('n', '<Leader>r', function() require"utils".compileAndRun(false) end)
map('n', '<Leader>t', function() require"utils".compileAndRun(true) end)

-- dap
map('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map('n', '<leader>ds', "<cmd>lua require'dap'.repl.open()<cr>")
map('n', '<C-c>', "<cmd>lua require'dap'.continue()<cr>")
map('n', '<C-s>', "<cmd>lua require'dap'.step_into()<cr>")

-- LuaSnip

return M
