return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "zbirenbaum/copilot.lua",
    "giuxtaposition/blink-cmp-copilot",
  },
  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },

    snippets = { preset = "luasnip" },

    completion = {
      list = {
        selection = {
          auto_insert = true,
        },
      },

      menu = {
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },

      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          opts = {
            max_completions = 3,
            max_attempts = 4,
            kind = "Copilot",
            debounce = 750,
            auto_refresh = {
              backward = true,
              forward = true,
            },
          },
        },
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          score_offset = 0,
          override = {
            emmet_ls = {
              score_offset = -100,
            },
          },
        },
      },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
