set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


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

lua << END
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
    },
    init_options = {
      linters = {
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
      },
      filetypes = {
        ruby = "standardrb"
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
        }
      },
      formatFiletypes = {
        ruby = "standardrb"
      }
    }
  }
  require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
END
