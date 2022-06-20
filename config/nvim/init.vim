set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


nnoremap <silent><C-]> <cmd>lua vim.lsp.buf.definition()<CR>

" nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gn <cmd>lua vim.lsp.buf.rename()<CR>

lua << END
  require("lspconfig").solargraph.setup{
    useBundler = true;
  }
END
