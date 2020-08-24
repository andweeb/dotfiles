" General
syntax enable
set clipboard=unnamed      " Enable clipboard sharing
set timeoutlen=300         " Set mapped sequence delay to 300ms
set formatoptions+=n       " Support for numbered/bullet lists
set foldenable             " Enable folds
set foldmethod=marker      " Use fold markers
set foldopen-=block        " Disallow block motions from opening folds

" Designated backup folder
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Get current vimrc path and directory
let s:rcpath=resolve(expand('<sfile>:p'))
let s:vimdir=fnamemodify(s:rcpath, ':h')

" Load local vim files
for f in glob(s:vimdir . '/*.vim', 0, 1)
    execute 'source' f
endfor

" Load local vimrc if it exists
if !empty(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif
