return {
  {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      local ok, galaxyline = pcall(require, "galaxyline")
      if not ok then
        return
      end
      -- Avoid configuring custom sections here since colors may be defined elsewhere.
      -- If you want to add custom sections, do so in your main config where colors are available.
    end,
  },
}