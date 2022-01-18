-- vim.o.background='dark'
-- disable vim distribution plugins{{{
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1

vim.g.loaded_matchit = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1--}}}

vim.g.mapleader=' '
vim.g.maplocalleader=','

vim.opt.secure=true

-- General settins{{{
vim.opt.report=0                 -- Don't report on line changes
vim.opt.visualbell=true               -- Use visual bell instead of beeping
vim.opt.fileformats={'unix','dos','mac'} -- Use Unix as the standard file type
vim.opt.fileencodings={'ucs-bom','utf-8','default','latin1','chinese'}
-- vim.opt.path+=/home/thallium/github/acm-algorithm-template/**,**                 " Directories to search when using gf and friends
vim.opt.virtualedit='block'        -- Position cursor anywhere in visual block
vim.opt.synmaxcol=2500           -- Don't syntax highlight long lines
vim.opt.autochdir=true
vim.opt.updatetime=100
vim.opt.shortmess:append('c')
vim.opt.cmdheight=2
vim.opt.pumheight=12
vim.opt.cursorline=true
vim.opt.formatoptions:append('m')        -- fold line with chinese characters
vim.opt.completeopt={'menuone','noinsert','noselect'}
vim.opt.foldmethod='marker'
vim.opt.mouse='a'

vim.opt.writebackup=false
vim.opt.undofile=true
vim.opt.swapfile=false
-- }}}
-- Tabs and Indents {{{
vim.opt.expandtab=true       -- expand tabs to spaces
vim.opt.cindent=true
vim.opt.tabstop=4       -- The number of spaces a tab is
vim.opt.shiftwidth=4    -- Number of spaces to use in auto(indent)
vim.opt.softtabstop=-1  -- Automatically keeps in sync with shiftwidth
vim.opt.smartindent=true     -- Smart autoindenting on new lines
vim.opt.shiftround=true      -- Round indent to multiple of 'shiftwidth'
-- }}}
-- Searching & replace {{{
vim.opt.ignorecase=true    -- Search ignoring case
vim.opt.smartcase=true     -- Keep case when searching with *
vim.opt.infercase=true     -- Adjust case in insert completion mode

vim.opt.complete={'.','w','b','k'}  -- C-n completion: Scan buffers, windows and dictionary
if vim.fn.executable('rg') then
	vim.opt.grepformat='%f:%l:%m'
	vim.opt.grepprg='rg --vimgrep'
elseif vim.fn.executable('ag') then
	vim.opt.grepformat='%f:%l:%m'
	vim.opt.grepprg='ag --vimgrep'
end
-- }}}

-- Behavior {{{
vim.opt.linebreak=true                   -- Break long lines at 'breakat'
vim.opt.breakat=' 	;:,!?'           -- Long lines break chars
vim.opt.whichwrap:append('<,>,[,],~')    -- Move to following line on certain keys
vim.opt.splitbelow=true
vim.opt.splitright=true       -- Splits open bottom right
-- }}}
-- Editor UI {{{
if vim.fn.has("termguicolors") then
    vim.opt.termguicolors=true       -- Enable true color
end
vim.opt.number=true             -- Show number
vim.opt.showmode=false         -- Don't show mode on bottom
vim.opt.scrolloff=5         -- Keep at least 2 lines above/below
vim.opt.fcs='eob: '           -- hide ~ tila
vim.opt.list=true
vim.opt.listchars={tab='┆ ',nbsp='+',trail='·',extends='→',precedes='←',eol=''}
vim.opt.title=true
vim.opt.titlelen=95 -- Title length.
vim.opt.guifont='FiraCode Nerd Font Mono:h13'

vim.opt.showmatch=true           -- Jump to matching bracket
vim.opt.matchtime=1         -- Tenths of a second to show the matching paren
vim.opt.signcolumn='yes:1'
-- }}}
