return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
    config = function ()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', ":lua require('telescope.builtin').find_files({ hidden = true })<CR>", { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind in [G]it tracked files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind opened [B]uffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp / man pages' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecently opened files' })
        vim.keymap.set('n', '<leader>fw', function ()
            builtin.grep_string({ search = vim.fn.input("Grep > ")})
        end, { desc = '[F]ind current [W]ord' })

        require('telescope').load_extension('fzf')
    end
}
