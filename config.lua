-- Override Cosmic configuration options

local config = {
  -- See :h nvim_open_win for possible border options
  border = 'rounded',

  -- LSP settings
  lsp = {
    -- Enable/disable inlay hints
    inlay_hint = false,
    -- Time in MS before format timeout
    format_timeout = 1000,
    -- Enabled servers are installed through Mason automatically
    -- Enable non-default servers or override lspconfig/after/lsp server options
    servers = {
      -- Enable rust_analyzer with its lspconfig and after/lsp defaults
      rust_analyzer = true,

      -- Override vtsls defaults from lspconfig and after/lsp
      vtsls = {
        -- Disable only automatic formatting on save for this server
        -- format_on_save = false,
        -- Disable all formatting from this server, including manual formatting
        -- formatting = false,
        flags = {
          debounce_text_changes = 150,
        },
        on_attach = function(client, bufnr) end,
        settings = {},
      },
    },
  },

  -- See :h vim.diagnostic.config for all diagnostic configuration options
  diagnostics = {},

  -- Plugin management (lazy.nvim)
  plugins = {

    { 'mileszs/ack.vim', lazy = false },
    { 'arithran/vim-delete-hidden-buffers', cmd = 'DeleteHiddenBuffers' },
    { 'https://codeberg.org/andyg/leap.nvim.git', lazy = false },

    -- Disable a built-in plugin
    {
      'rmagatti/auto-session',
      enabled = false,
    },
    {
      'folke/noice.nvim',
      enabled = false,
    },

    -- Override a built-in plugin
    {
      'folke/snacks.nvim',
      opts = {
        -- disable slow scrolling (noticeable with `zz`, etc.)
        scroll = { enabled = false },
      },
    },
    {
      'saghen/blink.cmp',
      opts = function(_, opts)
        opts.keymap = opts.keymap or {}
        opts.completion = opts.completion or {}
        opts.completion.menu = opts.completion.menu or {}
        -- Text autocomplete...
        -- Do not automatically show text completion menu
        opts.completion.menu.auto_show = false
        -- Enter should always be a newline
        opts.keymap['<CR>'] = { 'fallback' }
        -- Manually open completion menu, then move through suggestions
        opts.keymap['<C-n>'] = { 'show', 'select_next', 'fallback' }
        opts.keymap['<C-p>'] = { 'show', 'select_prev', 'fallback' }
        opts.keymap['<Tab>'] = { 'accept', 'fallback' }

        return opts
      end,
    },
    {
      'stevearc/conform.nvim',
      opts = function(_, opts)
        local original = opts.format_on_save

        -- Increase max timeout for LSP format_on_save operation; default 500ms
        opts.format_on_save = function(bufnr)
          local result = original

          if type(original) == 'function' then
            result = original(bufnr)
          end

          if result == nil then
            return nil
          end

          if type(result) ~= 'table' then
            return result
          end

          result = vim.deepcopy(result)
          result.timeout_ms = 3000
          return result
        end

        return opts
      end,
    },

    -- Add a plugin with dependencies
    --  fancy tab management...
    -- {
    --   'romgrk/barbar.nvim',
    --   dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- },
  },
}

return config
