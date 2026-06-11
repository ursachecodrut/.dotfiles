--  Better syntax highlighting (and more)
---@type string[]
local parsers = {
  'arduino',
  'bash',
  'c',
  'cmake',
  'comment',
  'cpp',
  'css',
  'csv',
  'diff',
  'dockerfile',
  'editorconfig',
  'eex',
  'elixir',
  'elm',
  'erlang',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'gleam',
  'go',
  'graphql',
  'haskell',
  'heex',
  'helm',
  'hjson',
  'html',
  'http',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'kdl',
  'liquid',
  'llvm',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'mermaid',
  'nginx',
  'promql',
  'python',
  'query',
  'regex',
  'ruby',
  'rust',
  'scss',
  'sql',
  'ssh_config',
  'surface',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'typst',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
  'zig',
}

---@type LazySpec[]
---@diagnostic disable: missing-fields
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {},
    opts = {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    },
    init = function()
      require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ':t')
        return string.match(filename, '.*mise.*%.toml$') ~= nil
      end, { force = true, all = false })
    end,
    config = function(_, opts)
      local ts = require 'nvim-treesitter'
      ts.setup(opts)
      if vim.fn.executable 'tree-sitter' == 1 then
        ts.install(parsers)
      end

      local function is_supported_by_treesitter(buf)
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or lang == '' then
          return false
        end
        local ok, parser = pcall(vim.treesitter.get_parser, buf, lang, { error = false })
        return ok and parser ~= nil
      end

      local function is_small_file(buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return not (ok and stats and stats.size > max_filesize)
      end

      local group = vim.api.nvim_create_augroup('TreesitterStuff', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = '*',
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local supported = is_supported_by_treesitter(buf)
          if supported and is_small_file(buf) then
            pcall(vim.treesitter.start, buf)
          end
          if supported then
            vim.bo.autoindent = false
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          else
            vim.bo.autoindent = true
            vim.bo.indentexpr = ''
          end
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = '*',
        callback = function(args)
          local disabled_fts = { 'gitcommit' }
          if not vim.tbl_contains(disabled_fts, args.match) then
            local winid = vim.api.nvim_get_current_win()
            vim.wo[winid][0].foldmethod = 'expr'
            vim.wo[winid][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- disable folds at startup
            vim.wo[winid][0].foldenable = false
          end
        end,
      })
    end,
  },
}
