" Enable filetype to be known by vim and indentations to be set per type in after/ftplugin
filetype plugin indent on

" add fzf support 
set rtp+=/usr/local/opt/fzf

" Enable persistent undo
set undodir=~/.local/share/vim/undo
set undofile

" Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-unimpaired'
" Plugin 'tpope/vim-abolish'
" Plugin 'tpope/vim-projectionist'
" Plugin 'tpope/vim-bundler'
" Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-rake'

" Plugin 'junegunn/limelight.vim'
" Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/vim-peekaboo'
" Plugin 'junegunn/gv.vim'

" Leader and localleader (per file type)
let mapleader=" "
let maplocalleader=","

set mouse=a

" Enabable omnifunction
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
set omnifunc=syntaxcomplete#Complete
" Fill the buffer with keywords in the current file, other buffers, imported files, tags
set complete=.,w,b,u,t,i,]
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Highlight current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Indentation without tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" Show the filename in the window titlebar
set title
" Show in column relative number of line
set relativenumber
" Show the (partial) command as it’s being typed
set showcmd

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Remove backup option
set nobackup
set nowritebackup
set noswapfile "http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Thoughtbot additions
set history=50
set showcmd " display incomplete commands
set autowrite " Automatically :write before running commands

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Hightlight searches
set hlsearch
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command=['ag -Q -l --nocolor --hidden -g "" %s']
  let g:ctrlp_user_command += ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" use ctrl + c to copy to system clipboard
vnoremap <C-c> "+y

" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Search and replace the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>
" Treat <li> and <p> tags like the block tags they are
" let g:html_indent_tags = 'li\|p'

" Always use vertical diffs
set diffopt+=vertical
" End of Thoughtbot additions

" Enable solarized colorscheme
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
" colorscheme solarized

" Enable seoul256 colorscheme
syntax enable
let g:seoul256_background = 233
colo seoul256

" Enable line numbers
set number
" Allow backspace in insert mode
set backspace=indent,eol,start
" Ignore case when searching for a pattern, but if one (or more) cap letter is
" present 
set ignorecase smartcase

" Status Line
set laststatus=2 " always show statusbar

" Enable line numbers
" Configure vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Enable vim-mustache-handlebars abbrev
let g:mustache_abbreviations = 1

" Map leader+m to toggle NERDtree
map <leader>n :NERDTreeToggle<CR>
" Map Leader+n to Reveal current file in NERDTree
nnoremap <leader>m :NERDTreeFind<CR>

" nvim-completion-manager
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Configure NERDtree to be opened on start if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if NERDtree is the last opened window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Configure vim-javascript
let g:javascript_plugin_jsdoc = 1

" Add comments to vim-handlebars
autocmd FileType html.handlebars setlocal commentstring={{!--%s--}}

" Recommended setting for EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch buffer to right or left
nnoremap <C-Left> :sbnext<CR>
nnoremap <C-Right> :sbprevious<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Don't navigate in file using arrow keys !
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>
set backspace=0

" Map C-l to right arrow keys in insert mode
imap <C-l> <right>

" ExTest.vim mappings
map <Leader>et :call RunCurrentTestFile()<CR>
map <Leader>es :call RunNearestTest()<CR>
map <Leader>el :call RunLastTest()<CR>
map <Leader>eta :call RunAllTests()<CR>

map <Leader>l :ALENext<CR>
