return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  keys = {
    -- Pickers
    { "<leader>ff",  function() require("fzf-lua").files() end,                 desc = "Fzf Files" },
    { "<leader>fg",  function() require("fzf-lua").live_grep() end,             desc = "Fzf Live Grep" },
    { "<leader>fw",  function() require("fzf-lua").grep_cword() end,            desc = "Fzf Grep Word Under Cursor" },
    { "<leader>fW",  function() require("fzf-lua").grep_cWORD() end,            desc = "Fzf Grep WORD Under Cursor" },
    { "<leader>fb",  function() require("fzf-lua").buffers() end,               desc = "Fzf Buffers" },
    { "<leader>fh",  function() require("fzf-lua").help_tags() end,             desc = "Fzf Help Tags" },
    { "<leader>fd",  function() require("fzf-lua").diagnostics_document() end,  desc = "Fzf Diagnostics" },
    { "<leader>fr",  function() require("fzf-lua").lsp_references() end,        desc = "Fzf LSP References" },
    { "<leader>fs",  function() require("fzf-lua").lsp_document_symbols() end,  desc = "Fzf Document Symbols" },
    { "<leader>fS",  function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Fzf Workspace Symbols" },

    { "<leader>fm",  function() require("fzf-lua").marks() end,                 desc = "Fzf Marks" },
    { "<leader>fG",  function() require("fzf-lua").grep_last() end,             desc = "Fzf Grep Last" },
    { "<leader>f/",  function() require("fzf-lua").search_history() end,        desc = "Fzf Search History" },
    { "<leader>f:",  function() require("fzf-lua").command_history() end,       desc = "Fzf Command History" },
    { "<leader>f\"", function() require("fzf-lua").registers() end,             desc = "Fzf Registers" },

    -- Git pickers
    { "<leader>gs",  function() require("fzf-lua").git_status() end,            desc = "Fzf Git Status (Stage files with Tab)" },
    { "<leader>gc",  function() require("fzf-lua").git_commits() end,           desc = "Fzf Git Commits (Checkout on Enter)" },
    { "<leader>gb",  function() require("fzf-lua").git_branches() end,          desc = "Fzf Git Branches" },
    { "<leader>gt",  function() require("fzf-lua").git_stash() end,             desc = "Fzf Git Stash" },
  },

  config = function()
    local exclude = {
      -- version control
      ".git",
      -- elixir
      "_build",
      "deps",
      ".elixir_ls",
      -- frontend / js
      "node_modules",
      "dist",
      "build",
      ".next",
      ".nuxt",
      "coverage",
      -- misc
      ".cache",
    }

    local fd_excludes = table.concat(
      vim.tbl_map(function(d) return "--exclude " .. d end, exclude), " "
    )

    local rg_excludes = table.concat(
      vim.tbl_map(function(d) return "--glob '!" .. d .. "'" end, exclude), " "
    )

    require("fzf-lua").setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "down:50%",
        },
      },

      fzf_opts = {
        ["--ansi"]   = true,
        ["--info"]   = "inline",
        ["--height"] = "100%",
        ["--layout"] = "reverse",
      },

      files = {
        fd_opts = "--color=never --type f --hidden --follow " .. fd_excludes,
        actions = {
          ["ctrl-y"] = function(selected)
            local path = require("fzf-lua").path.entry_to_file(selected[1]).path
            vim.fn.setreg("+", path)
            vim.notify("Copied: " .. path)
          end,
          ["ctrl-e"] = function(selected)
            local path = require("fzf-lua").path.entry_to_file(selected[1]).path
            local name = vim.fn.fnamemodify(path, ":p")
            vim.fn.setreg("+", name)
            vim.notify("Copied: " .. name)
          end,
        },
      },

      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 " ..
        rg_excludes .. " -e",
      },
    })
  end,
}
