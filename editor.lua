-- COSMIC INSTALLATION REQUIREMENTS -- https://github.com/CosmicNvim/CosmicNvim 💫
-- Get bob nvim version manager to switch between nightly and stable versions.
-- brew install bob uv ripgrep luarocks fd prettierd tree-sitter-cli imagemagick gs
-- bob install v0.12.2 nightly
-- bob use nightly
-- brew uninstall neovim
-- uv tool install --upgrade pynvim
-- npm install -g @mermaid-js/mermaid-cli; mmdc --version
-- Run :checkhealth
-- :lua Snacks.picker.keymaps() shows all key bindings

local g = vim.g
local opt = vim.opt
local map = require('cosmic.utils').set_keymap

-- Keep Cosmic default leader (<space>)
g.mapleader = ' '

-- Basic editor settings
opt.scrolloff = 5
opt.hlsearch = false      -- turn off highlighting of search results, which is too eager on some commands
opt.backspace = { 'indent', 'eol', 'start' }  -- allow backspacing over everything in insert mode
opt.clipboard:append('unnamedplus') -- use system clipboard by default instead of '+' or '*' registers
opt.completeopt:remove('preview')   -- disable preview window
opt.number = true                   -- show line numbers
opt.relativenumber = false          -- override `opt.rnu = true` from Cosmic core editor config
opt.wrap = true                     -- enable soft line wrap
opt.textwidth = 0                   -- disable hard line wrap automatic insertion of newlines
opt.wrapmargin = 0
opt.history = 50                    -- keep 50 lines of command line history
opt.ruler = true                    -- show the cursor position all the time
opt.showcmd = true                  -- display incomplete commands
opt.incsearch = true                -- do incremental searching
opt.inccommand = 'split'            -- do incremental substitutions with preview split
opt.autoindent = true               -- always set autoindenting on
opt.paste = false                   -- avoid paste mode when copying from external sources
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true

if vim.fn.has('mouse') == 1 then
  opt.mouse = 'a'
end

-- Prevent langmap option from applying to characters that result from a
-- mapping.  If unset (default), this may break plugins.
if vim.fn.has('langmap') == 1 and vim.fn.exists('+langnoremap') == 1 then
  opt.langnoremap = true
end

-- Insert / command ergonomics
map('i', 'jk', '<Esc>', { desc = 'Escape insert mode' })
map('i', '<C-d>', '<Del>', { desc = 'Forward delete char' })
map('n', ';', ':', { desc = 'Command mode shortcut' })
-- shortcut to command-line in normal mode
map('n', '<leader>;', 'q:', { desc = 'Command-line window' })

-- File save mappings
map('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
map('v', '<C-s>', '<C-C>:w<CR>', { desc = 'Save file' })
map('i', '<C-s>', '<C-O>:w<CR>', { desc = 'Save file' })

-- Session / utility mappings
map('n', '<F2>', ':mksession! ~/vim_session<CR>', { desc = 'Write session' })
map('n', '<F3>', ':source ~/vim_session<CR>', { desc = 'Load session' })
map('n', '<F4>', ':let @+=expand("%")<CR>', { desc = 'Copy filename to clipboard' })
map('n', '<F5>', ':DeleteHiddenBuffers<CR>', { desc = 'Delete hidden buffers' })

-- Filetype / editing autocmds
vim.api.nvim_create_autocmd('FileType', {
  -- setting to get `crontab -e` edits working in mac os
  pattern = 'crontab',
  callback = function()
    vim.opt_local.backup = false
    vim.opt_local.writebackup = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- XML / JSON pretty print
map('n', '<leader>mx', ':%!xmllint --format %<CR>dd', { desc = 'Format XML' })
map('n', '<leader>q', ':%!jq .<CR>', { desc = 'Format JSON' })

-- Ack.vim
vim.cmd([[cnoreabbrev Ack Ack!]])
map('n', '<leader>a', ':Ack!<Space>', { desc = 'Ack search' })
g.ack_mappings = {
  ['v'] = '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
  ['gv'] = '<C-W><CR><C-W>L<C-W>p<C-W>J',
}

-- Split/window navigation
map('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to split below' })
map('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to split above' })
map('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to split right' })
map('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to split left' })
map('n', '<C-N>', '<C-W><C-N>', { desc = 'New window' })
map('n', '<leader>s', ':vnew<CR>', { desc = 'Vertical split' })
map('n', '<C-Q>', ':q<CR>', { desc = 'Quit window' })

-- Display-line movement
map('', 'j', 'gj')
map('', 'gj', 'j')
map('', 'k', 'gk')
map('', 'gk', 'k')
map('', '<down>', 'gj')
map('', '<up>', 'gk')

-- Mark jump swap
map('', "'", '`')
map('', '`', "'")

-- Leap settings -- :h leap-mappings
-- https://codeberg.org/andyg/leap.nvim
vim.keymap.set({ 'n' },           ',', '<Plug>(leap-anywhere)')
vim.keymap.set({ 'x', 'o' },      ',', '<Plug>(leap)')
-- Use CTRL-G and CTRL-T to move between '/' & '?' search matches
-- without finishing the search
vim.keymap.set({ 'n', 'o' }, 'g/', function()
  require('leap.remote').action { jumper = '/' }
end)
vim.keymap.set({ 'n', 'o' }, 'g?', function()
  require('leap.remote').action { jumper = '?' }
end)

-- Neovim terminal shortcuts
if vim.fn.has('nvim') == 1 then
  map('t', 'jk', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
  map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

  -- Vertical terminal option
  map('n', '<leader>xv', ':vs term://zsh<CR>', { desc = 'Vertical terminal' })
end

-- Remove Cosmic key binding from terminal mode that breaks command line history scrolling
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    pcall(vim.keymap.del, "t", "<C-n>")
  end,
})

-- Autoread trigger when changing buffers or coming back to vim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  callback = function()
    vim.cmd('silent! !')
  end,
})

-- DiffOrig command
-- You'll need to run :diffoff to get out of this view, and close the extra window.
if vim.fn.exists(':DiffOrig') == 0 then
  vim.api.nvim_create_user_command('DiffOrig', function()
    vim.cmd('vert new | set bt=nofile | r ++edit # | 0d_ | diffthis')
    vim.cmd('wincmd p | diffthis')
  end, {})
end

local diagnostics_enabled = true

-- Toggle LSP diagnostics
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

vim.keymap.set('n', '<leader>ll', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })
  vim.diagnostic.enable(not enabled, { bufnr = bufnr })
end, { desc = 'Toggle diagnostics for buffer' })

-- less noisy by default
return {
  diagnostics = {
    virtual_text = false,
    underline = false,
    signs = false,
  },
}
