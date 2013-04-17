set nocompatible                      " just in case system-wide vimrc has set this otherwise

""" Automatically make needed files and folders on first run
""" If you don't run *nix you're on your own (as in remove this) {{{
    call system("mkdir -p $HOME/.vim/{backup,plugin,undo}")
    if !filereadable($HOME . "/.vimrc.bundles") | call system("touch $HOME/.vimrc.bundles") | endif
    if !filereadable($HOME . "/.vimrc.first") | call system("touch $HOME/.vimrc.first") | endif
    if !filereadable($HOME . "/.vimrc.last") | call system("touch $HOME/.vimrc.last") | endif
""" }}}
""" Vundle plugin manager {{{
    """ Setting up Vundle - from https://github.com/fisadev/fisa-vim-config {{{
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/vundle/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
            let has_vundle=0
        endif
    """ }}}
    """ Initialize Vundle {{{
        filetype on                                 " hack to fix bad exit status
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/vundle/          " include vundle
        call vundle#rc()                            " init vundle
    """ }}}
    """ Github repos, uncomment to disable a plugin {{{
    " Recursive vundle, omg!
    Bundle 'gmarik/vundle'

    """ Local bundles (and only bundles in this file!) {{{{
        if filereadable($HOME."/.vimrc.bundles")
            source $HOME/.vimrc.bundles
        endif
    """ }}}

    " Edit files using sudo/su
    Bundle 'chrisbra/SudoEdit.vim'

    " <Tab> everything!
    Bundle 'ervandew/supertab'

    " Fuzzy finder (files, mru, etc)
    Bundle 'kien/ctrlp.vim'

    " A much better statusline
    Bundle 'Lokaltog/vim-powerline'

    " Easy... motions... yeah.
    Bundle 'Lokaltog/vim-easymotion'
    let g:EasyMotion_leader_key = '<Leader>'

    " Snippets like textmate
    " Dependencies
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "honza/vim-snippets"

    " Glorious colorscheme
    Bundle 'nanotech/jellybeans.vim'

    " Tab list panel
    Bundle 'kien/tabman.vim'
    let g:tabman_width = 90

    " Super easy commenting, toggle comments etc
    Bundle 'scrooloose/nerdcommenter'

    " A file tree explorer
    Bundle 'scrooloose/nerdtree'

    " Color text based on RGB, hex, colornames
    Bundle 'ap/vim-css-color'

    " Autoclose (, " etc
    Bundle 'Townk/vim-autoclose'

    " Git wrapper inside Vim
    Bundle 'tpope/vim-fugitive'

    " Handle surround chars like ''
    Bundle 'tpope/vim-surround'

    " Align your = etc.
    Bundle 'vim-scripts/Align'

    " Simple compile/run binds
    Bundle 'xuhdev/SingleCompile'

    " Awesome syntax checker.
    " REQUIREMENTS: See :h Syntastic
    Bundle 'scrooloose/syntastic'

    " Functions, class data etc.
    " REQUIREMENTS: ctags
    Bundle 'majutsushi/tagbar'

    " http://pastie.org
    " REQUIREMENTS: ruby in $PATH (not vim compiled with +ruby)
    "Bundle 'simmel/vim-pastie'

    " C/C++ autocomplete
    " REUIREMENTS: clang compiler
    Bundle 'Rip-Rip/clang_complete'

    " syntax for jquery and rails
    Bundle "jQuery"
    Bundle 'tpope/vim-rails.git'

    " Python autocomplete
    " REQUIREMENTS: python package 'jedi', also in virtenvs
    "Bundle 'davidhalter/jedi-vim'
    """ }}}
    """ Installing plguins the first time {{{
        if has_vundle == 0
            echo "Installing Bundles, please ignore key map error messages"
            echo ""
            :BundleInstall
        endif
    """ }}}
