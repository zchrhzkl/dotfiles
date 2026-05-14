return {
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false , opts = { colorscheme = "catppuccin-macchiato" }},
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- { "folke/which-key.nvim",
  --   config = function()
  --     require("which-key").setup {
  --       window = {
  --         -- border = "none",
  --         position = "bottom",
  --         margin = { 0, 0, 0, 0 },
  --         padding = { 1, 2, 1, 2 },
  --         winblend = 0,
  --       },
  --       layout = {
  --         align = "center",
  --       },
  --     }
  --   end
  -- },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1000,
  --   config = true,
  -- },
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,   -- load early
  --   lazy = false,      -- don’t lazy load at startup
  --   opts = {
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = true },
  --     explorer = { enabled = true },
  --     indent = { enabled = true },
  --     input = { enabled = true },
  --     notifier = { enabled = true },
  --     picker = { enabled = true },
  --     quickfile = { enabled = true },
  --     scroll = { enabled = true },
  --     statuscolumn = { enabled = true },
  --     words = { enabled = true },
  --   },
  -- }
}
