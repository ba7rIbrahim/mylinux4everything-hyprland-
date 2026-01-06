return {
  "pocco81/auto-save.nvim",
  opts = {
    enabled = false,
    trigger_events = { "InsertLeave", "TextChanged" },
    execution_message = {
      message = function()
        return ("💾 Saved at " .. vim.fn.strftime("%H:%M:%S"))
      end,
      cleaning_interval = 1000,
    },
    callbacks = {
      before_saving = function()
        vim.g.autoformat = false
      end,
      after_saving = function()
        vim.g.autoformat = false
      end,
    },
    condition = function(buf)
      if vim.g.auto_save_enabled == false then
        return false
      end

      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      if utils.not_in(fn.getbufvar(buf, "&filetype"), { "neo-tree", "TelescopePrompt", "harpoon", "lazy" }) then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    debounce_delay = 135,
  },
}
