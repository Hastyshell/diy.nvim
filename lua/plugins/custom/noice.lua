return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  opts = {
    -- add any options here
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == 'lazy' then
      vim.cmd [[messages clear]]
    end
    require('notify').setup {
      merge_duplicates = true,
      timeout = 2000,
      stages = 'static',
    }
    require('noice').setup(opts)
  end,
  keys = {
    {
      '<leader>nl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>nh',
      function()
        require('noice').cmd 'history'
      end,
      desc = 'Noice History',
    },
    {
      '<leader>na',
      function()
        require('noice').cmd 'all'
      end,
      desc = 'Noice All',
    },
    {
      '<leader>nd',
      function()
        require('noice').cmd 'dismiss'
      end,
      desc = 'Dismiss All',
    },
    {
      '<leader>ns',
      function()
        require('noice').cmd 'pick'
      end,
      desc = 'Noice Picker (Telescope/FzfLua)',
    },
  },
}
