set autoindent
set autoread
set backupdir=~/.vim/.backup
set cmdheight=1
set cursorline
set directory=~/.vim/.swp
set expandtab
set exrc
set history=200
set hlsearch
set incsearch
set laststatus=2
set noshowcmd
set noshowmode
set number
set shiftwidth=2
set smarttab
set softtabstop=2
set statusline=\ %{GetMode()}\ \|\ \"%F\"\ \|\ %y\ %m%=wakatime:\ %{wakatime_status}\ \|\ enc:%{&fileencoding}\ \|\ loc:%c,\ %l/%L\ \|\ %{GetCurrentTime()}
set tabstop=2
set textwidth=80
set undodir=~/.vim/.undo
set updatetime=1000
set wildmode=longest,list,full

filetype plugin indent on

let $TZ = 'Asia/Tokyo'
let wakatime_status = substitute(system('wakatime-cli --today | grep -oE "^[0-9]{1,2}\s(secs|mins|hrs)(\s[0-9]{1,2}\s(secs|mins))?$"'), '\n\|\r', '', 'g')

call plug#begin()
Plug 'wakatime/vim-wakatime'
call plug#end()

function! GetMode()
  if mode() == 'n'
    return 'NORMAL'
  elseif mode() == 'i'
    return 'INSERT'
  elseif mode() == 'v'
    return 'VISUAL'
  elseif mode() == 'V'
    return 'V\-LINE'
  elseif mode() == '^V'
    return 'V\-BLOCK'
  elseif mode() == 'c'
    return 'COMMAND'
  else
    return mode()
endfunction

function! GetCurrentTime()
  return strftime('%H:%M:%S(%Z), %Y/%b/%d %a ')
endfunction

autocmd CursorHold,CursorHoldI * set statusline=\ %{GetMode()}\ \|\ \"%F\"\ \|\ %y\ %m%=wakatime:\ %{wakatime_status}\ \|\ enc:%{&fileencoding}\ \|\ loc:%c,\ %l/%L\ \|\ %{GetCurrentTime()}
