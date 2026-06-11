return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        }
      },
      ruff = {},
      uv = {},
      ty = {},
      ts_ls = {},
      eslint = {},
      biome = {},
      tinymist = {},
      dexter = {
        cmd = { 'dexter', 'lsp' },
        root_markers = { '.dexter/dexter.db', '.dexter.db', '.git', 'mix.exs' },
        filetypes = { 'elixir', 'eelixir', 'heex' },
        init_options = {
          followDelegates = true, -- jump through defdelegate to the target function
          -- stdlibPath = "",      -- override Elixir stdlib path (auto-detected)
          -- debug = false,        -- verbose logging to stderr (view with :LspLog)
        },
      },
      ['rust_analyzer'] = {
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              buildScripts = { enable = true }
            },
            procMacro = {
              enable = true
            },
          },
        },
      }
    }

    vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Buffer format" })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local buf = event.buf
        local map = function(key, fn, desc)
          vim.keymap.set("n", key, fn, { silent = true, buffer = buf, desc = desc })
        end

        -- lsp buf
        map("gd", vim.lsp.buf.definition, "LSP Definition")
        map("gD", vim.lsp.buf.references, "LSP References")
        map("gt", vim.lsp.buf.type_definition, "LSP Type Definition")
        map("gi", vim.lsp.buf.implementation, "LSP Implementation")
        map("K", vim.lsp.buf.hover, "LSP Hover")
        map("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "LSP Code Action")

        -- diagnostic
        map("<leader>k", vim.diagnostic.open_float, "Diagnostic Float")
        map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
        map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
        map("<leader>ds", function() vim.diagnostic.open_float({ scope = "line" }) end, "Line Diagnostics")

        map("<leader>dv",
          function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end,
          "Toggle diagnostics virtual text")
      end,
    })

    for name, config in pairs(servers) do
      vim.lsp.enable(name)
      vim.lsp.config(name, config)
    end
  end,
}
