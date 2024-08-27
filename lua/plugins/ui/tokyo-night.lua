return {
    'folke/tokyonight.nvim',
     config = function(_, opts)
         require 'tokyonight'.setup({
             style = 'storm',
             styles = {
                 comments = { italic = false },
                 keywords = { italic = false },
             },
         })
         vim.cmd [[colorscheme tokyonight]]
--         if Get_color_mode() == 'dark' then
--             vim.o.background = 'dark'
--             vim.cmd [[colorscheme tokyonight]]
--         else
--             vim.o.background = 'light'
--             vim.cmd [[colorscheme tokyonight]]
--         end
    end
}
