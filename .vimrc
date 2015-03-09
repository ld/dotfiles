" ==============================================================================
" Author:  Lin Dong
" Version: 0.2
" README: TODO
" Last_modify: Feb 19, 2015
" Description: My Vim Configuration file
" ==============================================================================

" leader
let mapleader = ','
let g:mapleader = ','

" syntax
syntax on

" manually load syntax highlighter
":set syn=syntax-type
"i.e. :set syn=python

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on


" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set novisualbell                " turn off visual bell
set noerrorbells         " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500


" show location
set cursorcolumn
set cursorline


" movement
set scrolloff=7                 " keep 3 lines when scrolling

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis


" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set smartcase                   " no ignorecase if Uppercase char present
"set ignorecase                  " ignore case when searching"

" cancel highlight search
noremap <silent><leader>/ :nohls<CR>

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2                " insert mode tab and backspace use 2 spaces

vnoremap < <gv
vnoremap > >gv

" NOT SUPPORT
" fold
" set foldenable
" set foldmethod=indent
" set foldlevel=99

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m

" spell check
set spell
set spelllang=en_us

set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class


" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
" set mouse=a


hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar

" specific language
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
  autocmd FileType c,python set tabstop=4 shiftwidth=4 expandtab ai
  autocmd FileType ruby,eruby,yaml,makrdown set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
  autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee >/dev/null %

" F5 paste toggle
set pastetoggle=<F5>
au InsertLeave * set nopaste
" :r! cat and then paste ( shift + insert  ) the content, and CTRL+D.

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" no ex mode
nnoremap Q <nop>

" remap vim
command! WQ wq
command! Wq wq
command! W w
command! Q q
" Q map to q, to quit vim
command! -bar -bang Q quit<bang>

" update vim on the fly
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>V :tabedit $MYVIMRC<CR>

autocmd! bufwritepost _vimrc source % " vimrc文件修改之后自动加载。 windows。
autocmd! bufwritepost .vimrc source % " vimrc文件修改之后自动加载。 linux。

" insert date in the following format
iab <expr> dd strftime("%a %b %_d %H:%M:%S %Z %Y")

" resize
nnoremap <leader><left> :vertical resize -5<cr>
nnoremap <leader><down> :resize +5<cr>
nnoremap <leader><up> :resize -5<cr>
nnoremap <leader><right> :vertical resize +5<cr>

" Wrap text
command! -nargs=* Wrap set wrap linebreak nolist
" Set spell check
command! -nargs=* Spell set spell!

" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

map <silent> <leader>y :<C-u>silent '<,'>w !pbcopy<CR>

" avoid and recover from accidental Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0
inoremap <silent> <C-Y> <C-R>"

" ==============================================================================
"                             Vundle
" ==============================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Essentials
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'

" Airline
Plugin 'bling/vim-airline'

" Make Vim play nicely
Plugin 'sjl/vitality.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'guns/vim-sexp.git'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

Plugin 'scrooloose/nerdtree'

" Errors, open error list
" lclose, location close
Plugin 'scrooloose/syntastic'

" syntax highlight
Plugin 'othree/html5.vim'
Plugin 'othree/vim-coffee-script'
Plugin 'lukaszkorecki/CoffeeTags'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
" Plugin 'groenewege/vim-less'
" Plugin 'briancollins/vim-jst'

" json
Plugin 'elzr/vim-json'
" TODO list
Plugin 'vim-scripts/TaskList.vim'
" markdown
Plugin 'plasticboy/vim-markdown'
"python highlight
" Plugin 'hdima/python-syntax'

" Plugin 'derekwyatt/vim-scala'

" JavaScript
"  Plugin 'vim-scripts/SyntaxComplete'
"  Plugin 'jelera/vim-javascript-syntax'
"  Plugin 'burnettk/vim-angular'
"  Plugin 'mattn/jscomplete-vim'
" JS beautifier, formatting javascript
" require nodejs and npm -g install js-beautify
" Plugin 'einars/js-beautify'
" Plugin 'maksimr/vim-jsbeautify'

" auto complete
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'othree/vim-autocomplpop'

" Unite, CtrlP
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'

" MRU
Plugin 'yegappan/mru'

" eol
Plugin 'vim-scripts/PreserveNoEOL'

" regex ,/ toggle
Plugin 'othree/eregex.vim'

" remove trailing whitespace by :FixWhitespace
Plugin 'bronson/vim-trailing-whitespace'

" comments
Plugin 'tomtom/tcomment_vim'

" ctags
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'

" Align
Plugin 'godlygeek/tabular'

" Pairs
Plugin 'vim-scripts/matchit.zip'
Plugin 'jiangmiao/auto-pairs'
" parentheses
Plugin 'kien/rainbow_parentheses.vim'

" Gundo vim undo tree
Plugin 'sjl/gundo.vim'

" Jumps ctrl-i ctrl-o zp zP gf
Plugin 'justinmk/vim-sneak'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tommcdo/vim-kangaroo'

" mark
Plugin 'kshenoy/vim-signature'

" Calendar plugin
Plugin 'mattn/calendar-vim'

