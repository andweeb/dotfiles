" Source filetype plugins and enable syntax highlighting
filetype plugin indent on
syntax enable

" Various settings
set clipboard=unnamed      " Enable clipboard sharing
set timeoutlen=300         " Set mapped sequence delay to 300ms

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
