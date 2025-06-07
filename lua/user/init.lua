require('user/mappings')

-- Disable flashing in MacOS Iterm2, visualbell is causing this issue
vim.api.nvim_create_autocmd("GUIEnter", {
  callback = function()
    vim.opt.visualbell = true
    vim.opt.t_vb = ""
  end,
})

-- Load custom snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/user/snippets" } })