" Zen coding
Plugin 'mattn/emmet-vim'

" CSS coloring
" Plugin 'gorodinskiy/vim-coloresque'
Plugin 'guns/xterm-color-table.vim'

" auto save, auto-save
Plugin '907th/vim-auto-save'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" previewing markdown in browser <Leader>P
Plugin 'greyblake/vim-preview'

" Goyo, distraction free
" Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/limelight.vim'

" Scratch, :Scratch :Sscratch
Plugin 'duff/vim-scratch'

" multiple cursor, Ctrl-p for prev, Ctrl-n for next, Ctrl-x to skip
Plugin 'terryma/vim-multiple-cursors'

" select regions, Press + to expand the visual selection and _ to shrink it.
Plugin 'terryma/vim-expand-region'

" increment
" Plugin 'vim-scripts/BlockWork'
" Plugin 'qwertologe/nextval.vim'
Plugin 'vim-scripts/VisIncr'
" \as to activate autonumbering
" Plugin 'vim-scripts/autonumbering-in-vim'
"Insert line numbers: http://vim.wikia.com/wiki/Insert_line_numbers


" draw it
"  <leader>di to start DrawIt and
"  <leader>ds to stop  DrawIt.
" uses keboard it overwrites ,v
"  Plugin 'vim-scripts/DrawIt'
Plugin 'vim-scripts/sketch.vim' " uses mouse

" Latex
" Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Auto detect CJK and Unicode file encodings
Plugin 'mbbill/fencview'

" rst
" Plugin 'rykka/os.vim'
" Plugin 'Rykka/clickable.vim'
" Plugin 'Rykka/clickable-things'
" Plugin 'Rykka/riv.vim'
" Plugin 'nvie/vim-rst-tables'

" Gist
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

" Intent Guides
Plugin 'nathanaelkane/vim-indent-guides'

" colorscheme
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'benjaminwhite/Benokai'
Plugin 'romainl/flattened'

" Mini Buffer
" Plugin 'techlivezheng/vim-plugin-minibufexpl'

" using vim as slides
"  Plugin 'ingydotnet/vroom-pm'

" split vim into two pane
" Plugin 'vim-voom/VOoM'
" Plugin 'vim-voom/VOoM_extras'

" ldong
Plugin 'ldong/vim_bclose'
" Plugin 'ldong/vim-listify'

" Games
Plugin 'ldong/battleship'

" <Leader>te
" Game tetris
" Plugin 'vim-scripts/TeTrIs.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


" ==============================================================================
"                             Plugins Configuration
" ==============================================================================
" ,nt to open nerdTree
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" <leader><leader>r  rename
nmap <silent> <leader>nt :NERDTreeToggle<CR>

" ,tb to open tagbar
nmap <silent> <leader>tb :TagbarToggle<CR>
" Ctags, check the parent directories for tags, too.
set tags=./.tags;,./tags
let g:easytags_dynamic_files = 1
let g:easytags_file = '~/.vim/tags'
let g:easytags_updatetime_min=12000
let g:easytags_async = 1

" fix whitespace
command! F FixWhitespace

" redfine emmet shortcut: ,e,
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key     = '<leader>e'
autocmd FileType html,css,eruby,markdown,php EmmetInstall

" Gundo toggle
nnoremap <leader>h :GundoToggle<CR>

" MiniBufExplorer
" let g:miniBufExplCycleArround = 1
" map <Leader>b :MBEToggle<cr>
" map <Leader>p :MBEbn<cr>
" map <leader>P :MBEbp<cr>

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" use powerline font if installed
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

let g:airline_theme                        = 'powerlineish'
let g:airline#extensions#branch#enable     = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#bufferline#enabled= 1


" vim-powerline symbols
let g:airline_left_sep           = '▶'
let g:airline_left_alt_sep       = '»'
let g:airline_right_sep          = '◀'
let g:airline_right_alt_sep      = '«'
let g:airline_symbols.branch     = '⤴' "➔, ➥, ⎇
let g:airline_symbols.readonly   = '⊘'
let g:airline_symbols.linenr     = '¶'
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_b          = '%{getcwd()}'

" vim-session autosave
let g:auto_save                 = 1
let g:auto_save_in_insert_mode  = 0
let g:session_autoload          = 'no'
let g:session_autosave          = 'yes'
let g:session_autosave_periodic = 3
" auto save
autocmd BufLeave,CursorHold,CursorHoldI,FocusLost * silent! wa

" enable indent guides
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" eregex regex
let g:eregex_default_enable = 0
nnoremap <leader>r :call eregex#toggle()<CR>

" => UltiSnips
let g:UltiSnipsExpandTrigger="k"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsListSnippets="<c-l>"

" enable always save with eol at the end of file
let b:PreserveNoEOL = 1

" easy motion
" leader leader w
" leader leader gE
" leader leader t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
" <C-x> <C-v> open file in horizontal and vertical split
" <C-t> open file in new tab
" <esc> exit unite window
" <C-j> <C-k> Navigation, keep hands on home row
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <Leader>b :Unite buffer<cr>
nnoremap <space>/ :Unite grep:.<cr>
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

