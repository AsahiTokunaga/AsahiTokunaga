set autoindent
set autoread
set backupdir=~/.vim/.backup
set cmdheight=2
set cursorline
set directory=~/.vim/.swp
set expandtab
set history=200
set hlsearch
set incsearch
set laststatus=2
set number
set shiftwidth=2
set smarttab
set softtabstop=2
set statusline=\"%F\"\ \|\ %m\ %y%=enc:%{&fileencoding}\ \|\ loc:%c,\ %l/%L
set tabstop=2
set textwidth=80
set undodir=~/.vim/.undo
set updatetime=1000
set wildmode=longest,list,full

filetype plugin indent on

call plug#begin()
Plug 'wakatime/vim-wakatime'
call plug#end()

autocmd VimEnter,BufEnter,CursorHold,CursorHoldI * execute('WakaTimeToday')
