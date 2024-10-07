-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")
-- Plug("davidosomething/vim-colors-meh")
-- Plug("ntk148v/komau.vim")
Plug("aditya-azad/candle-grey")
vim.call("plug#end")

-- vim.cmd("colorscheme meh")
vim.cmd("colorscheme candle-grey")
