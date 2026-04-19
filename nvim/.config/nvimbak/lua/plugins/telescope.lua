local M =     {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    }


local builtin = require("telescope.builtin")

vim.keymap.set('n','<C-p>',builtin.find_files,{})
vim.keymap.set('n','<leader>fg',builtin.live_grep,{})

return M
