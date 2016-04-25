" ******************************************************************"
"        << Judge which system, windows or linux >>                 "
" ******************************************************************"
let g:isWindows = 0
let g:isLinux = 0
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWindows = 1
else
    let g:isLinux = 1
endif    
" ******************************************************************"
"        << Judge which show ways, terminal or gvim >>              "
" ******************************************************************"
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif    
"**********************   windows gvim default config *************""
if g:isWindows
	set nocompatible
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function MyDiff()
	  let opt = '-a --binary '
	  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	  let arg1 = v:fname_in
	  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	  let arg2 = v:fname_new
	  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	  let arg3 = v:fname_out
	  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	  let eq = ''
	  if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
		  let cmd = '""' . $VIMRUNTIME . '\diff"'
		  let eq = '"'
		else
		  let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	  else
		let cmd = $VIMRUNTIME . '\diff'
	  endif
	  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
	endfunction
endif
"**********************   linux vim/gvim default config ***********""

"**********************  Config plugin vundle *********************""
set nocompatible              " be iMproved, required
filetype off                  " required

if g:isLinux
    set rtp+=~/.vim/bundle/Vundle.vim       " set the runtime path to include Vundle and initialize
    call vundle#begin()
else
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim       " set the runtime path to include Vundle and initialize
    call vundle#begin()
endif    
        
Plugin 'VundleVim/Vundle.vim'           " let Vundle manage Vundle, required
"< plugin on GitHub repo>
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'
Plugin 'taglist.vim'
Plugin 'winmanager'
Plugin 'minibufexpl.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Shougo/neocomplcache'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'davidhalter/jedi'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'bing/vim-bufferline'
Plugin 'szw/vim-ctrlspace'
Plugin 'kien/ctrlp.vim'
"Plugin 'tacahiroy/ctrip-funky'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/EasyGrep'
Plugin 'brookhong/cscope.vim'
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/matchit.zip'
Plugin 'SirVer/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'ccvext.vim'
Plugin 'cSyntaxAfter'
Plugin 'genutils'
Plugin 'lookupfile'
Plugin 'std_c.zip'
Plugin 'Mark--Karkat'
Plugin 'c.vim'
Plugin 'cpp.vim'
Plugin 'repeat.vim'
Plugin 'surround.vim'
"Plugin 'tpope/vim-fugitive'
Plugin 'file:///work/softw/vim-plugin/taglist-46/plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
"************************** End Vundle ***************************""
"************************** General config ***********************""
filetype on
filetype plugin on
filetype plugin indent on
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
if (g:isWindows && g:isGUI)
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.UTF-8
endif       
set ttimeoutlen=50
set t_Co=256
set hidden
set nu				" show number
set autoread
set expandtab 		" replace tab with space
set foldcolumn=0	" fold column
set foldenable		" enable fold
set foldlevel=4		" fold level
set nowb			" no swap
set ruler			" set ruler
set laststatus=2		" set status bar
set hlsearch			" highlight search result
set ignorecase smartcase" ignore case
set incsearch			" show result
set nowrapscan			" no scan on rear or tail
set tabstop=4			" tab 4 char
set smartindent			" smart indent
set cursorline    "" highlight current line
if g:isLinux
    set tags=./tags
else
    set tags=tags
    set autochdir
endif    
"let mapleader=" "
if g:isGUI
        winpos 100 10
        set lines=38 columns=120
        set guioptions+=c "" char 
        set guioptions-=m "" hide menubar
        set guioptions-=T "" hide toolsbar
        set guioptions-=L "" hide left scrollbar
        set guioptions-=r "" hide right scrollbar
        set guioptions-=b "" hide bottom scrollbar
        set showtabline=0 "" hide tabbar
        set cursorline    "" highlight current line
"        set shortmess=atI "" del welcome ui
endif        

imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-k> <Right>
"************************** solarized config *************************""
syntax on
if has('gui_running')
    set background=dark
    colorscheme solarized
else
    set background=light
    colorscheme desert
"    let g:neocomplcache_enable_at_startup=1
endif
"************************** cSyntaxAfter config *************************""
autocmd! BufRead, BufNewFile, BufEnter FileType c,cpp,java,php,py call CSyntaxAfter()
"************************** ctags config *************************""
nmap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"************************** Tagbar config ***********************"
let g:tagbar_ctags_bin='ctags'
let g:tagbar_width=30
nmap <S-b> :TagbarToggle<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"************************** Taglist config ***********************"
"let Tlist_Ctags_Cmd='usr/local/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
" let Tlist_Use_Left_Window=1
nmap <S-l> :TlistToggle<CR>

"************************* ccvext  config ***********************"
"<leader>sy auto gen tags & cscope
"<leader>sc connect tags & cscope

