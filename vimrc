" ~/.vimrc
set encoding=utf-8 nobomb
scriptencoding utf-8

" Load Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

" Section: Options {{{1
" ---------------------
" autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=indent
let s:darwin = has('mac')

" Leader and localleader (per file type)
let mapleader = ' '
let maplocalleader = ','

set autoindent smartindent
set autoread
set autowrite " Automatically save before commands like :next and :make
set backspace=0 " Disable backspace in insert mode
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif
set clipboard=unnamed " Use the default OS clipboard
set cmdheight=2 " Screen lines used for command line
set colorcolumn=+1
 " Fill the buffer with keywords in
 " the current file, other buffers, imported files, tags
" set complete=.,w,b,u,t,i,]
set cursorline " Highlight current line
set dictionary+=/usr/share/dict/words
set diffopt+=vertical " Always use vertical diffs
set hlsearch
set history=500
 " Ignore case when searching for a pattern
 " but not if one (or more) cap letter is present
set ignorecase smartcase
set incsearch " Incremental search
set laststatus=2 " Always show statusbar
set fixendofline
set nobackup nowritebackup " Remove backup option
set noexpandtab
set nojoinspaces
set noswapfile
set number
set numberwidth=5
set lazyredraw " Do not repaint while executing macros, etc
set linebreak " Visually break lines without inserting EOL
set list lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  let &fillchars = "vert:\u259a,fold:\u00b7"
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif
set relativenumber " Show in column relative number of line
set scrolloff=2
set shiftround
set shiftwidth=2
set showcmd
set showmatch
" if exists("+spelllang")
"   set spelllang=en_us,fr
" endif
" set spellfile=~/.vim/spell/{en,fr}.utf-8.add
set splitbelow " Open new split panes to right
set splitright " and bottom, which feels more natural
set t_Co=256
set tabstop=2
set textwidth=80 " Make it obvious where 80 characters is
set timeoutlen=1200 " A little bit more time for macros
set title " Show the filename in the window titlebar
set ttimeoutlen=50  " Make Esc work faster
set ttyfast " Optimize for fast terminal connections
if exists('+undofile')
  set undodir=~/.local/share/vim/undo
  set undofile " Enable persistent undo
endif
set wildmenu
set wildmode=longest:full,full
set wildignore+=tags,.*.un~,*.pyc

" }}}1
" Section: Plugin Settings {{{2
" -----------------------

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
nnoremap <Leader>ln :ALENextWrap<CR>
nnoremap <Leader>lp :ALEPreviousWrap<CR>
nnoremap <leader>lf :ALEFix<CR>

autocmd FileType html.handlebars let g:ale_javascript_prettier_options = '--parser=glimmer'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'html': ['prettier'],
\   'html.handlebars': ['prettier'],
\   'markdown': ['prettier'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'html': [''],
\   'html.handlebars': ['ember-template-lint'],
\}

let g:ale_sign_error = '🍄'
let g:ale_sign_warning = '🙀'

" ----------------------------------------------------------------------------
" editorconfig-vim
" ----------------------------------------------------------------------------
" Recommended setting for EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------
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

" Map leader+n to toggle NERDtree
map <leader>n :NERDTreeToggle<CR>
" Map Leader+m to Reveal current file in NERDTree
nnoremap <leader>m :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" vim-javascript
" ----------------------------------------------------------------------------
let g:javascript_plugin_jsdoc = 1

" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" ----------------------------------------------------------------------------
" vim-easy-align
" ----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------------
let g:gitgutter_sign_added = '🔹'
let g:gitgutter_sign_modified = '🔸'
let g:gitgutter_sign_removed = '🔺'

" ----------------------------------------------------------------------------
" vim-test
" ----------------------------------------------------------------------------
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tv :TestVisit<CR>

nnoremap \ :GFiles<ENTER>

set runtimepath+=/usr/local/opt/fzf " add fzf support

" Enabable omnifunction
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
" set omnifunc=syntaxcomplete#Complete

" Enable solarized colorscheme
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
" colorscheme solarized

" Enable seoul256 colorscheme
syntax enable
let g:seoul256_background = 233
colorscheme seoul256

" Enable vim-mustache-handlebars abbrev
let g:mustache_abbreviations = 1

" Add comments to vim-handlebars
autocmd FileType html.handlebars setlocal commentstring={{!--%s--}}

" }}}2
" Section: Mappings {{{3
" ----------------------

" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Search and replace the word under the cursor
nnoremap <Leader>sw :%s/\<<C-r><C-w>\>/

" Map C-l to right arrow keys in insert mode
inoremap <C-l> <right>

" Quickly edit and save vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Switch buffer to right or left
nnoremap <C-Left> :sbnext<CR>
nnoremap <C-Right> :sbprevious<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
if s:darwin
  nnoremap <silent> Ï :move .+1<CR>==
  nnoremap <silent> È :move .-2<CR>==
  inoremap <silent> Ï <Esc>:move .+1<CR>==gi
  inoremap <silent> È <Esc>:move .-2<CR>==gi
  vnoremap <silent> Ï :move '>+1<CR>gv=gv
  vnoremap <silent> È :move '<-2<CR>gv=gv
else
  xnoremap <silent> <A-j> :move'>+<cr>gv
  xnoremap <silent> <A-k> :move-2<cr>gv
endif

" ----------------------------------------------------------------------------
" Saving and quitting
" ----------------------------------------------------------------------------
" Add `stty -ixon` in your `zshrc` or `bashrc`
" to disable terminal's flow control
"
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif

nnoremap <silent> <C-s> :<C-u>Update<CR>
inoremap <C-s> <c-o>:Update<CR>
vnoremap <C-s> <esc>:Update<CR>gv
nnoremap <silent> <C-q> :q<CR>

nnoremap <silent><CR><CR> :nohl<CR>

" }}}3
" ============================================================================
" LOCAL VIMRC {{{4
" ============================================================================
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" }}}4

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
