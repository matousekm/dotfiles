
local vim = vim
local opt = vim.opt

vim.cmd([[set mouse=]])
opt.winborder = "rounded"
opt.hlsearch = false
opt.tabstop = 2
opt.cursorcolumn = false
opt.ignorecase = true
opt.shiftwidth = 2
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.undofile = true
opt.signcolumn = "yes"

-- Plugins
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})

require "mason".setup()
require "mini.pick".setup({
	hidden = false })
require "oil".setup()

require "which-key".setup({
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
}
)

require("luasnip").setup({ enable_autosnippets = true })

-- KEYMAPS
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- scroll keymaps
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center after scroll down" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center after scroll up" })

keymap.set('n', '<leader>ff', ":Pick files <CR>", { desc = "Pick files" })
keymap.set('n', '<leader>fg', ":Pick files tool='git'<CR>", { desc = "Pick files that are in git" })
keymap.set('n', '<leader>fw', ":Pick grep_live<CR>", { desc = "Pick files by the patter" })
keymap.set('n', '<leader>h', ":Pick help<CR>")
keymap.set('n', '<leader>e', ":Oil<CR>")
keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format buffer" })
keymap.set('n', 'gd', '<C-]>', { desc = "Go to definition" })

vim.lsp.enable({ "lua_ls", "rust_analyzer", "html", "emmet_language_server", "prettier", "typescript-language-server", "eslint_d", "clangd" })

vim.diagnostic.config({ virtual_text = true, severity_sort = true, })

-- colors
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
