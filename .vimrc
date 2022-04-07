" Started with "Missing Semester of Your CS Education" vimrc, then 
" modified it heavily. Needs to be organized and cleaned.

" TODO organize file

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" IJKL bindings
nnoremap h i
nnoremap j h
nnoremap k j
nnoremap i k
nnoremap H I
" Jump to start and end of line using the home row keys
map J ^
map L $
map I 5i
map K 5k

" Add join binding back in. Lowercase so it's easier to use
nmap <leader>j :join<CR>

" Clear highlight
nmap <leader>h :noh<CR>
 
" Exit insert mode. Was hh but too many words end in h
inoremap jj <Esc>
inoremap JJ <Esc>

" visual mode ijkl and escape
vnoremap h i
vnoremap j h
vnoremap k j
vnoremap i k
vnoremap H I
vnoremap jj <Esc>
vnoremap JJ <Esc>

" (Shift)Tab (de)indents code - doesn't do what I thought it did
" vnoremap <Tab> >
" vnoremap <S-Tab> <

" TODO can this be set to put cursor back where it was?
nmap <leader>o o<Esc>i$
nmap <leader>O O<Esc>k$

filetype plugin indent on
set autoindent

" Toggle relative line numbers
nnoremap <leader>n :set rnu!<CR> 
colorscheme slate

" Keep cursor in approximately the middle of the screen
set scrolloff=10

" Maintain undo history between sessions
set undofile 
if !has("nvim")
	set undodir=~/.vim/undodir
endif

" HTML indent
autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 expandtab

" set line length indicator
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" vim-plug - requires installing vim-plug manually first
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
call plug#end()

" select text of current line (not whole line)
nnoremap vv ^v$h

" insert two lines, move cursor to line between with correct indent
" intended for opening blocks e.g. HTML blocks
imap <Leader><CR> <CR><Esc>O

" set :Prettier to format - requires CoC and coc-Prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Toggle wrap
nmap <leader>w :set wrap!<CR>

" requires emmet-vim
let g:user_emmet_leader_key=','

" switch to line cursor for insert mode - for vim
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" yank to clipboard. Requires xclip
vnoremap <silent><Leader>y "yy <Bar> :call system('xclip', @y)<CR>

set termguicolors

highlight CocErrorFloat ctermfg=White guifg=#ffffff

imap <expr> <CR> pumvisible()
		 \ ? "\<C-Y>"
		 \ : "<Plug>delimitMateCR"
