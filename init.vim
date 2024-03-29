execute pathogen#infect()
let g:JavaComplete_GradleExecutable = './gradlew'
:inoremap fj <Esc>
:nnoremap <up> ddkP
nnoremap <down> ddp
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <RightMouse> <nop>
nnoremap <LeftMouse> <nop>
inoremap <LeftMouse> <nop>
inoremap <RightMouse> <nop>
vnoremap <LeftMouse> <nop>
vnoremap <RightMouse> <nop>
nnoremap <RightMouse><RightMouse> <nop>
nnoremap <LeftMouse><LeftMouse> <nop>
inoremap <LeftMouse><LeftMouse> <nop>
inoremap <RightMouse><RightMouse> <nop>
vnoremap <LeftMouse><LeftMouse> <nop>
vnoremap <RightMouse><RightMouse> <nop>
if has('nvim')
	tnoremap <LeftMouse><LeftMouse> <nop>
	tnoremap <RightMouse><RightMouse> <nop>
	tnoremap <LeftMouse> <nop>
	tnoremap <RightMouse> <nop>
	tnoremap <esc> <C-\><c-n> 
	tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
	tnoremap <C-w>w <C-\><C-n><C-w><C-w>
	tnoremap <C-w>h <C-\><C-n><C-w><C-h>
	tnoremap <C-w>j <C-\><C-n><C-w><C-j>
	tnoremap <C-w>k <C-\><C-n><C-w><C-k>
	tnoremap <C-w>l <C-\><C-n><C-w><C-l>
	tnoremap <C-w>s <C-\><C-n><C-w><C-s><C-\><C-n><C-w><C-j><C-\><C-n>:terminal<Cr>
	tnoremap <C-w>v <C-\><C-n><C-w><C-v><C-\><C-n><C-w><C-l><C-\><C-n>:terminal<Cr>
	tnoremap <C-w>t <C-\><C-n>:tabnew<CR><Esc>
	tnoremap <C-w><C-h> <C-\><C-n><C-w><C-h>
	tnoremap <C-w><C-j> <C-\><C-n><C-w><C-j>
	tnoremap <C-w><C-k> <C-\><C-n><C-w><C-k>
	tnoremap <C-w><C-l> <C-\><C-n><C-w><C-l>
	tnoremap <C-w><C-s> <C-\><C-n><C-w><C-s><C-\><C-n><C-w><C-j><C-\><C-n>:terminal<Cr>
	tnoremap <C-w><C-v> <C-\><C-n><C-w><C-v><C-\><C-n><C-w><C-l><C-\><C-n>:terminal<Cr>
	tnoremap <C-w><C-t> <C-\><C-n>:tabnew<CR><Esc>
	tnoremap <C-h> <C-\><C-n>:tabp<CR>
	tnoremap <C-l> <C-\><C-n>:tabn<CR>
endif
:syntax on
filetype plugin indent on
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>
nnoremap <C-w><C-t> :tabnew<CR>
nnoremap <C-w>t :tabnew<CR>
nnoremap <F5> :GundoToggle<Cr>
nnoremap <C-b> <C-t>
nnoremap    <F6> :wa<CR> <bar>  :make<CR>
let mapleader = ','
map <leader> <Plug>(easymotion-prefix)
set nohlsearch
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:clang_library_path="/usr/lib/llvm-3.8/lib"
set completeopt=longest,menuone
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype cpp setlocal omnifunc=ClangComplete
autocmd Filetype c setlocal omnifunc=syntaxcomplete#Complete
autocmd Bufread,BufNewFile *.wiki nmap <buffer> <F6> :w<CR>:VimwikiAll2HTML<CR>:e%<CR>
let g:clang_user_options='|| exit 0'
autocmd Filetype java nmap <buffer> <F7> :!java -jar build/*.jar<CR>
autocmd Filetype python nmap <buffer> <F6> :wa<CR>
autocmd Filetype python nmap <buffer> <F7> :!python
autocmd Filetype c nmap <buffer> <F7> :!./*.out<CR>
autocmd Filetype cpp nmap <buffer> <F7> :!./*.out<CR>
autocmd Filetype tex nmap <buffer> <F6> :wa<CR> <bar> :!pdflatex %<CR>
autocmd Filetype tex nmap <buffer> <F7> :!evince %:t:r.pdf &<CR>
set number
autocmd BufWinEnter,WinEnter,TabEnter term://* startinsert
autocmd Bufread,BufNewFile,BufWinEnter,BufEnter *.gv nmap <buffer> <F6> :wa<CR>:!dot -Tps % -o %:t:r.ps<CR>
autocmd Bufread,BufNewFile *.gv nmap <buffer> <F7> :!evince %:t:r.ps &<CR>
autocmd! BufReadPost,BufNewFile *.tex set filetype=tex
autocmd! BufWrite * Neomake

function! s:SetProjectRoot() 
	lcd %:p:h
	let git_dir = system("git rev-parse --show-toplevel")
	let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
	if empty(is_not_git_dir)
		lcd `=git_dir`
	endif
endfunction

function! s:ExecuteConfigFile()
	if filereadable(".config.vim")
		source .config.vim
	endif
endfunction

autocmd BufEnter \(\(term://\)\@!\)* call <SID>SetProjectRoot() | call <SID>ExecuteConfigFile() 
function s:HighlightWord()
	call inputsave()
	let search = input('')
	call inputrestore()
	exec "/".search
	normal Nnve
endfunction

onoremap <c-s> :call <SID>HighlightWord()<cr>

function! s:ExecuteCurrentFile()
	exec "%y\""
	exec "@\""
endfunction

nnoremap <C-e> :call <SID>ExecuteCurrentFile()<CR>


let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14'

let g:clang_user_options="-std=c++14"
function s:checkTemp(blargh)
	echom a:blargh
endfunction
let g:neomake_c_enable_markers=['clang']
let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g"]

let g:neomake_python_flake8_maker = {
			\ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
			\ 'errorformat':
			\ '%E%f:%l: could not compile,%-Z%p^,' .
			\ '%A%f:%l:%c: %t%n %m,' .
			\ '%A%f:%l: %t%n %m,' .
			\ '%-G%.%#',
			\ }
let g:neomake_python_enabled_makers = ['flake8']
