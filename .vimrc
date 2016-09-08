"" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


"" Rebind <Leader> key
"" I like to have it here becuase it is easier to reach than the default and
"" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


"" Better copy & paste
"" When you want to paste large blocks of code into vim, press F2 before you
"" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed


"" Don't add empty newlines at the end of files
set binary
set noeol


"" Allow custom settings
set modeline


"" Enable undo
set undofile
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif


"" Disable stupid backup and swap files - they trigger too many events
"" for file system watchers
set nobackup
set nowritebackup
set noswapfile


"" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


"" Various settins
set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
set exrc                        " load vimrc from current directory
set showcmd                     " display incomplete commands
set modeline                    " Allow document inline settings
set guifont=Ubuntu\ Mono\ for\ VimPowerline\ 12     " Set the default font


"" Bind nohl to remove highlight of your last search (,<space>)
noremap <Leader><space> :nohl<CR>


"" Bind nohl
"" Removes highlight of your last search
"" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


"" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>


"" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


"" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


"" map sort function to a key
vnoremap <Leader>s :sort<CR>


"" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <Leader>ss :call StripWhitespace()<CR>

"" Save a file as root (,W)
noremap <Leader>W :w !sudo tee % > /dev/null<CR>

"" Make <tab> match bracket pairs
nnoremap <tab> %
nnoremap <tab> %


"" easier moving of code blocks
"" Try to go into visual mode (v), thenselect several lines of code here and
"" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


"" Color Hack
if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
set t_Co=256


"" Enable syntax highlighting
"" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


"" Automatic commands
if has("autocmd")
    "" Enable file type detection and syntax highlighting
    filetype plugin indent on       " load file type plugins + indentation
    syntax on

    "" Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

    "" Treat .exp files as expect scripts
    autocmd BufNewFile,BufRead *.exp setfiletype exp syntax=expect

    "" Treat arduino files correctly
    autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
    autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
endif


"" Showing line numbers and length
set tw=79           " width of document (used by gd)
set nowrap          " don't automatically wrap on load
set fo-=t           " don't automatically wrap text when typing
set colorcolumn=80  " Color column 80 to mark the max width
highlight ColorColumn ctermbg=000


"" Autosave on losing focus
au FocusLost * :wa

"" Awesome line number magic (,l)
function! NumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc
nnoremap <Leader>l :call NumberToggle()<CR>
autocmd FocusLost * set norelativenumber number
autocmd FocusGained * set relativenumber
autocmd InsertEnter * set norelativenumber number
autocmd InsertLeave * set relativenumber
set number
set relativenumber


"" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


"" Useful settings
set history=700
set undolevels=700


"" Whitespace
set tabstop=4 softtabstop=4 shiftwidth=4      " a tab is four spaces
set shiftround                  " align indents at standard positions
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain atleast one capital letter


"" Force me to use the correct keys for navigation
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk


"" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
"" Every unnecessary keystroke that can be saved is good for your health :)
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


"" Map the help key to ESC to avoid accidental pushes
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


"" double percentage sign in command mode is expanded
"" to directory of current file - http://cimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>


"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


"" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"" vim-airline - https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"" vim-airline hack so it appears always
set laststatus=2
"" Display whitespace stuff
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping


"" Better Whitespace - https://github.com/ntpeters/vim-better-whitespace
Plugin 'ntpeters/vim-better-whitespace'


"" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line