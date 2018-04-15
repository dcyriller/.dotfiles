" ~/.vimrc

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

let s:darwin = has('mac')

" Leader and localleader (per file type)
let mapleader=" "
let maplocalleader=","

" Section: Options {{{1
" ---------------------

set autoindent smartindent
set autoread
set autowrite " Automatically save before commands like :next and :make
set backspace=0 " Disable backspace in insert mode
set clipboard=unnamed " Use the default OS clipboard 
set cmdheight=2 " Screen lines used for command line
set colorcolumn=+1
 " Fill the buffer with keywords in
 " the current file, other buffers, imported files, tags
set complete=.,w,b,u,t,i,]
set cursorline " Highlight current line
set dictionary+=/usr/share/dict/words
set diffopt+=vertical " Always use vertical diffs
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set hlsearch
 " Ignore case when searching for a pattern
 " but not if one (or more) cap letter is present
set ignorecase smartcase
set incsearch " Incremental search
set laststatus=2 " Always show statusbar
set nobackup nowritebackup " Remove backup option
set nojoinspaces
set noswapfile "http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
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
set showcmd
set showmatch

" if exists("+spelllang")
"   set spelllang=en_us,fr
" endif

" set spellfile=~/.vim/spell/{en,fr}.utf-8.add
set splitbelow " Open new split panes to right
set splitright " and bottom, which feels more natural
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

let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
set completefunc=emoji#complete

set rtp+=/usr/local/opt/fzf " add fzf support

" Enabable omnifunction
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
set omnifunc=syntaxcomplete#Complete

" Thoughtbot additions

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

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
"

" Configure vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Enable vim-mustache-handlebars abbrev
let g:mustache_abbreviations = 1

" Map leader+m to toggle NERDtree
map <leader>n :NERDTreeToggle<CR>
" Map Leader+n to Reveal current file in NERDTree
nnoremap <leader>m :NERDTreeFind<CR>

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

" Map C-l to right arrow keys in insert mode
imap <C-l> <right>

" ExTest.vim mappings
map <Leader>et :call RunCurrentTestFile()<CR>
map <Leader>es :call RunNearestTest()<CR>
map <Leader>el :call RunLastTest()<CR>
map <Leader>eta :call RunAllTests()<CR>

map <Leader>l :ALENext<CR>
