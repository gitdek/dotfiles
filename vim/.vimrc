" ██╗!!!██╗██╗███╗!!!███╗██████╗!!██████╗
" ██║!!!██║██║████╗!████║██╔══██╗██╔════╝
" ██║!!!██║██║██╔████╔██║██████╔╝██║!!!!!
" ╚██╗!██╔╝██║██║╚██╔╝██║██╔══██╗██║!!!!!
" !╚████╔╝!██║██║!╚═╝!██║██║!!██║╚██████╗
" !!╚═══╝!!╚═╝╚═╝!!!!!╚═╝╚═╝!!╚═╝!╚═════╝
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"  ▓▓▓▓▓▓▓▓▓▓
"  ▓ author ▓ dek <https://git.io/gitdek>
"  ▓ repo   ▓ https://github.com/gitdek/dotfiles
"  ▓ mirror ▓ https://git.io/.dekdotfiles
"  ▓▓▓▓▓▓▓▓▓▓

set nocompatible
set background=dark
filetype on
filetype plugin on
filetype indent on
set autowrite
set shortmess+=I								   "disable startup message
set lazyredraw                                     "lazily redraw screen while executing macros, and other commands
set ttyfast                                        "more characters will be sent to the screen for redrawing
set ttimeout                                       "time waited for key press(es) to complete...
set ttimeoutlen=50                                 " ...makes for a faster key response
set noswapfile                                     "disable swap files
set autoread                                       "automatically read changes in the file
set hidden                                         "hide buffers instead of closing them even if they contain unwritten changes
set backspace=indent,eol,start                     "make backspace behave properly in insert mode
set clipboard^=unnamedplus						   "operator ^= prepends the unnamedplus setting, rather than appending it.
set wildmenu                                       "better menu with completion in command mode
set wildmode=longest,list,full
set completeopt=longest,menuone,preview,noinsert   "better insert mode completions
set nowrap                                         "disable soft wrap for lines
set scrolloff=2                                    "always show 2 lines above/below the cursor
set showcmd                                        "display incomplete commands
set laststatus=2                                   "always display the status bar
set number                                         "display line numbers
set cursorline                                     "highlight current line
set colorcolumn=81                                 "display text width column
set splitbelow                                     "vertical splits will be at the bottom
set splitright                                     "horizontal splits will be to the right
set autoindent                                     "always set autoindenting on
set formatoptions-=cro                             "disable auto comments on new lines
set incsearch                                      "incremental search highlight
set ignorecase                                     "searches are case insensitive...
set smartcase                                      " ..unless they contain at least one capital letter
set hlsearch                                       "highlight search patterns
set modeline                                       "allow files to include a 'mode line', to
set modelines=5                                    "check the first 5 lines for a modeline
set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
set history=10000

" Better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos

if !has('nvim')
	  set viminfo+=n~/vim/viminfo
"  else
	    " Do nothing here to use the neovim default
		"   " or do soemething like:
		"     " set viminfo+=n~/.shada
endif
		"
set viminfo+=n~/.vim/dirs/viminfo

"██╗!!!!!███████╗!█████╗!██████╗!███████╗██████╗!
"██║!!!!!██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
"██║!!!!!█████╗!!███████║██║!!██║█████╗!!██████╔╝
"██║!!!!!██╔══╝!!██╔══██║██║!!██║██╔══╝!!██╔══██╗
"███████╗███████╗██║!!██║██████╔╝███████╗██║!!██║
"╚══════╝╚══════╝╚═╝!!╚═╝╚═════╝!╚══════╝╚═╝!!╚═╝
" Leader is spacebar
let mapleader="\<Space>"

nnoremap <leader>w :w<cr>
nnoremap <leader>U :redo<cr>
nnoremap <leader>q :q<cr>

"move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

"remove current line highlight in unfocused window
au VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cul
au WinLeave,FocusLost,CmdwinLeave * set nocul

"remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e

"replace the word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

