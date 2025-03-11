set autoindent
set autoread
set backupdir=~/.vim/.backup
set cmdheight=1
set cursorline
set directory=~/.vim/.swp
set encoding=utf-8
set expandtab
set history=200
set hlsearch
set incsearch
set laststatus=2
set noshowcmd
set noshowmode
set number
set shiftwidth=2
set signcolumn=yes
set smarttab
set softtabstop=2
set tabstop=2
set textwidth=80
set undodir=~/.vim/.undo
set updatetime=100
set wildmode=longest,list,full

highlight GitGutterAdd    ctermfg=green   guifg=green
highlight GitGutterChange ctermfg=yellow  guifg=yellow
highlight GitGutterDelete ctermfg=red     guifg=red
highlight SignColumn      ctermbg=black   guibg=black

let $TZ = 'Asia/Tokyo'

function! ConditionalLoad()
  if isdirectory('.git')
    Plug 'airblade/vim-gitgutter'
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'wakatime/vim-wakatime'
call ConditionalLoad()
call plug#end()

let wakatime_status = substitute(system('wakatime-cli --today | grep -oE "^[0-9]{1,2}\s(secs|mins|hrs)(\s[0-9]{1,2}\s(secs|mins))?$"'), '\n\|\r', '', 'g')


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

function! GetGitStatus()
  let [added, modified, removed] = GitGutterGetHunkSummary()
  return printf('[+]%d [~]%d [-]%d',added, modified, removed)
endfunction

let s:status_line = '\ %{GetMode()}\ \|\ \"%F\"\ \|\ %y\ %m'
if isdirectory('.git')
  let s:status_line = s:status_line . '\ \|\ %{GetGitStatus()}'
endif
let s:status_line = s:status_line . '%=wakatime:\ %{wakatime_status}\ \|\ enc:%{&fileencoding}\ \|\ loc:%c,\ %l/%L\ \|\ %{GetCurrentTime()}'

execute 'set statusline=' . s:status_line

autocmd FileType rust   setlocal sw=2 sts=2 ts=2 et
autocmd FileType python setlocal sw=4 sts=4 ts=4 et
autocmd CursorHold,CursorHoldI * execute 'set statusline=' . s:status_line
