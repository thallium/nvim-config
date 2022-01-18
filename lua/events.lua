vim.cmd([[
    augroup common
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}
    augroup END
]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost key_maps.lua source <afile>
  augroup end
]])
