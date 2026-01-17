-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Better colors
vim.opt.termguicolors = true

-- Disable swaps
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Disable mouse
vim.opt.mouse = ""

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

-- Use real tabs
vim.opt.expandtab = false

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- SCROLLING
vim.opt.scrolloff = 10

-- Cursor Line
vim.opt.cursorline = true
vim.opt.guicursor = table.concat({
  "n-v-c:block",
  "i-ci:block-blinkwait175-blinkon150-blinkoff175",
  "r-cr:hor20",
  "o:hor50",
  "sm:block-blinkwait175-blinkon150-blinkoff175",
}, ",")

-- Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- For Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Always show the sign column to avoid text shifting
vim.opt.signcolumn = "yes"

-- Faster updates for LSP, CursorHold, etc.
vim.opt.updatetime = 300
