-- Highlight, edit, and navigate code

local M = {
  'nvim-treesitter/nvim-treesitter',

  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
}

M.config = function()
  -- Keep alphabetical order when managing this list
  local parsers = {
    'bash',
    'c',
    'comment',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'gitignore',
    'go',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'nginx',
    'php',
    'python',
    'query',
    'regex',
    'rust',
    'scss',
    'svelte',
    'sql',
    'templ',
    'toml',
    'tsv',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
    'zig',
  }

  vim.api.nvim_create_user_command('TSInstallConfigured', function()
    require('nvim-treesitter').install(parsers)
  end, {
    desc = 'Install the Treesitter parsers configured in this dotfiles repo',
  })

  local group = vim.api.nvim_create_augroup('dotfiles_treesitter', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end

      -- enables syntax highlighting and other treesitter features
      pcall(vim.treesitter.start, buf, language)

      -- enables treesitter based indentation
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