"create a new buffer (save it with :w ./path/to/FILENAME)
nnoremap <leader>B :enew<cr>
"close current buffer
nnoremap <leader>bq :bp <bar> bd! #<cr>
"close all open buffers
nnoremap <leader>ba :bufdo bd!<cr>

"Tab to switch to next open buffer
nnoremap <Tab> :bnext<cr>
"Shift + Tab to switch to previous open buffer
nnoremap <S-Tab> :bprevious<cr>

"leader key twice to cycle between last two open buffers
nnoremap <leader><leader> <c-^>

"move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction


"override system files by typing :w!!
cnoremap w!! %!sudo tee > /dev/null %

"keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

"create needed directories if they don't exist
if !isdirectory(&backupdir)
	call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
	call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
	call mkdir(&undodir, "p")
endif

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	let iCanHazVundle=0
endif

"required for vundle
set showcmd
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Vundle
Bundle 'gmarik/vundle'
" Better file browser
" Bundle 'scrooloose/nerdtree'
" Code commenter
" Bundle 'scrooloose/nerdcommenter'
" Git integration
Bundle 'motemen/git-vim'
" Tab list panel
Bundle 'kien/tabman.vim'
" Airline and themes
" Bundle 'vim-airline/vim-airline'
" Bundle 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
Bundle 'fisadev/fisa-vim-colorscheme'
" Consoles as buffers
Bundle 'rosenfeld/conque-term'
" Pending tasks list
Bundle 'fisadev/FixedTaskList.vim'
" Surround
Bundle 'tpope/vim-surround'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
" Bundle 'klen/python-mode'
" Better autocompletion
Bundle 'Shougo/neocomplcache.vim'
" Git diff icons on the side of the file lines
" Bundle 'airblade/vim-gitgutter'
" Drag visual blocks arround
Bundle 'fisadev/dragvisuals.vim'
" Python code checker
Bundle 'pyflakes.vim'
" Search results counter
Bundle 'IndexedSearch'
" Gvim colorscheme
Bundle 'Wombat'
" Yank history navigation
Bundle 'YankRing.vim'
" Perl support
Bundle 'perl-support.vim'
" Tmux focus events
Bundle 'tmux-plugins/vim-tmux-focus-events'
Bundle 'tmux-plugins/vim-tmux'

" Installing plugins the first time
if iCanHazVundle == 0
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:BundleInstall
endif

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

"setup nerdtree
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '\.DS_Store', '\.pyc$', '\.pyo$']
" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

"setup gitgutter
" fix some problems with gitgutter and other plugins (originally jedi-vim, but
" left just in case, and it's faster)
" #let g:gitgutter_max_signs = 500
" let g:gitgutter_eager = 1
" let g:gitgutter_realtime = 1
" let g:gitgutter_highlight_lines = 1
"
"setup tasklist
" show pending tasks list
" map <Leader>t :TaskList<CR>
map <Leader>t :TaskListToggle<CR>
" map <Leader>t <Plug>TaskListToggle
" show task list window on the bottom
let g:tlWindowPosition = 1
let g:tlRememberPosition = 0
" setup tokens we want to parse
let g:tlTokenList = ["FIXME", "TO-DO", "XXX", "NOTE", "BUG", "CHANGED", "OPTIMIZE"]

"setup neocompl
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"simple save as sudo
ca w!! w !sudo tee "%"

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep
nmap ,r :RecurGrepFast
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

"setup pymode
let g:pymode_lint_on_write = 0 "do not autolint on write
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
let g:pymode_lint_ignore = ''		"rules to ignore (example: 'E501,W293')
let g:pymode_lint_message = 1		"show error message
let g:pymode_lint_signs = 1			"add error icons etc
let g:pymode_lint_cwindow = 1		"auto open cwindow(quickfix)
let g:pymode_folding = 0			"don't fold python code on open
let g:pymode_rope = 0				"don't use rope
let g:pymode_virtualenv = 0			" ..same with virtualenv
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>

