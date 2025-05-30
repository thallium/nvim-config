return {
	"luukvbaal/nnn.nvim",
	config = true,
	cmd = { 'NnnExplorer', 'NnnPicker' },
	keys = {
		{'<Leader>n', '<cmd>NnnPicker %:p:h<CR>'},
		{'<Leader>N', '<cmd>NnnPicker<CR>'}
	}
}
