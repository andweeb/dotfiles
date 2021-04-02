" Source filetype plugins and enable syntax highlighting
filetype plugin indent on
syntax enable

" Various settings
set clipboard+=unnamedplus " Enable clipboard sharing
set timeoutlen=300         " Set mapped sequence delay to 300ms

" Designated backup folder
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Enable extended `%` matching
runtime macros/matchit.vim

" Get current vimrc path and directory
let s:rcpath=resolve(expand('<sfile>:p'))
let g:srcdir=fnamemodify(s:rcpath, ':h')

function s:dotfile(filename)
    execute 'source'.g:srcdir.'/'.a:filename
endfunction

" Source external configs
execute s:dotfile('ui.vim')
execute s:dotfile('plugins.vim')
execute s:dotfile('mappings.vim')
execute s:dotfile('config.vim')

" Load local vimrc if it exists
if !empty(glob(g:srcdir.'/vimrc.local'))
    execute s:dotfile('vimrc.local')
endif
