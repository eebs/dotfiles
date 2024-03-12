return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      solargraph = {
        settings = {
          solargraph = {
            diagnostics = false,
          },
        },
        init_options = { formatting = false },
      },
    },
  },
}
