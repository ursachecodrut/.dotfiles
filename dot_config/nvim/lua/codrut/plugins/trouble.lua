return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  ---@module "trouble"
  ---@type trouble.Config
  opts = {
    auto_close      = false,
    auto_preview    = true,
    focus           = true,
    follow          = true,
    indent_guides   = true,
    multiline       = true,
    restore         = true,
    warn_no_results = true,

    modes           = {
      symbols = {
        desc  = "document symbols",
        mode  = "lsp_document_symbols",
        focus = false,
        win   = {
          position = "right",
        },
      },
    },
  },

  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
  },
}
