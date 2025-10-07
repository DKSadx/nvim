-- Key mappings for AstroVim
local keymap = vim.keymap.set

-- # Show line separator characters as $
-- vim.opt.list = true
-- vim.opt.listchars = { eol = '$' }

-- # Don't automatically add line separator (new line, '\n') at the end of the file so it aligns with other non-POSIX editors 
-- # Ref: https://stackoverflow.com/questions/15639511/vim-show-newline-at-the-end-of-file
vim.opt.endofline = false
vim.opt.fixendofline = false
vim.opt.binary = true -- Treat the file as binary (required for above)

-- Normal mode mappings
keymap('n', '<leader>bb', '<cmd>tabnew<CR>', { desc = "New tab" })
keymap('n', '<leader>bc', '<cmd>BufferLinePickClose<CR>', { desc = "Pick to close" })
keymap('n', '<leader>bj', '<cmd>BufferLinePick<CR>', { desc = "Pick to jump" })
keymap('n', '<leader>bt', '<cmd>BufferLineSortByTabs<CR>', { desc = "Sort by tabs" })
keymap('n', 'Q', ':q!<CR>', { desc = "Force quit" })
keymap('n', 'Y', '"+y', { desc = "Yank to system clipboard" })
keymap('n', 'U', ':redo<CR>', { desc = "Redo" })
keymap('n', ';', ':Telescope find_files<CR>', { desc = "Search files with Telescope" })
keymap('n', '<C-d>', '30j', { desc = "Scroll down by 30 lines" })
keymap('n', '<C-u>', '30k', { desc = "Scroll up by 30 lines" })
keymap('n', '<C-t>', ':FloatermNew --height=0.8 --width=0.8<CR>', { desc = "Open floating terminal" })
keymap('n', '<C-o>', ':Neotree toggle<CR>', { desc = "Toggle Neotree" })
-- <C-_> is actually <C-/>, this will comment the current line
keymap('n', '<C-_>', function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
keymap('n', '<C-/>', function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
keymap('n', '<C-s>', '1z=', { desc = "Correct mistyped word" })
keymap('n', '<C-g>', ':FloatermNew --height=1.0 --width=1.0 lazygit<CR>', { desc = "Open Lazygit" })
keymap('n', '<C-x>', ':bd<CR>', { desc = "Close buffer" })
keymap('n', '<C-j>', ':bprev<CR>', { desc = "Previous buffer" })
keymap('n', '<C-k>', ':bnext<CR>', { desc = "Next buffer" })
keymap('n', '<C-h>', '<C-w>h', { desc = "Go to left widnow" })
keymap('n', '<C-l>', '<C-w>l', { desc = "Go to right widnow" })
keymap('n', '<C-e>', ':tabedit %<CR>', { desc = "Open file in new tab" })
keymap('n', '<C-f>', ':RgRaw -i ', { desc = "Search with fzf" })

-- Visual mode mappings
keymap('v', 'Y', '"+y', { desc = "Yank to system clipboard" })
-- <C-_> is actually <C-/>, this will comment the selected block
keymap('v', '<C-_>', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = "Toggle comment" })
keymap('v', '<C-/>', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = "Toggle comment" })
keymap('v', '<C-d>', '30j', { desc = "Scroll down by 30 lines" })
keymap('v', '<C-u>', '30k', { desc = "Scroll up by 30 lines" })
keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Replace selected text" })
keymap('v', 'p', '"_dP', { desc = "Paste without overwriting clipboard" })

-- Command mode mappings
keymap('c', 'W', 'w', { desc = "Fix mistyped :W" })
keymap('c', 'Q', 'q', { desc = "Fix mistyped :Q" })

-- Terminal mode mappings
keymap('t', '<esc><esc>', '<C-\\><C-N>', { desc = "Exit terminal mode" })
keymap('t', '<C-n>', '<C-\\><C-N>:2ToggleTerm direction=horizontal<CR>', { desc = "Open second terminal" })