let g:SuperTabCrMapping = 0
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 5
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <C-P> :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:!<cr>
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled = 1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" Appropriately close the buffer without closing the window
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bclose' : 'bd')

" => Syntastic
" :SyntasticInfo
let g:syntastic_java_javac_config_file_enabled = 1
" let g:syntastic_python_checkers = ['pylint', 'flake8', 'python']
let g:syntastic_python_checkers = ['pylint', 'python']
let g:syntastic_python_pylint_args='--ignore=E501'
" let g:syntastic_python_pylint_args='--ignore=W0511,C0321'
" general
"let g:syntastic_check_on_open = 1
"let g:syntastic_quiet_warnings = 0
"let g:syntastic_enable_signs = 1
"let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker_args='--ignore=E501,E302,E231,E261,E201,W402,W293'

" highlight python
" let python_highlight_all = 1


" Preview latex after compliation
" " \ll compile;   \lv view
" let g:LatexBox_viewer = "open /Applications/Preview.app"

" vim_json settings
" let g:vim_json_syntax_conceal = 0
" let g:vim_json_warnings=1

" fugitive shortcuts
noremap \gs :Gstatus<cr>
noremap \gc :Gcommit<cr>
noremap \ga :Gwrite<cr>
noremap \gl :Glog<cr>
noremap \gd :Gdiff<cr>
noremap \gb :Gblame<cr>

"surrounding, shortcuts: ds, cs, yss
"ysiw}
"ds{

" Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>


" draw ascii using mouse
" map <leader>d :call ToggleSketch()<CR>

" define Goyo shortcut
" nnoremap <Leader>G :Goyo<CR>

" MRU
let MRU_Max_Entries = 20
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
let MRU_Window_Height = 5
let MRU_Auto_Close = 1

" Java Abbreviation
abbr psvm public static void main(String[] args){<CR>}<esc>O
abbr sysout System.out.println("");<esc>2hi
abbr syserr System.err.println("");<esc>2hi
abbr fori for (int i = 0; i < ; i++) {<esc>7hi
abbr tryb try {<CR>} catch (Exception ex) {<CR> ex.printStackTrace();<CR>}<esc>hx3ko
abbr ctm System.currentTimeMillis()

" ==============================================================================
"                                   Mappings
" ==============================================================================
" Use single quote as additional range key
noremap ' `

" Rerun previous :command
noremap \' @:

" Underline a line with hyphens (<h2> in Markdown documents)
noremap \- yypVr-

" Underline a line with equals (<h1> in Markdown documents)
noremap \= yypVr=

" Remove white space turds from the ends of lines
noremap \W :FixWhitespace<cr>

" Delete ALL THE BUFFERS!
noremap \bd :1,999bd<cr>:NERDTree<cr>:NERDTree<cr>

" cd current window to parent directory of file
noremap \cd :lcd %:h<cr>:pwd<cr>

" Copy path of current file to clipboard
noremap \cp :let @+ = expand("%")<cr>

" Generate ctags and cscope
" "ctags -R
" "cscope -Rbq
noremap \ct :!ctags -R .<cr><cr>

" Sort selection
noremap \s :sort<cr>

" selec the whole line
noremap \v ^v$

" selec the whole line without leading space
noremap \vv 0v$

" Put contents of parentheses on their own newline and reindent (must position
" cursor inside parentheses in normal mode first).
nmap \( ci(<cr><esc>Pa<cr><esc>Vkk=

" Break a comma-delimited list onto new lines
vmap \, :s/,/,\r/g<cr>)

" ==============================================================================
"                               Color Theme
" ==============================================================================
try " Solarized
  if has('gui_running')
    colorscheme solarized
    let g:solarized_termcolors= 256
    let g:solarized_termtrans = 0
    let g:solarized_degrade   = 0
    let g:solarized_bold      = 1
    let g:solarized_underline = 1
    let g:solarized_italic    = 1
    let g:solarized_visibility= "normal"
    let g:solarized_contrast  = "low"
    set background=light
  else
    " set t_Co=256
    " let g:solarized_termcolors = 256
    let g:solarized_termcolors = 16
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    colorscheme solarized
    set background=dark
  endif
catch /^Vim\%((\a\+)\)\=:E185/
  let g:molokai_original = 1
  let g:rehash256 = 1
  set background=dark
  for scheme in [ 'molokai', 'monokai', 'Benokai' 'desert'  ]
    try
      execute 'colorscheme '.scheme
      break
    catch
      continue
    endtry
  endfor
endtry

" let g:jellybeans_use_lowcolor_black = 0
" colorscheme jellybeans

hi clear SpellBad
hi SpellBad cterm=undercurl,bold
" hi SpellBad cterm=undercurl,bold ctermfg=blue

" set highlight color after 80 regardless of the version of VIM
if exists('+colorcolumn')
    " let &colorcolumn="80,".join(range(120,999),",")
    let &colorcolumn="80"
    highlight ColorColumn ctermbg=9 guibg=#df0000
else
    " fallback for Vim < v7.3
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
