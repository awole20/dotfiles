" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Session management {{{
    " Save current session
    map <F5> :call SaveCurrentSession()<CR>
    " Attempt to load current session
    " autocmd vimenter * if !argc() && v:this_session == "" | exec "source ~/.vimsession" | endif
    map <F9> :source ~/.vimsession<CR>
"}}}

"Vundle - load plugins. Run command "vim +BundleInstall! +qa" {{{
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" }}}

" Color schemes {{{
" Attempt at 256 colors
set t_Co=256
" attempt at clearing background for different color backgrounds!
set t_ut=
Bundle 'jnurmine/Zenburn'
Bundle 'tpope/vim-vividchalk'
if has('gui_running')
  colorscheme zenburn
else
  set background="light"
  "colorscheme vividchalk
  colorscheme zenburn
endif
"}}}

" Nerdtree {{{
    Bundle 'scrooloose/nerdtree'
    let NERDTreeShowHidden=1 "show hidden files
    autocmd vimenter * if !argc() | NERDTree | endif " Open tree automatically if no files specified, and we haven't loaded from a session
    " f7 to open file explorer for nerdtree
    nmap <F7> :NERDTreeToggle<CR>
    " Ignore git directory, c object files, java class files, and others that we do not want displayed in the tree
    let NERDTreeIgnore=['.git$[[dir]]', '.o$[[file]]', '.class$[[file]]','.swp$[[file]]','.swo$[[file]]']
" }}}

"Tagbar {{{
Bundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
"}}}

" Tmux support {{{
  Bundle 'ervandew/screen'
  let g:ScreenImpl = 'Tmux'
" }}}

" Syntastic! ...and I suppose eclim can go in here, these are similar{{{
Bundle 'scrooloose/syntastic'
let g:syntastic_java_javac_config_file_enabled=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:EclimQuickfixSignText='✗'
let g:EclimLocListSignText='⚠'
" }}}

" Let ^A/^X work on date/timestamps
Bundle 'tpope/vim-speeddating'

" Markdown syntax files
Bundle 'tpope/vim-markdown'

" re/un/wrap manipulation
Bundle 'tpope/vim-surround'

" Extend bracket mappings, including [b, ]b for previous and next buffers
Bundle 'tpope/vim-unimpaired'

" Enable repeating various other tpope (surround, speeddating, abolish,
" unimpaired) with .
Bundle 'tpope/vim-repeat'

" Tabular!
Bundle 'godlygeek/tabular'

" Indexed Search!
Bundle 'vim-scripts/IndexedSearch'

" Git commands!
Bundle 'tpope/vim-fugitive'

" MiniBufExplorer and buffer settings{{{
Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplBuffersNeeded=100 "hide screen until there are 100 buffers. Hoping this never happens. Essencially manual mode
let g:miniBufExplUseSingleClick = 1 "single click to swap
map <F6> :MBEToggleAll<cr>


" Use ctrl-[hjkl] to select the active split!
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" bclose - keeps windows when closing buffers
map <leader>d :MBEbd!<cr>

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" }}}

" Visual Star Search
Bundle 'nelstrom/vim-visual-star-search'

" autocomplete! see readme for details for installation. It's pretty awesome.
Bundle 'Valloric/YouCompleteMe'
" if under eclim, lets YouCompleteMe and eclim play nice
let g:EclimCompletionMethod = 'omnifunc'

" floobits -- code sharing?
Bundle 'Floobits/floobits-vim'
" floobits likes YouCompleteMe to reduce updatetime so that code is more in sync
let g:ycm_allow_changing_updatetime=0

"Folds {{{
set foldmethod=marker
set foldlevel=99 "folds open by default
set foldcolumn=3
" }}}

"Autocomplete ctrl-space {{{
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
    if has("unix")
        inoremap <Nul> <C-n>
    else
    " I have no idea of the name of Ctrl-Space elsewhere
    endif
endif
" }}}

" Strip trailing whitespace with <leader>$ {{{
nnoremap <leader>$ :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Paste {{{
set pastetoggle=<F2>
" }}}

" Invisibles {{{
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" }}}

" VIM user interface {{{
" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set hlsearch            " Highlight search results
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set relativenumber
if has("autocmd")
    autocmd FocusLost * :set number
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
    autocmd CursorMoved * :set relativenumber
endif
set matchpairs+=<:>     " match on HTML/xml pairs

" For regular expressions turn magic on
set magic

" Set to auto read when a file is changed from the outside
set autoread

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" }}}

" Text, tab and indent related {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}}


" Status line {{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%{fugitive#statusline()}%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}

" Helpers {{{
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! SaveCurrentSession()
    " Close nerd tree, it causes buffer issues
    exec "NERDTreeClose"
    " Create a session, if none exists
    if v:this_session == '' | let v:this_session = '~/.vimsession' | endif
    if v:this_session != '' | exec "mks! " . v:this_session | endif
    echo "session saved to " . v:this_session
endfunction
" }}}
