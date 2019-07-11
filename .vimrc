"----------------------------------------
" Start general configurations
"----------------------------------------
set term=screen-256color "ensure color compatibility matches tmux
set nocompatible " don't lose new vim features due to compatibility
set ts=2 sw=2 et " 2 space tabs (tabstop=2, shiftwidth=2, expandtab=true)
set autoindent "Always autoindent
set hlsearch " highlight search terms
set incsearch " show search while typing it
set smartcase " ignore case if search is lc, sensitive otherwise
set showmatch " set show matching parenthesis
set mouse=a " Allow mouse scrolling (peer programming)
set backspace=indent,eol,start " Allow backspace to work normally
set number " Turn on line numbers
set laststatus=2 " Always show statusline
set list "Show invisible characters, next line specifies characters
set belloff=all "Turn off the annoying audible error bell
set listchars=eol:¬,nbsp:¤,space:⋅,trail:•,tab:››,extends:…,precedes:…,conceal:‡
set rtp+=~/.vim/bundle/Vundle.vim/ " set runtime path to use vundle for plugins

"----------------------------------------
" Start Vundle and loading plugins
"----------------------------------------
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "Best plugin management for vim
Plugin 'tpope/vim-rails' "Quick navigation in rails projects
Plugin 'pangloss/vim-javascript' "Better tabbing in javascript
Plugin 'othree/yajs.vim' "ES2015+ javascript support
Plugin 'othree/html5-syntax.vim' "Good html5 syntax support
Plugin 'moll/vim-node' "Allows gf/gF on relative node paths
Plugin 'kchmck/vim-coffee-script' "Coffeescript syntax
Plugin 'mtscout6/vim-cjsx' "Coffeescript JSX (CJSX)
Plugin 'slim-template/vim-slim' "Slim templating for Rails
Plugin 'digitaltoad/vim-pug' "Jade/Pug templating for Node
Plugin 'wavded/vim-stylus' "Stylus preprocessor for css
Plugin 'airblade/vim-gitgutter' "See git + / - / ~ in gutter
Plugin 'thaerkh/vim-workspace' "session save and load features
Plugin 'scrooloose/nerdtree' "File management
Plugin 'Xuyuanp/nerdtree-git-plugin' "Shows modifications in nerdtree
Plugin 'itchyny/lightline.vim' "pretty statusline
Plugin 'hail2u/vim-css3-syntax' "Support for latest css3
Plugin 'myusuf3/numbers.vim' "Shows relative line numbers on normal mode
Plugin 'ctrlpvim/ctrlp.vim' "Fuzzy file finder
Plugin 'scrooloose/nerdcommenter' "Allows commenting of lines easier
Plugin 'ap/vim-buftabline' "Allows the buffers as tabs
Plugin 'easymotion/vim-easymotion' "Allows quick movement around vim
Plugin 'chr4/nginx.vim' "nginx sytax support
Plugin 'arcticicestudio/nord-vim' "color scheme
call vundle#end()

filetype plugin indent on " Plugins default to indent

"---------------------------------------
" Reconfigure Plugin Options
"---------------------------------------
let g:lightline = {'colorscheme': 'nord'}
let g:lightline.separator = { 'left': '', 'right': '' }
let NERDTreeQuitOnOpen = 1
let g:gitgutter_sign_added="++"
let g:gitgutter_sign_modified="~~"
let g:gitgutter_sign_removed="--"
let g:gitgutter_max_signs=3000
let g:ctrlp_map = '<c-p>' " ctrl+p starts plugin
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra' " start nearest search dir @ root .git
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
"---------------------------------------
" Keyboard mappings
"---------------------------------------
let mapleader="\<Space>"

" Session management
nnoremap <leader>s :ToggleWorkspace<CR>

" Open nerdtree and then open current file location in nerdtree
nmap \ :NERDTreeToggle<CR>
nmap <leader>\ :NERDTreeFind<CR>

" New buffers, quitting buffers
nmap <leader>T :enew<CR>
nmap <leader>bl :bnext<CR>
nmap <leader>bh :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bs :ls<CR>
nmap <leader>nj :rightbelow sb #<CR>
nmap <leader>nk :leftabove sb #<CR>
nmap <leader>nh :vert leftabove sb #<CR>
nmap <leader>nl :vert rightbelow sb #<CR>

" Indicate color code under cursor
nmap <leader>z :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Selecting, making and resizing windows
nnoremap <leader>j <C-w>j
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>mk <C-w>K
nnoremap <leader>mj <C-w>K<C-w>r
nnoremap <leader>mh <C-w>H
nnoremap <leader>ml <C-w>H<C-w>r
nnoremap <leader>sk :res +5<CR>
nnoremap <leader>sj :res -5<CR>
nnoremap <leader>sh :vertical res -5<CR>
nnoremap <leader>sl :vertical res +5<CR>
nnoremap j gj
nnoremap k gk

"---------------------------------------------
" Color scheme configuration
"---------------------------------------------
syntax on "Make sure syntax highlighting is on
colorscheme nord
hi BufTabLineCurrent ctermfg=16 ctermbg=6 cterm=NONE
hi BufTabLineHidden ctermfg=8 ctermbg=NONE cterm=NONE
hi BufTabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
