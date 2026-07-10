set autoindent
set backspace=indent,eol,start
set formatoptions+=j
set hidden
set history=1000
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set modeline
set mouse=a
set noerrorbells
set novisualbell
set number
set pastetoggle=<F10>
set relativenumber
set scrolloff=1
set shiftwidth=2
set smartcase
set smartindent
set smarttab
set viminfo=
set wildignore+=.pyc,.swp
set wildmenu

" Remove trailing whitespaces from end of line and end of file
function! TrimWhitespace()
	let l:saved_view = winsaveview()
	" Remove trailing whitespace on each line
	keeppatterns keepjumps %substitute/\s\+$//e
	" Remove blank lines at end of file
	keeppatterns keepjumps %substitute/\(\n\s*\)\+\%$//e
	call winrestview(l:saved_view)
endfunction

augroup format
  au!
  au BufWritePre * call TrimWhitespace()
augroup END

filetype plugin indent on

noremap <silent> <C-l> :noh<CR>

colorscheme elflord
