"set tabstop=3 
"set shiftwidth=4
syntax on
set hlsearch
set incsearch
"set nobackup
set noswapfile
"set dir=~/.vim/swp
set ignorecase
set undolevels=100
set fileencodings=utf-8,cp1251,koi8-r,cp866
set visualbell
set nowrapscan
set whichwrap=b,s,<,>,[,],l,h
set fdm=syntax
set foldlevel=9999999
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
set laststatus=2



" Clear last found expression highlighting
nmap <F2> :nohlsearch<CR>

filetype plugin on
filetype indent on " per-filetype config
set tabstop=8
set expandtab
set smarttab
set shiftwidth=4 " or 2 or whatever
set shiftround
"set autoindent

"Folds
set fdm=marker
set foldmarker=!f,!/f
"Let all folds be closed on start
set fdls=0
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

"set softtabstop=4
"set smarttab
"set expandtab
colors torte
syntax on
set background=dark
set modeline
set modelines=3
"set nu
"set smartcase
"set nowrap
"set listchars+=precedes:<,extends:>
"set sidescroll=5
"set sidescrolloff=5
"set guifont=terminus
"set nocompatible " disable vi configuration compatibility
set ruler " Always show cursor position
set backspace=indent,eol,start whichwrap+=<,>,[,] " allow to use backspace instead of "x"

" braces autocompletion
imap {<CR> {<CR>}<Esc>O<Tab>

" Autocomplete on Control-Space
imap <C-Space> <C-N>

" 'Smart' Home
nmap <Home> ^
imap <Home> <Esc>I

" Exit
imap <F12> <Esc>:qa<CR>
nmap <F12> :qa<CR>

" turn on/off line numbers visibility
imap <F1> <Esc>:set<Space>nu!<CR>a
nmap <F1> :set<Space>nu!<CR>

" Correct paste/nopaste mode by F3/F4
imap <F3> <Esc>:set<Space>paste<CR>i
nmap <F3> <Esc>:set<Space>nopaste<CR>