""" }}}
""" Local beginning config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
""" }}}
""" User interface {{{
    """ Syntax highlighting {{{
        filetype plugin indent on                   " enable ft+plugin detect
        syntax on                                   " syntax highlighting
        set t_Co=256                                " 256-colors
        set background=dark                         " we're using a dark bg
        colors jellybeans                           " select colorscheme
        highlight Normal ctermbg=NONE               " use terminal background
        highlight nonText ctermbg=NONE              " use terminal background
        au BufRead,BufNewFile *.txt set ft=sh       " opens .txt w/highlight
    """ }}}
    """ Interface general {{{
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=5                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=.bak,.pyc,.o,.ojb,.,a,       " ignore said files
                       \.pdf,.jpg,.gif,.png,
                       \.avi,.mkv,.so
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash-like auto complete
        """ Encoding {{{
            " If you're having problems with Powerline glyphs you can force
            " UTF-8 if your locale is something else. 
            " WARNING: this will affect encoding used when editing files!
            "
            " set encoding=utf-8                    " for Powerline glyphs
        """ }}}
        """ Gvim {{{
            set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 8
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        """ }}}
        """ Powerline {{{
            let g:Powerline_symbols = 'compatible'  " see :h Powerline_symbols
            let g:Powerline_symbols_override = {
                        \ 'BRANCH': [0x2213],
                        \ }                         " use ∓
            """ Powerline mode names {{{
                let g:Powerline_mode_n  = ' N '
                let g:Powerline_mode_i  = ' I '
                let g:Powerline_mode_R  = ' R '
                let g:Powerline_mode_v  = ' V '
                let g:Powerline_mode_V  = 'V·L'
                let g:Powerline_mode_cv = 'V·B'
                let g:Powerline_mode_s  = ' S '
                let g:Powerline_mode_S  = 'S·L'
                let g:Powerline_mode_cs = 'S·B'
            """ }}}
        """ }}}
    """ }}}
""" }}}
""" General settings {{{
    set modelines=0                       " close security exploit by having modelines in files http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
    set hidden                                      " buffer change, more undo
    set history=200                                 " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set listchars=tab:>\                            " > to highlight <tab>
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode in cmd-line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " no goto #1 char in line
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set ttymouse=xterm2                             " experimental
    set noswapfile                        " Turn off annoying swapfiles "
    """ Folding {{{
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                                " default s//g (global)
        set ignorecase                              " case insensitive search
        set ic                                " ignore case in search
        set hlsearch                          " highlight search strings
        set incsearch                         " incremental search ("find as you type")
        set smartcase                         " except when search string includes a capital letter "
    """ }}}
    """ Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    """ }}}
    """ Return to last edit position when opening files {{{
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exe "normal! g`\"" |
            \ endif
    """ }}}
""" }}}
""" Files {{{
    set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set backup                                      " backup curr file
    set backupdir=$HOME/.vim/backup                 " backup director{y,ies}
    set backupext=~                                 " append ~ to backups
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set updatecount=50                              " update swp after 50chars
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set expandtab                                   " no real tabs
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " igncase,except capitals
    set smartindent                                 " see autoindent
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
    """ Only auto-comment newline for block comments {{{
        au FileType c,cpp setlocal comments -=:// comments +=f://
    """ }}}