"************************* poweline config ***********************"
let g:Powerline_symbols='unicode'
"************************* SuperTab config ***********************"
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-x><C-o>"
"************************* OmniCppComplete config ****************"
"************************* neocomplcache config ******************"
"************************* tabular config *********************"
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /: \zs<CR>
vmap <leader>a: :Tabularize /: \zs<CR>
"************************* ulltiSnips config *********************"
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsSnippetDirectories=['snippets', 'bundle/ultisnips/UltiSnips']
"************************* YouCompleteMe config *********************"
set completeopt=longest,menu
autocmd InsertLeave * if pumvisible()==0|pclose|endif
inoremap <expr> <CR> pumvisible()?"\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible()? "\<C-n>" :"\<Down>"
inoremap <expr> <Up> pumvisible()? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible()? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible()? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
let g:ycm_global_ycm_extra_conf='/home/imotor11/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=0
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
"************************* syntastic config *********************"
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=1
let g:syntastic_ignore_files=[".*\.py$"]
"************************* Lookupfile config *********************"
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
if filereadable("./filenamestags")
let g:LookupFile_TagExpr = '"./filenametags"'
endif
nmap <C-l> :LookupFile<CR>

"****************************** cscope config *********************"
if has("cscope")
        set csprg=/usr/bin/cscope
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
endif
" s: Finds all uses of this symbol
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
" g: Finds definition of this symbol
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR> 
" d: Finds calls by this function
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" c: Finds calls to this function
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" t: Find assignments to
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR> 
" e: Find this egrep pattern
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR> 
" f: Opens the filename under the cursor
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR> 
" i: Find files #including this file
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR> 

"************************* miniBufExplor config *******************"
"let g:miniBufExplMapWindowNavVim=1  " ctrl+h/j/k/l
"let g:miniBufExplMapWindowNavArrows=1   " ctrl+arrow
"let g:miniBufExplMapCTabSwitchBufs=1    " ctrl+tab
"let g:miniBufExplMapModeSelTarget=1    " editable window

"************************* Winmanager config *********************"
let g:winManagerWindowLayout = "BufExplorer,TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <slient> <F11> :WMToggle<CR>
"let g:AutoOpenWinmanager = 1

"************************* ctrlspace config ***********************"
let g:airline_exclude_preview=1
let g:CtrlSpaceSearchTiming=500
hi link CtrlSpaceNormal PMenu
hi link CtrlSpaceSelected PMenuSel
hi link CtrlSpaceSearch IncSearch
hi link CtrlSpaceStatus StatusLine

"hi CtrlSpaceSelected_guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=7 cterm=reverse,bold
"hi CtrlSpaceNormal guifg=#839496 guibg=#O21B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=o cterm=NONE
"hi CtrlSpaceSearch guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
"hi CtrlSpaceStatus guifg=#839496 guibg=#oo2b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8
"************************* ctrlp config ***********************"
let g:ctrlp_map='<S-P>'
let g:ctrlp_cmd='CtrlP'
map <S-F> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':'\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file':'\v\.(o|exe|so|dll|zip|tar|tar.gz|pyc)$',
    \}
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
"************************* ctrlp-funky config ***********************"
nnoremap fu :CtrlPFunky<CR>
nnoremap fcu :execute 'CtrlPFunky ' . expand('<cword>')<CR>
let g:ctrlp_funky_syntax_highlight=1
let g:ctrlp_extensions=["funky"]
"************************* NERDCommenter config ***********************"
" comment :  \cc
" uncomment: \cu
" sexily conmment: \cs
" end comment :    \cA  
"************************* Easygrep config ***********************"
let g:EasygrepMode=2
let g:EasygrepCommand=0
let g:EasygrepRecursive=1
let g:EasygrepIgnoreCase=1
let g:EasygrepFilesToExclude="*.bak,*~,cscope.*,*.a,*.o,*.pyc"
"************************* NERDTree config ***********************"
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=30
let g:NERDTredShowLineNumber=1
let g:NERDTreeShowBookmarks=1
nnoremap <S-t> :NERDTree<CR>
"************************* Vim-airline config ***********************"
"let airline_theme='luna'
"let g:airline_theme='dark'
let g:airline_theme='simple' " luna dark cool light 
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif        
let g:airline_symbols.space="\ua0"
let g:airline_exclude_filename=[]
let Powerline_symbols='fancy'
let g:bufferline_echo=0
let g:airline_section_b='%{strftime("%c")}'
let g:airline_section_y='BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extentions#bufferline#enabled=1
let g:airline#extentions#bufferline#overwrite_variables=1
nnoremap <C-N> :bn<CR>
nnoremap <C-M> :bp<CR>
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#whitespace#symbol='!'
"let g:airline_left_sep='>>'
"let g:airline_right_sep='<<'
let g:airline_right_alt_sep = '<'
let g:airline_left_alt_sep = '< '
let g:airline_symbols.linenr='L'
let g:airline_symbols.branch='⑆'
let g:airline_symbols.paste='☻'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_detect_iminsert=0
let g:airline_inactive_collapse=1
let g:airline#extensions#quickfix#quickfix_text='Quickfix'
let g:airline#extensions#quickfix#location_text='Location'
let g:airline#extensions#ctrlp#color_template='insert'
let g:airline#extensions#ycm#enabled=1
"************************* Shortcuts *****************************"
nmap ww :w<CR>			" save
nmap qq :q<CR>			" exit
nmap qw :q!<CR>			" !Q
