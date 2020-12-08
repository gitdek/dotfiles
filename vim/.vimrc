" modified Tue Jul 14 00:06:26 EDT 2015
" no vi-compatible
set nocompatible
set background=dark
filetype on
filetype plugin on
filetype indent on
set autowrite

set lazyredraw                                     "lazily redraw screen while executing macros, and other commands
set ttyfast                                        "more characters will be sent to the screen for redrawing
set ttimeout                                       "time waited for key press(es) to complete...
set ttimeoutlen=50                                 " ...makes for a faster key response
set noswapfile                                     "disable swap files
set autoread                                       "automatically read changes in the file
set hidden                                         "hide buffers instead of closing them even if they contain unwritten changes
set backspace=indent,eol,start                     "make backspace behave properly in insert mode
set clipboard=unnamedplus                          "use system clipboard; requires has('unnamedplus') to be 1
set wildmenu                                       "better menu with completion in command mode
set wildmode=longest,list,full
set completeopt=longest,menuone,preview            "better insert mode completions
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
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab "use two spaces for indentation
set incsearch                                      "incremental search highlight
set ignorecase                                     "searches are case insensitive...
set smartcase                                      " ..unless they contain at least one capital letter
set hlsearch                                       "highlight search patterns
set modeline                                       " allow files to include a 'mode line', to
                                                   "    override vim defaults
set modelines=5                                    " check
                                                   "    the first 5 lines for a modeline
" Better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo


let mapleader="\<Space>"
nnoremap <leader>w :w<cr>
nnoremap <leader>U :redo<cr>

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
"
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



" Display yankring contents in a new split window.
nnoremap <silent> <leader>y :YRShow<CR>

"override system files by typing :w!!
cnoremap w!! %!sudo tee > /dev/null %

"keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

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

" required for vundle
" filetype off

set showcmd
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles from GitHub repos:

" Python and PHP Debugger
" Bundle 'fisadev/vim-debug.vim'
" Better file browser
Bundle 'scrooloose/nerdtree'
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" Class/module browser
" Bundle 'majutsushi/tagbar'
" Code and files fuzzy finder
" Bundle 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
"Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Zen coding
"Bundle 'mattn/emmet-vim'
" Git integration
Bundle 'motemen/git-vim'
" Tab list panel
Bundle 'kien/tabman.vim'
" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Bundle 'bling/vim-airline'
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
" Indent text object
Bundle 'michaeljsmith/vim-indent-object'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
" Better autocompletion
Bundle 'Shougo/neocomplcache.vim'
" Snippets manager (SnipMate), dependencies, and snippets repo
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'tomtom/tlib_vim'
"Bundle 'honza/vim-snippets'
"Bundle 'garbas/vim-snipmate'
" Git diff icons on the side of the file lines
Bundle 'airblade/vim-gitgutter'
" Automatically sort python imports
"Bundle 'fisadev/vim-isort'
" Drag visual blocks arround
Bundle 'fisadev/dragvisuals.vim'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
" Bundle 'myusuf3/numbers.vim'

" Bundles from vim-scripts repos

" Python code checker
Bundle 'pyflakes.vim'
" Search results counter
Bundle 'IndexedSearch'
" XML/HTML tags navigation
"Bundle 'matchit.zip'
" Gvim colorscheme
Bundle 'Wombat'
" Yank history navigation
Bundle 'YankRing.vim'
" Perl support
Bundle 'perl-support.vim'

Bundle 'chase/vim-ansible-yaml'
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


" toggle Tagbar display
"map <F10> :TagbarToggle<CR>
" autofocus on Tagbar open
"let g:tagbar_autofocus = 1


"==================== NerdTree ====================
"
"" For toggling
" nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>


let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '\.DS_Store', '\.pyc$', '\.pyo$']


" Close nerdtree and vim on close file
"
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

" fix some problems with gitgutter and other plugins (originally jedi-vim, but
" left just in case, and it's faster)
let g:gitgutter_max_signs = 500
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" old autocomplete keyboard shortcuts
"imap <C-J> <C-X><C-O>

" show pending tasks list
map <Leader>t :TaskList<CR>

" save as sudo
ca w!! w !sudo tee "%"

" debugger keyboard shortcuts
let g:vim_debug_disable_mappings = 0
map <Leader><F5> :Dbg over<CR>
"map <F6> :Dbg into<CR>
"map <F7> :Dbg out<CR>
"map <F8> :Dbg here<CR>
"map <F9> :Dbg break<CR>
"map <F10> :Dbg watch<CR>
"map <F11> :Dbg down<CR>
"map <F12> :Dbg up<CR>

" CtrlP (new fuzzy finder)

"let g:ctrlp_map = ',e'
"nmap ,g :CtrlPBufTag<CR>
"nmap ,G :CtrlPBufTagAll<CR>
"nmap ,f :CtrlPLine<CR>
"nmap ,m :CtrlPMRUFiles<CR>
"nmap ,c :CtrlPCmdPalette<CR>
"" to be able to call CtrlP with default search text
"function! CtrlPWithSearchText(search_text, ctrlp_command_end)
"    execute ':CtrlP' . a:ctrlp_command_end
"    call feedkeys(a:search_text)
"endfunction
"" CtrlP with default text
"nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
"" Don't change working directory
"let g:ctrlp_working_path_mode = 0
"" Ignore files on fuzzy finder
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
"  \ 'file': '\.pyc$\|\.pyo$',
"  \ }
"

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep
nmap ,r :RecurGrepFast
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

" python-mode settings
" don't show lint result every time we save a file
let g:pymode_lint_on_write = 0
" run pep8+pyflakes+pylint validator with \8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
" rules to ignore (example: "E501,W293")
let g:pymode_lint_ignore = ""
" don't add extra column for error icons (on console vim creates a 2-char-wide
" extra column)
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and with my custom mapping
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'


" rope (from python-mode) settings
"nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
"nmap ,o :RopeFindOccurrences<CR>

" don't let pyflakes allways override the quickfix list
let g:pyflakes_use_quickfix = 0

" tabman shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
    let &t_Co = 256
    " color
    colorscheme fisa
else
    " color
    colorscheme delek
endif

" colors for gvim
if has('gui_running')
    colorscheme wombat
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'


" Create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" vim-airline settings
let g:airline_powerline_fonts = 0
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#whitespace#enabled = 0

" dragvisuals mappings
"vmap <expr> <S-M-LEFT> DVB_Drag('left')
"vmap <expr> <S-M-RIGHT> DVB_Drag('right')
"vmap <expr> <S-M-DOWN> DVB_Drag('down')
"vmap <expr> <S-M-UP> DVB_Drag('up')
"vmap <expr> D DVB_Duplicate()

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'
"
"

set history=1000
" added Tue Jul 14 00:03:21 EDT 2015

set hidden
" don't unload buffer when it is abandoned. added Tue Jul 14 00:03:32 EDT 2015

map <C-F1> :TOhtml<enter>:wq<enter>:n<enter><C-F1>

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" visually select lines, then do :norm i# to comment those lines with #
" then do the same thing but with :norm x
vnoremap <leader>n :norm


" Dont forget to set arguments with let bexec_args="-f arg1 -c"
 nmap <silent> <unique> <F5> w :Bexec()<CR>
 vmap <silent> <unique> <F5> :BexecVisual()<CR>

let g:html_font = ["Consolas", "DejaVu Sans Mono"]
let g:html_no_progress = 1

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