"setup pyflakes
let g:pyflakes_use_quickfix = 0		"do not overwrite quickfix list

"setup tabman
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

"use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
	let &t_Co = 256
	colorscheme fisa
else
	colorscheme delek
endif

"colors for gvim
if has('gui_running')
	colorscheme wombat
	set guifont=Source\ Code\ Pro\ for\ Powerline\ Semibold\ 10
endif


"setup yankring
let g:yankring_history_dir = "~/.vim/dirs/" "history dir
let g:yankring_window_height = 12			"split window height
let g:yankring_max_history = 500			"history size to display
let g:yankring_clipboard_monitor = 0		"disable clipboard monitoring
" display yankring contents in a new split window.
nnoremap <silent> <leader>y :YRShow<CR>

"setup vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" dragvisuals mappings
"vmap <expr> <S-M-LEFT> DVB_Drag('left')
"vmap <expr> <S-M-RIGHT> DVB_Drag('right')
"vmap <expr> <S-M-DOWN> DVB_Drag('down')
"vmap <expr> <S-M-UP> DVB_Drag('up')
"vmap <expr> D DVB_Duplicate()

"add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=manual
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"visually select lines, then do :norm i# to comment those lines with #
"then do the same thing but with :norm x
vnoremap <leader>n :norm

"Dont forget to set arguments with let bexec_args="-f arg1 -c"
nmap <silent> <unique> <F5> w :Bexec()<CR>
vmap <silent> <unique> <F5> :BexecVisual()<CR>

let g:html_font = ["Consolas", "DejaVu Sans Mono"]
let g:html_no_progress = 1

"simple TOhtml command
map <C-F1> :TOhtml<enter>:wq<enter>:n<enter><C-F1>
map <silent> <Leader><F1> :TOhtml<enter>

function! FilterToNewWindow()
	let TempFile = tempname()
	let SaveModified = &modified
	exe 'w ' . TempFile
	exe '!chmod +x ' . TempFile
	let &modified = SaveModified
	exe ':e ' . TempFile
	exe '%! ' . @%
	exe 'w!'
endfunction

command! FW call FilterToNewWindow()
vnoremap QQ y:call FW(@")<Enter>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

func! s:TmuxBufferName()
	let l:list = systemlist('tmux list-buffers -F"#{buffer_name}"')
	if len(l:list)==0
		return ""
	else
		return l:list[0]
	endif
endfunc

func! s:TmuxBuffer()
	return system('tmux show-buffer')
endfunc

func! s:Enable()
	if $TMUX==''
		" not in tmux session
		return
	endif

	let s:lastbname=""

	" if support TextYankPost
	if exists('##TextYankPost')==1
		" @"
		augroup vimtmuxclipboard
			autocmd!
			autocmd FocusLost * call s:update_from_tmux()
			autocmd	FocusGained   * call s:update_from_tmux()
			autocmd TextYankPost * silent! call system('tmux loadb -',join(v:event["regcontents"],"\n"))
		augroup END
		let @" = s:TmuxBuffer()
	else
		" vim doesn't support TextYankPost event
		" This is a workaround for vim
		augroup vimtmuxclipboard
			autocmd!
			autocmd FocusLost     *  silent! call system('tmux loadb -',@")
			autocmd	FocusGained   *  let @" = s:TmuxBuffer()
		augroup END
		let @" = s:TmuxBuffer()
	endif
endfunc

func! s:update_from_tmux()
	let buffer_name = s:TmuxBufferName()
	if s:lastbname != buffer_name
		let @" = s:TmuxBuffer()
	endif
	let s:lastbname=s:TmuxBufferName()
endfunc

call s:Enable()

"function! GitStatus()
"	let [a,m,r] = GitGutterGetHunkSummary()
"	return printf('+%d ~%d -%d', a, m, r)
"endfunction

" setup ranger

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction

command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

"setup statusline using airline and gitgutter
"set statusline=%!airline#statusline(1)
"set statusline+=%{GitStatus()}


