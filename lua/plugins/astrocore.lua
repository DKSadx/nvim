-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      user_commands = {
        {
          desc = "Disable automatic commenting for new lines",
          event = "FileType",
          pattern = "*",
          callback = function()
            vim.opt.formatoptions:remove{ "c", "r", "o" }
          end,
        },
        {
          desc = "Disable bell sound on Mac",
          event = "GUIEnter",
          pattern = "*",
          callback = function()
            vim.opt.vb = ""
            vim.opt.t_vb = ""
          end,
        },
        {
          desc = "Set tab width to 4 for Go files",
          event = "FileType",
          pattern = "go",
          callback = function()
            vim.opt_local.shiftwidth = 4
            vim.opt_local.tabstop = 4
          end,
        },
        {
          desc = "Trigger `autoread` when files change on disk",
          event = { "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
          pattern = "*",
          callback = function()
            if vim.fn.mode():match("[^cr?!t]") and vim.fn.getcmdwintype() == "" then
              vim.cmd("checktime")
            end
          end,
        },
        {
          desc = "Notify when a file changes on disk",
          event = "FileChangedShellPost",
          pattern = "*",
          callback = function()
            vim.cmd([[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])
          end,
        },
        {
          desc = "Jump to the last position when reopening a file",
          event = "BufReadPost",
          pattern = "*",
          callback = function()
            local last_pos = vim.fn.line([["'\""]])
            if last_pos > 0 and last_pos <= vim.fn.line("$") then
              vim.cmd("normal! g`\"")
            end
          end,
        },
        {
          desc = "Set YAML syntax for *.sls files",
          event = { "BufNewFile", "BufRead" },
          pattern = "*.sls",
          callback = function()
            vim.opt.filetype = "yaml"
          end,
        },
      },
    },
    -- All features https://github.com/AstroNvim/astrocore/blob/0fcaac66d115948605c14eaf45a41d3923eaafeb/lua/astrocore/config.lua#L80
    -- Configure core features of AstroNvim
    features = {
      autopairs = false, -- enable or disable autopairs on start
      cmp = true, -- enable or disable cmp on start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = off)
      highlighturl = true, -- enable or disable highlighting of urls on start
      -- table for defining the size of the max file for all features, above these limits we disable features like treesitter.
      large_buf = { size = 1024 * 100, lines = 10000 },
      notifications = true, -- enable or disable notifications on start
      autoformat = true
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,
        ignorecase = true,
        smartcase = true,
        clipboard = "",
        scrolloff = 8,
        timeoutlen = 150,
        ttimeoutlen = 0,
        updatetime = 100,
        undofile = true,
        incsearch = true,
        swapfile = false,
        expandtab = true,
        tabstop = 2,
        shiftwidth = 2,
        softtabstop = 2,
        hidden = true,
      },
      g = {
        mapleader = " ",
        ui_notifications_enabled = true,
        heirline_bufferline = false,
        vim_markdown_folding_disabled = 1,
        fzf_layout = { window = { width = 0.9, height = 0.9 } },
        fzf_preview_window = { "right:50%" },
        fzf_action = {
          ["ctrl-t"] = "tab split",
          ["ctrl-h"] = "split",
          ["ctrl-v"] = "vsplit",
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
