" GUI options{{{
if has("gui_running")
    " remove MacVim toolbar (-=T)
    set guioptions-=T
endif
"}}}

" Wrap too long lines
set wrap

"Of course, prefer vim settings to vi's
set nocompatible
set nu
set showmode

" Turn on syntax if possible."{{{
if has("syntax")
	syntax on
endif
"}}}

" General Settings"{{{
" A few search related options"{{{
set hlsearch
set incsearch
set gdefault
"}}}

" Next a few indentation options"{{{
set autoindent
set smartindent
"}}}

" set the size of a tab to 4 space"{{{
set tabstop=4
set softtabstop=4
" set the size of an indent
set shiftwidth=4
set expandtab
"}}}

" Filetype plugins"{{{
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif
"}}}

"Allow some cool features of the command completion ex mode"{{{
set wildmenu
" set wildignore+=*.o,*.obj,*~
""}}}

" Folding and list chars - misc options"{{{
" folding enable
"
"if has("folding")
"	set foldenable
"	set foldmethod=indent
"endif
"}}}

" show a ruler
set ruler
