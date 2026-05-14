-- lua/plugins/lazy/nvim-tree.lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    cmd = "NvimTreeToggle",  -- lazy load on command
    keys = {                  -- lazy load on keymaps
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    config = function()
      require("nvim-tree").setup({
        -- basic options
        disable_netrw = true,
        hijack_netrw = true,
        auto_reload_on_write = true,
        hijack_cursor = true,
        update_cwd = true,

        -- view
        view = {
          width = 30,
          side = "left",
          preserve_window_proportions = true,
          number = false,
          relativenumber = false,
        },

        -- git
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },

        -- actions
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
          },
        },

        -- renderer
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
      })
    end,
  },
}