source ~/.vim/bundles.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Basic Setting
""""""""""""""""""""""""""""""
syntax on " auto highlight grammar
set number " display line num
set relativenumber " display relate line number
set hlsearch " highlight search result
set incsearch " display search result when search
set cursorline " highlight current line
set ignorecase smartcase " ignore case when no upper case, case sensitive when upper case
set ff=unix
set ts=4
set history=10000
set shiftwidth=4
"back to reviews
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Key Remap
""""""""""""""""""""""""""""""
" nmap(noremap): no recursion map
" Command Normal Visual Insert Command_Line Operator_Pending
" :map      Y      Y                            Y
" :nmap     Y
" :vmap            Y
" :map!                   Y         Y
" :imap                   Y
" :cmap                             Y
" :omap                                         Y


" Map space as hot key
nmap <space> <leader>
" led mapleader = " "
" led mapleader=<space>

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa

" map save and quit
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>wq :wq<cr>


" Keybindings for plugin toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap <F3> :GundoToggle<cr>
" nmap <F4> :IndentGuidesToggle<cr>
nmap <F5> :TagbarToggle<cr>
let g:ctrlp_map = '<F6>'
"nmap <F7> :call Runshell("Generate tags","ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")<cr>
" nmap <F7> :call Runshell("Generate tags","gtags")<cr>
nmap <F7> :call GenGtagsFile()<cr><cr>
" nmap <F8> :call Runshell("Generate cscope","cscope -Rbk")<cr>:cs reset<cr><cr>
" can't update from gtags.files
" nmap <F8> :call Runshell("Generate gtags","global -u")<cr>:cs reset<cr><cr>: echo "globl update done ..." <cr>
nmap <F9> :NERDTreeToggle<cr>
nmap <F10> :vsplit<CR>
" used for toggle mouse
" nmap <F12> :vsp<cr>
nmap  <D-/> :

" vertical resize
nmap <leader>] :vertical resize +4<cr>
nmap <leader>[ :vertical resize -4<cr>

" gtags cscope
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" nmap <leader>b :execute 'b' v:count<cr>

"commit key "="
map <leader>= I/* A */j
map <leader>- ^xxx$xxx


"auto complete the partner and move cursor to the middle in INSERT mode
:inoremap ) ()<Esc>i
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap } {}<Esc>i
:inoremap [ []<Esc>i
:inoremap ] []<Esc>i
:inoremap < <><Esc>i
:inoremap > <><Esc>i
:inoremap ' ''<Esc>i

"[Ctrl]+[hjkl] to move code block
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Functions
""""""""""""""""""""""""""""""
function! Runshell(Msg, Shell)
    echo a:Msg . '...'
    call system(a:Shell)
    echon 'done'
endfunction

function! GenGtagsFile()
	call Runshell("GenGtagsFileList", "find $PWD -path \"$PWD/bootloader*\" -prune -o -name \"*.[chxsS]\" -print >$PWD/gtags.files")
	call Runshell("GenGtagsFiles", "gtags -f $PWD/gtags.files")
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Cscope Setting
""""""""""""""""""""""""""""""
set tags+=tags;
" set autochdir
set cscopetag
if has("cscope")
        set csto=1
        set cst
        set csverb
        set cspc=3

" use gtags instead of ctags
        set csprg=/usr/local/bin/gtags-cscope
        if filereadable("GTAGS")
           silent cs add GTAGS
        else
           let cscope_file=findfile("GTAGS", ".;")
           let cscope_pre=matchstr(cscope_file, ".*/")
           if !empty(cscope_file) && filereadable(cscope_file)
                exe "silent cs add" cscope_file
           endif
        endif

" use ctags instead of gtags
        " set csprg=/usr/bin/cscope
        " if filereadable("cscope.out")
        "    cs add cscope.out
        " else
        "    let cscope_file=findfile("cscope.out", ".;")
        "    let cscope_pre=matchstr(cscope_file, ".*/")
        "    if !empty(cscope_file) && filereadable(cscope_file)
        "         exe "cs add" cscope_file cscope_pre
        "    endif
        " endif
endif

