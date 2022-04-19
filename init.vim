set nocompatible            " disable compatibility to old-time vi

set hlsearch                " highlight search 
set incsearch               " incremental search
set ignorecase              " case insensitive 
set smartcase             " using capitals in search changes to case sensitive

set showmatch               " show matching brackets

set mouse+=v                 " middle-click paste with 
set mouse+=a                 " enable mouse click

set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set number                  " add line numbers
set relativenumber      " relative line numbers

set cc=80                  " set an 80 column border for good coding style
set scrolloff=5      " keep cursor in a reasonable part of the screen
set undofile

filetype plugin on
filetype plugin indent on   "allow auto-indenting depending on file type

""" PLUGINS
call plug#begin()
" motion
Plug 'ggandor/lightspeed.nvim'

" language support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " fix indents for html/css/js
Plug 'sheerun/vim-polyglot'
  " comment css and js inside html
Plug 'suy/vim-context-commentstring'
  " emmet support with emmet-vim
Plug 'mattn/emmet-vim'
  " linting/formatting
Plug 'dense-analysis/ale'

" editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

" misc
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'folke/which-key.nvim'
" colorschemes
Plug 'rose-pine/neovim'
Plug 'xiyaowong/nvim-transparent'
call plug#end()

let g:coq_settings = { 'auto_start': 'shut-up' }

let g:user_emmet_leader_key=','


let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier']
\}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

" lua plugin settings
" tried to move this to a seperate file but it didn't work
lua << EOF

---- Tree-Sitter setup ----
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "html", "css", "javascript", "vim", "json", "python"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

---- LSP setup ----
local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

---- setup autopairs ---- BREAKS COQ
-- local remap = vim.api.nvim_set_keymap
-- local npairs = require('nvim-autopairs')
-- 
-- npairs.setup({ map_bs = false, map_cr = false })
-- 
-- vim.g.coq_settings = { keymap = { recommended = false } }
-- 
-- -- these mappings are coq recommended mappings unrelated to nvim-autopairs
-- remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
-- remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
-- remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
-- remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
-- 
-- -- skip it, if you use another global object
-- _G.MUtils= {}
-- 
-- MUtils.CR = function()
--   if vim.fn.pumvisible() ~= 0 then
--     if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
--       return npairs.esc('<c-y>')
--     else
--       return npairs.esc('<c-e>') .. npairs.autopairs_cr()
--     end
--   else
--     return npairs.autopairs_cr()
--   end
-- end
-- remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
-- 
-- MUtils.BS = function()
--   if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
--     return npairs.esc('<c-e>') .. npairs.autopairs_bs()
--   else
--     return npairs.autopairs_bs()
--   end
-- end
-- remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

----------------------

require('nvim-autopairs').setup{}

require('rose-pine').setup({
    dark_variant = 'moon',
    })

require("transparent").setup({ enable = true })

---- for emmet-ls - can't get to work
-- local lspconfig = require'lspconfig'
-- local configs = require'lspconfig/configs'    
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
require("which-key").setup()

EOF

" have to put this after plugs to get colorscheme to work
set termguicolors
colorscheme rose-pine

""" BINDINGS
  " settings
    " toggle relative line numbers
nmap <leader>n :set rnu!<CR>
    " clear highlight
nmap <leader>h :noh<CR>
    " toggle line wrap
nmap <leader>w :set wrap!<CR>

  " general commands
    " show registers
map <leader>' :registers<CR>
    " paste from clipboard, turning paste mode on and off appropriately
nmap <leader>p :set paste<CR>"*p:set nopaste!<CR>
imap <leader>p <Esc>:set paste<CR>"*p:set nopaste!<CR>

    " open index.html in firefox
function! OpenWebPage()
  if filereadable("index.html")
    exec "!firefox index.html"
  else
    exec "!firefox %"
  endif
endfunction

nmap <leader>` :call OpenWebPage()<CR>

  " editing commands
inoremap kj <Esc>
inoremap jk <Esc>
inoremap KJ <Esc>
inoremap JK <Esc>
    " more intuitive motions
map H ^
map L $
map K 5k
map J 5j
nnoremap <leader>j J
vnoremap <leader>j J

    " select text of current line (not whole line)
nmap vv ^v$h
    " line break + split
imap <leader><CR> <CR><C-o>O
imap <leader>{ {<CR><C-o>O
imap <leader>( (<CR><C-o>O
imap <leader>[ [<CR><C-o>O

    " move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

    " move split panes to left/bottom/top/right
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L

    " move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
