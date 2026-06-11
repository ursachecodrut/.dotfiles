return {
  "chentoast/marks.nvim",
  event = "BufReadPre",
  opts = {
    cyclic = true,
    refresh_interval = 150,
    mappings = {
      set = "m",
      toggle = "mm",
      delete = "md",
      delete_line = "mD",
      delete_buf = "mc",
      next = "mn",
      prev = "mp",
    },
  },
}
