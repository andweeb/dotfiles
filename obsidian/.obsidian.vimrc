" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Quickly remove search highlights
nmap <Space>h :nohl

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold

" Unmap <Space> for use in mappings
unmap <Space>

" Obsidian Smarter MD mappings
" https://github.com/chrisgrieser/obsidian-smarter-md-hotkeys/blob/master/const.ts#L3
exmap surroundRoundBrackets obcommand obsidian-smarter-md-hotkeys:smarter-round-brackets
nmap <Space>) :surroundRoundBrackets

exmap surroundSquareBrackets obcommand obsidian-smarter-md-hotkeys:smarter-square-brackets
nmap <Space>] :surroundSquareBrackets

exmap surroundCurlyBrackets obcommand obsidian-smarter-md-hotkeys:smarter-curly-brackets
nmap <Space>} :surroundCurlyBrackets

exmap surroundSingleQuotes obcommand obsidian-smarter-md-hotkeys:smarter-single-quotation-marks
nmap <Space>' :surroundSingleQuotes

exmap surroundDoubleQuotes obcommand obsidian-smarter-md-hotkeys:smarter-quotation-marks
nmap <Space>" :surroundDoubleQuotes

exmap surroundBackticks obcommand obsidian-smarter-md-hotkeys:smarter-inline-code
nmap <Space>` :surroundBackticks

" Window controls
exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft

exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop

exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom

exmap splitVertical obcommand workspace:split-vertical
nmap <C-w>v :splitVertical

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <C-w>s :splitHorizontal
