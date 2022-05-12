local M = {}
local fmt=string.format
local tt=require'toggleterm'
local termexec=tt.exec_command
function M.compile(toDebug)
    vim.cmd('write')
    -- vim.call('TerminalSend', 'cd ' .. vim.fn.expand('%:p:h') .. '\r')
    local ft = vim.o.filetype
    local fnWEx = vim.fn.expand('%') -- filename with extension
    local fnWOEx = vim.fn.expand('%<')
    if ft == 'cpp' or ft == 'c' or ft == 'cc' then
        local debug_cmd="g++-11 -g -O0 -D_GLIBCXX_DEBUG_PEDANTIC -D_GLIBCXX_DEBUG -DLOCAL -std=c++17"
        if toDebug then
            vim.cmd(fmt('! %s %s -o %s', debug_cmd, fnWEx, fnWOEx))
            -- vim.cmd('!' .. debug_cmd .. fnWEx .. ' -o ' .. fnWOEx)
        else
            vim.cmd('!gcomp ' .. fnWOEx)
        end
    elseif ft == 'tex' then
        vim.cmd('VimtexCompile')
    end
    require'toggleterm.terminal'.get(1):is_open() -- move focus to terminal
end

M.compileAndRun = function (toTest)
    vim.cmd('write')
    local dir = vim.fn.expand('%:p:h')
    local ft = vim.o.filetype
    local fnWEx = vim.fn.expand('%') -- filename with extension
    local fnWOEx = vim.fn.expand('%<') -- filename without extension
    termexec(fmt('cmd="cd %s"', dir))
    if ft == 'cpp' or ft == 'c' or ft == 'cc' then
        if toTest then
            termexec(fmt('cmd="ccomp %s && cp_test %s"', fnWOEx, fnWOEx), 1)
        else
            termexec(fmt('cmd="ccomp %s && ./%s"', fnWOEx, fnWOEx), 1)
        end
    elseif ft == 'python' then
        termexec(fmt('cmd="python3 %s" dir=%s', fnWEx, dir), 1)
    end
    require'toggleterm.terminal'.get(1):is_open() -- move focus to terminal
end

return M
