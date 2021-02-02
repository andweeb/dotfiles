" Source filetype plugins and enable syntax highlighting
filetype plugin indent on
syntax enable

" Various settings
set clipboard+=unnamedplus " Enable clipboard sharing
set timeoutlen=300    " Set mapped sequence delay to 300ms

" Designated backup folder
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Enable extended `%` matching
runtime macros/matchit.vim

" Get current vimrc path and directory
let s:rcpath=resolve(expand('<sfile>:p'))
let g:srcdir=fnamemodify(s:rcpath, ':h')

" Source external configs
execute 'source'.g:srcdir.'/ui.vim'
execute 'source'.g:srcdir.'/plugins.vim'
execute 'source'.g:srcdir.'/mappings.vim'
execute 'source'.g:srcdir.'/config.vim'

" Load local vimrc if it exists
if !empty(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif
