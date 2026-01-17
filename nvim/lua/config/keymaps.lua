-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in visual mode
vim.keymap.set("v", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Center current line when scolling with Ctrl + D or Ctrl + U
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Center the cursor when navigating search results
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Split window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
vim.keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
vim.keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
vim.keymap.set("n", "<leader>s>", "<C-w>>10") -- make split windows width bigger
vim.keymap.set("n", "<leader>s<", "<C-w><10") -- make split windows width smaller

-- Restart Java Workspace
vim.keymap.set("n", "<leader>rj", function()
  local ok, jdtls = pcall(require, "jdtls")
  if not ok then
    vim.notify("JDTLS não disponível neste buffer", vim.log.levels.WARN)
    return
  end

  local home = vim.env.HOME
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = home .. "/jdtls-workspace/" .. project_name

  if vim.fn.isdirectory(workspace_dir) == 1 then
    vim.notify("Removendo workspace JDTLS: " .. workspace_dir, vim.log.levels.WARN)
    vim.fn.delete(workspace_dir, "rf")
  else
    vim.notify("Workspace JDTLS não encontrado, pulando remoção", vim.log.levels.INFO)
  end

  vim.cmd("wall")
  vim.defer_fn(function()
    pcall(function()
      jdtls.update_project_config()
    end)
    vim.cmd("JdtRestart")
    vim.notify("JDTLS reiniciado com workspace limpo", vim.log.levels.INFO)
  end, 500)
end, { noremap = true, silent = true, desc = "Hard reset JDTLS (workspace clean)" })

-- Restart LSPs
vim.keymap.set("n", "<leader>rl", function()
  vim.cmd("LspRestart")
  vim.notify("Reloading LSPs...", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Restart all LSP servers" })

-- Recent Projects
vim.keymap.set("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects()
end, { noremap = true, silent = true, desc = "Telescope: Projects" })
