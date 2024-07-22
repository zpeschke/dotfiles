" syntax highlighting
syntax on

" numbered column with custom fg color
set number
highlight LineNr ctermfg=238

" usually using dark terminal backgrounds
set background=dark

" set the obvious
set autoindent

" 72 character columns
set textwidth=72

" row and column and bottom right
set ruler

" highlight matching text in searches
set hls

" paste toggle
set pastetoggle=<F12>

" always show 3 top/bottom lines when scrolling
set scrolloff=3

" better backspace
set backspace=indent,eol,start

" Always reformat lines/paragraphs to textwidth
" set formatoptions+=a

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" apply different settings for different file extensions
autocmd BufNewFile,BufRead *.html setlocal tabstop=4 softtabstop=4 expandtab textwidth=0
autocmd BufNewFile,BufRead *.css setlocal tabstop=4 softtabstop=4 expandtab textwidth=0
autocmd BufNewFile,BufRead *.go setlocal tabstop=8 softtabstop=8 textwidth=0
autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 expandtab textwidth=0
autocmd BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 textwidth=0 expandtab syntax=php
autocmd BufNewFile,BufRead *.py,*.py.* setlocal tabstop=4 softtabstop=4 textwidth=0 expandtab syntax=python
autocmd BufNewFile,BufRead *.hcl,*.tf,*.tfvars setlocal tabstop=2 softtabstop=2 expandtab textwidth=0 syntax=tf
autocmd BufNewFile,BufRead *.txt,*.md setlocal tabstop=4 softtabstop=4 expandtab syntax=markdown
autocmd BufNewFile,BufRead *.yml,*.yml.*,*.yaml,*.yaml.* setlocal tabstop=2 softtabstop=2 textwidth=0 expandtab syntax=yaml

" copy/paste between vim instances by using tmp file
vmap \y :w! ~/.vimshare<CR>
nmap \y :w! ~/.vimshare<CR>
nmap \p :r! cat ~/.vimshare<CR>

" add function and binding to copy entire file contents to system clipboard
function! CopyFileToClipboard()
	" copy entire file to clipboard
	silent! execute ':%w !xclip -selection clipboard'

	" check if command was successful
	if v:shell_error == 0
		echo "Copied file to clipboard"
	else
		echo "Failed to copy file to clipboard"
	endif
	sleep 500m
endfunction
nnoremap \c :<C-U>call CopyFileToClipboard()<CR>

" add function and binding to copy visual selection to system clipboard

function! CopySelectionToClipboard()
	" re-select selection in normal mode and yank to register 'a'
	normal! gv"ay

	" copy register 'a' into system clipboard using xclip
	call system('xclip -selection clipboard', @a)

	" check if command was successful
	if v:shell_error == 0
		echo "Copied selection to clipboard"
	else
		echo "Failed to copy selection to clipboard"
	endif
	sleep 500m

	" restore visual selection
	normal! gv
endfunction
vnoremap \c :<C-U>call CopySelectionToClipboard()<CR>

" Function and mapping to toggle checklist item completion
" If there is a list item without a check box, this function will add
" it. Otherwise, it will toggle the checklist item between complete
" '[x]' and not complete '[ ]'.
function! ToggleCheckListItem()
	" capture current line at cursor
	let current_line = getline('.')

	" capture current cursor position
	let save_cursor = getpos('.')

	" variable that will have newline to replace current line with
	let new_line = ''

	if current_line !~ '- \[ \]' || current_line !~ '- \[x\]'
		let new_line = substitute(current_line, '- ', '- [ ] ', '')
	endif

	" replace '[ ]' with '[x]'
	if current_line =~ '\[ \]'
		let new_line = substitute(current_line, '\[ \]', '[x]', '')
	endif

	" replace '[x]' with '[ ]'
	if current_line =~ '\[x\]'
		let new_line = substitute(current_line, '\[x\]', '[ ]', '')
	endif

	" update the line
	if new_line != ''
		call setline('.', new_line)
	endif

	" exit visual mode - for some reason this works but simply
	" running `normal! \<Esc>` does not
	normal! :<C-u>normal! \<Esc>

	" restore cursor position
	call setpos('.', save_cursor)
endfunction
nnoremap \<Space> :<C-U>call ToggleCheckListItem()<CR>