""" }}}
""" Keybindings {{{
    """ General {{{
        " Remap <leader>
        let mapleader=","

        " Hide matches on <leader>space
        nnoremap <leader><space> :noh<cr>
       
        " Remove trailing whitespace on <leader>S
        nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

        nnoremap <leader>ev :e $MYVIMRC<CR>
        nnoremap <leader>sv :source $MYVIMRC<CR>

        " Copy/Paste to and from Desktop Environment
        noremap <leader>yy "+y
        noremap <leader>pp "+gP
        
        "" easy escape with jj
        inoremap jj <ESC>
        
        " Quit window on <leader>q
        nnoremap <leader>q :q<CR>
        nnoremap <leader>Q :q!<CR>

        " Disable up/down arrow keys so you learn, damn it
        noremap <up> <nop>
        noremap <down> <nop>
        nnoremap <up> <nop>
        nnoremap <down> <nop>
        vnoremap <up> <nop>
        vnoremap <down> <nop>
        inoremap <up> <nop>
        inoremap <down> <nop>

        " Yank(copy) to system clipboard
        noremap <leader>y "+y

        " Split window management
        nnoremap <leader>V <C-w>v<C-w>l
        nnoremap <leader>H <C-w>s
        nnoremap <leader>n :new<CR>

        " rails specific navigation used with rails.vim
        nnoremap <leader>av :AV<CR>
        nnoremap <leader>rv :RV<CR>
        

        nnoremap <leader>s :w<CR>
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k

        " ; is an alias for :
        nnoremap ; :

        " Toggle text wrapping
        nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR> 

        " Toggle folding
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf

        " Delete previous word with C-BS, doesn't work in all terminals
        imap <C-BS> <C-W>

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Move faster
        map <C-j> <C-d>
        map <C-k> <C-u>

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " Move a line of text using ALT-{j,k}
        nmap <M-j> mz:m+<CR>`z
        nmap <M-k> mz:m-2<CR>`z

        " We don't need any help!
        inoremap <F1> <ESC>
        nnoremap <F1> <ESC>
        vnoremap <F1> <ESC>
        
        " Toggle syntax highlight
        map <F7> :if exists("syntax_on")
            \<Bar>syntax off<Bar>else<Bar>syntax enable<Bar>endif<CR>
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        let g:tagbar_usearrows = 1
        let g:tagbar_ctags_bin='/usr/local/Cellar/ctags/5.8/bin/ctags'
        nnoremap <leader>l :TagbarToggle<CR>


        " NERDtree on <leader>t
        nnoremap <leader>t :NERDTreeToggle<CR>
        let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

        " Toggle pastemode, doesn't indent
        set pastetoggle=<F3>

        " SingleCompile
        nmap <F9> :SCCompile<CR>
        nmap <F10> :SCCompileRun<CR>

        " Syntastic - toggle error list. Probably should be toggleable.
        noremap <silent><leader>lo :Errors<CR>
        noremap <silent><leader>lc :lcl<CR>


        "  tab settings
        " ctrl-t makes a new tab
        noremap <C-t> <Esc>:tabnew<CR>

        " shift T turns a split window into it's own tab
        noremap <S-T> <Esc><C-w>T
        nnoremap <S-T> <Esc><C-w>T

        " ctrl h and l moves left and right between tabs
        noremap <C-h> <Esc>gT<CR>
        noremap <C-l> <Esc>gt<CR>

        " Left/Right arrow keys change buffers in all modes
        noremap <Left> <Esc>:bp<CR>
        noremap <Right> <Esc>:bn<CR>

        " Snipmate remapping
        "imap <tab> <C-r>=TriggerSnippet()<CR>
    """ }}}
    """ Highlight characters past 79, toggle with <leader>h {{{
        nnoremap <leader>h :call ToggleOverLengthHighlight()<CR>
        let g:overlength_enabled = 0
        highlight OverLength ctermbg=black guibg=#212121

        function! ToggleOverLengthHighlight()
            if g:overlength_enabled == 0
                match OverLength /\%79v.*/
                let g:overlength_enabled = 1
                echo 'OverLength highlighting turned on'
            else
                match
                let g:overlength_enabled = 0
                echo 'OverLength highlighting turned off'
            endif
        endfunction
    """ }}}
    """ Toggle relativenumber using <leader>r {{{
        nnoremap <leader>r :call NumberToggle()<CR>

        function! NumberToggle()
            if(&relativenumber == 1)
                set number
            else
                set relativenumber
            endif
        endfunction
    """ }}}
""" }}}
""" Misc plugin settings {{{
    " clang_complete - C++11
    let g:clang_user_options="-std=c++0x"

    " CtrlP - don't recalculate files on start (slow)
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_root_markers = ['.root', 'Makefile', '.git' ]

    " NERDTree
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeHijackNetrw = 1

    " TagBar
    let g:tagbar_left = 0
    let g:tagbar_width = 30
    set tags=tags;/

    " Pastie - private (simmel's fork of tpope's vim-pastie with help from garno)
    let g:pastie_private = 1

    " SingleCompile
    call SingleCompile#SetCompilerTemplate('cpp', 'gcc', 'GNU C Compiler',
        \'g++', '-Wall -Wextra -pedantic -O3 -std=c++0x -o $(FILE_TITLE)$',
        \'./$(FILE_TITLE)$')
    call SingleCompile#SetOutfile('cpp', 'gcc', '$(FILE_TITLE)$')
    call SingleCompile#ChooseCompiler('cpp', 'gcc')

    " Syntastic - C++11 and relevant files
    let g:syntastic_cpp_check_header = 1
    let g:syntastic_cpp_compiler_options = ' -std=c++0x'
    let g:syntastic_mode_map = { 
        \ 'mode': 'passive',
        \ 'active_filetypes': 
            \ ['c', 'cpp', 'javascript', 'perl', 'python', 'sh'] }
    
    " Automatically remove preview window after autocomplete (mainly for clang_complete)
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
""" }}}
""" Local ending config, will overwrite anything above. Generally use this. {{{{
    if filereadable($HOME."/.vimrc.last")
        source $HOME/.vimrc.last
    endif
""" }}}