"set cscopequickfix=s-,c-,d-,i-,t-,e-
":cs find s /*Find this C symbol:
":cs find g /*Find this function definition:
":cs find   /*Find functions called by this function:
":cs find c /*Find functions calling this function:
":cs find t /*Find this text string:
":cs find   /*Change this text string:
":cs find e /*Find this egrep pattern:
":cs find f /*Find this file:
":cs find i /*Find files #including this file:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
"omnicppcomplete.vim configure
""""""""""""""""""""""""""""""
" Bundle 'omnicppcomplete.vim'
set completeopt=menu,menuone
let OmniCpp_MayCompleteDot=1    "open  . operate
let OmniCpp_MayCompleteArrow=1  "open -> operate
let OmniCpp_MayCompleteScope=1  "open :: operate
let OmniCpp_NamespaceSearch=1   "open name space
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DefaultNamespace=["std"]
let OmniCpp_ShowPrototypeInAbbr=1  "display function prototype
let OmniCpp_SelectFirstItem = 2    "jump to first item when auto popup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
"gtags.vim configure
""""""""""""""""""""""""""""""
let g:Gtags_OpenQuickfixWindow = 1
"default open window in under window
let g:Gtags_VerticalWindow =  1
"sprindy: not use gtags.vim config.
let g:Gtags_Auto_Map = 0
" let g:Gtags_Auto_Update = 0
"
" multiwindow gtags configure
"
let No_Gtags_Multi_Window_Auto_Map = 0
let loaded_gtags_multi_window = 1

" gtags search
"nmap <F2> :Gtags -gi<CR>
"search word in all project files
"nmap <A-e> :Gtags -gi<cr><cr><cr>*.[ch]<cr>
"jump to function define
"nmap <C-[> :Gtags<CR>
"search "search function call
"nmap <A-r> :Gtags -r<CR>

"noremap <A-.> :Gtags<CR>
"noremap <A-r> :Gtags -r<CR>
"noremap <A-o> :Gtags -s<CR>
"noremap <A-g> :Gtags -g<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Tagbar, better than taglist
""""""""""""""""""""""""""""""
" Bundle 'majutsushi/tagbar'
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" tag for coffee
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }

  let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'sort' : 0,
    \ 'kinds' : [
        \ 'h:sections'
    \ ]
    \ }
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Nerd Tree: file system explorer
""""""""""""""""""""""""""""""
" Bundle 'scrooloose/nerdtree'
" I.......Toggle whether hidden files displayed
" F.......Toggle whether files are displayed
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
" let NERDTreeIgnore=['.d$[[dir]]', '.o$[[file]]']
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.exe$', '\.o$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" MiniBufExplore
""""""""""""""""""""""""""""""
" Bundle 'minibufexpl.vim'
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" CtrlP
""""""""""""""""""""""""""""""
" Bundle 'ctrlpvim/ctrlp.vim'
" let g:ctrlp_map = '<F6>'
" let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_regexp = 1
let g:ctrlp_by_filename = 1
" Open CtrlP in find Most-Recently-Used file mode.
" mark.vim already used "<leader>r"
map <leader>cr :CtrlPMRU<CR>
"     'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|o)$',
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|repo|hg|svn|rvm)$',
    \ 'file': '\v(\.c|\.h|\.hh|\.s|\.cpp|\.cxx|\.java)@<!$'
    \ }
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" Ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" nerdcommenter
""""""""""""""""""""""""""""""
let NERDSpaceDelims=1
" nmap <D-/> :NERDComToggleComment<cr>
let NERDCompactSexyComs=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" ack replaced by ag.vim
""""""""""""""""""""""""""""""
" nnoremap <leader>a :Ack
" ag tool : sudo apt-get install silversearcher-ag
" let g:ackprg = 'ag --nogroup --color --column'
if executable('ag')
    let g:ackprg = 'ag --vimgrep --color --column'
endif

" nnoremap <leader>v V`]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" replaced with CtrlP
" """"""""""""""""""""""""""""""
" Bundle 'lookupfile'
" "let g:LookupFile_MinPatLength = 2              "start search when more than 2 letters
" let g:LookupFile_PreserveLastPattern = 0        "give up last search string
" let g:LookupFile_PreservePatternHistory = 1     "save search history
" let g:LookupFile_AlwaysAcceptFirst = 1          "open the first itme with enter
" "use cscope tags
" let g:LookupFile_AllowNewFiles = 0              "not allow create new file
" if filereadable("./filenametags")
" 	let g:LookupFile_TagExpr = '"./filenametags"'
" endif
" "remap LookupFile to lk
" nmap <silent> <leader>lk :LUTags<cr>
" "remap LUBufs to ll
" nmap <silent> <leader>ll :LUBufs<cr>
" "remap LUWalk to lw
" nmap <silent> <leader>lw :LUWalk<cr>
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{
" Taglist, replace by Tagbar
""""""""""""""""""""""""""""""
""Bundle 'taglist.vim'
""let Tlist_Auto_Open=1				   "open taglist when run vim.
"let Tlist_Show_One_File=1			   "only display current window's tag
"let Tlist_Exit_OnlyWindow=1		   "exit vim when taglist is the last window
"let Tlist_Ctags_Cmd="/usr/bin/ctags"  "relate taglist with ctags
"let Tlist_WinWidth=40				   "set taglist width size.
"let Tlist_Use_SingleClick=1		   "enable mouse click
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}

