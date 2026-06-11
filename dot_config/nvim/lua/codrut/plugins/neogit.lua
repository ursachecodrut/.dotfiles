return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", function() require("neogit").open() end,                      desc = "neogit" },
    { "<leader>gC", function() require("neogit").open({ "commit" }) end,          desc = "neogit Commit" },
    { "<leader>gp", function() require("neogit").open({ "push" }) end,            desc = "neogit Push" },
    { "<leader>gP", function() require("neogit").open({ "pull" }) end,            desc = "neogit Pull" },
    { "<leader>gd", function() require("diffview").open() end,                    desc = "Diffview Open" },
    { "<leader>gD", function() require("diffview").open({ "HEAD~1" }) end,        desc = "Diffview Last Commit" },
    { "<leader>gx", function() require("diffview").close() end,                   desc = "Diffview Close" },
    { "<leader>gH", function() require("diffview").open({ "--follow", "%" }) end, desc = "Diffview File History" },
  },
  opts = {
    integrations = {
      diffview = true,
      fzf_lua = true,
    },
    graph_style = "unicode",
  },
}
