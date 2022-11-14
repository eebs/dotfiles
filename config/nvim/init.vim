set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set completeopt=noinsert,menuone,noselect

nnoremap <silent><C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><Leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

" nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gn <cmd>lua vim.lsp.buf.rename()<CR>

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarning linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInformation linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

autocmd VimEnter * TroubleRefresh
nnoremap <Leader>o <cmd>TroubleToggle document_diagnostics<CR>

lua require('leap').add_default_mappings()

lua << END
  require("lspconfig").tsserver.setup{}
  require("lspconfig").cssls.setup{}
  require("lspconfig").jsonls.setup{}
  require("lspconfig").vimls.setup{}
  require("lspconfig").solargraph.setup{
    useBundler = true;
    init_options = {
      formatting = false
    },
    settings = {
      solargraph = {
        diagnostics = false
      }
    }
  }

  require("lspconfig").diagnosticls.setup{
    filetypes = {
      "ruby",
      "typescript",
      "typescriptreact",
      "javascript",
      "css",
      "scss",
      "markdown",
    },
    init_options = {
      linters = {
        eslint = {
          command = "eslint",
          rootPatterns = { ".git" },
          debounce = 100,
          args = {
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json"
          },
          sourceName = "eslint",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "[eslint] ${message} [${ruleId}]",
            security = "severity"
          },
          securities = {
            [2] = "error",
            [1] = "warning"
          }
        },
        stylelint = {
          command = "stylelint",
          rootPatterns = {
            ".git"
          },
          debounce = 100,
          args = {
            "--formatter",
            "json",
            "--stdin-filename",
            "%filepath"
          },
          sourceName = "stylelint",
          parseJson = {
            errorsRoot = "[0].warnings",
            line = "line",
            column = "column",
            message = "${text}",
            security = "severity"
          },
          securities = {
            error = "error",
            warning = "warning"
          }
        },
        rubocop = {
          command = "rubocop",
          rootPatterns = { ".git" },
          sourceName = "rubocop",
          debounce = 100,
          args = {
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            "%filepath"
          },
          parseJson = {
            errorsRoot = "files[0].offenses",
            line = "location.start_line",
            endLine = "location.last_line",
            column = "location.start_column",
            endColumn = "location.end_column",
            message = "[${cop_name}] ${message}",
            security = "severity"
          },
          securities = {
            fatal = "error",
            error = "error",
            warning = "warning",
            convention = "info",
            refactor = "info",
            info = "info"
          }
        },
        standardrb = {
          command = "standardrb",
          rootPatterns = { ".git" },
          sourceName = "standardrb",
          debounce = 100,
          args = {
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            "%filepath"
          },
          parseJson = {
            errorsRoot = "files[0].offenses",
            line = "location.start_line",
            endLine = "location.last_line",
            column = "location.start_column",
            endColumn = "location.end_column",
            message = "[${cop_name}] ${message}",
            security = "severity"
          },
          securities = {
            fatal = "error",
            error = "error",
            warning = "warning",
            convention = "info",
            refactor = "info",
            info = "info"
          }
        },
        vale = {
          command = "vale",
          debounce = 100,
          args = {
            "--no-exit",
            "--output",
            "JSON",
            "--ext",
            ".md",
          },
          sourceName = "vale",
          parseJson = {
            errorsRoot = "stdin.md",
            line = "Line",
            column = "Span[0]",
            endLine = "Line",
            endColumn = "Span[1]",
            message = "[${Check}] ${Message}",
            security = "Severity"
          },
          securities = {
            error = "error",
            warning = "warning",
            suggestion = "info",
          },
        },
      },
      filetypes = {
        ruby = "standardrb",
        javascript = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",
        css = "stylelint",
        scss = "stylelint",
        markdown = "vale"
      },
      formatters = {
        standardrb = {
          command = "standardrb",
          args = {
            "--fix",
            "%file"
          },
          rootPatterns = { ".git" },
          doesWriteToFile = true
        },
        prettierEslint = {
          command = "prettier-eslint",
          args = { "--stdin" },
          rootPatterns = { ".git" },
        },
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", '%filename' }
        }
      },
      formatFiletypes = {
        ruby = "standardrb",
        css = "prettier",
        javascript = "prettier",
        javascriptreact = "prettier",
        json = "prettier",
        scss = "prettier",
        typescript = "prettier",
        typescriptreact = "prettier"

      }
    }
  }
  require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })

  -- Setup nvim-cmp.
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = ({
         buffer = "[Buffer]",
         nvim_lsp = "[LSP]",
         nvim_lua = "[Lua]",
         tmux = "[tmux]",
         path = "[path]",
       })
      })
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= "prompt" and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= "prompt" and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }, {
      { name = "buffer" },
      { name = "tmux" },
      { name = "path" }
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
END
