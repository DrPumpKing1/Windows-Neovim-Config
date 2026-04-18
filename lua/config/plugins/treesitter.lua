return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function ()
      require('nvim-treesitter').setup({
          ensure_installed = {
              "vimdoc",
              "javascript",
              "typescript",
              "c",
              "lua",
              "rust",
              "jsdoc",
              "bash",
              "go",
          },
          -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
          install_dir = vim.fn.stdpath('data') .. '/site'
      })
  end
}
