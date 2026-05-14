return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },  -- lazy load
    build = ":TSUpdate",  -- update parsers automatically
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- optional textobjects
    },
    config = function()
      local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end
      ts_configs.setup({
        ensure_installed = { "lua", "python", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}