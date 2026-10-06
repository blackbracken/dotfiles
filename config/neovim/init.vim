" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/.config/nvim/init.vim
\| endif

call plug#begin('~/.vim/plugged')
"  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'cocopon/iceberg.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'itchyny/lightline.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

" display
colorscheme iceberg
let g:airline_theme = 'iceberg'
set number
set cursorline
set title
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 

" search
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch

" cache
set noswapfile
set nobackup

" default code formatting
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" formatting extension
"autocmd BufNewFile,BufRead Makefile runtime! filetype/makefile.vim
"autocmd Filetype           js       runtime! filetype/js.vim
"autocmd Filetype           sh       runtime! filetype/shell.vim

" encode
set encoding=utf-8
setglobal fileencoding=utf-8

" etc
set clipboard=unnamed
set mouse=a

" nvim-tree setup
lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
  end
})
EOF

" key binds
let mapleader = " "

nnoremap <silent><leader>e :NvimTreeToggle<CR>
nnoremap <silent><leader>r :NvimTreeRefresh<CR>
nnoremap <silent><leader>n :NvimTreeFindFile<CR>
