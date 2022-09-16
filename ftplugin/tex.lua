vim.opt.spell=true
vim.opt.spelllang="en_us,cjk"
local noremap = require'key_maps'.noremap;
noremap('n', '<Leader>e', '<cmd>VimtexErrors<CR><C-W>k')
