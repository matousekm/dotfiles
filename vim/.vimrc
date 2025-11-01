syntax on
filetype on
imap kj <esc>
set scrolloff=5
"set rnu
set number
set tabstop=4
map <space> /
set showmatch
set hlsearch
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap ` ``<left>
"inoremap < <><left>
set shiftwidth=4
"set smarttab
set expandtab
"set softtabstop=0
set autoindent
set textwidth=80
set formatoptions+=t
autocmd BufWritePost ~/projects/agenda/TODO.txt silent !cd ~/projects/agenda && git add TODO.txt && git commit -m "auto: update TODO" && git push origin main > /dev/null 2>&1
set autoread
autocmd FocusGained,BufEnter * checktime

