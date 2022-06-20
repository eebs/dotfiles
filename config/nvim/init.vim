set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << END
  require("lspconfig").solargraph.setup{
    useBundler = true;
  }
END
