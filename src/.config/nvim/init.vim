" ================== Plugins ===============================
call plug#begin()

" File explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Status line
Plug 'itchyny/lightline.vim'

" Themes
Plug 'arcticicestudio/nord-vim'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

" Git support
Plug 'tpope/vim-fugitive'

" Autosave
Plug 'vim-scripts/vim-auto-save'

" Auto switch input method
Plug 'rlue/vim-barbaric'

" Commenter
Plug 'preservim/nerdcommenter'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Language Protocol Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" ================== Preferences ===========================
filetype plugin indent on               " Indent settings for each file type
syntax enable                           " Enable syntax
set clipboard=unnamedplus               " Interact with system clipboard
set mouse=a                             " Enable mouse
set number                              " Show line number
set tabstop=4 shiftwidth=4              " Set tab size
set expandtab                           " Use spaces instead of tabs
set autoindent smartindent              " Enable smart indent
set cursorline                          " Highlight current line
set wrap!                               " Disable line wrap by default

" ================== Nord themes ===========================
" Highlight current line number
let g:nord_cursor_line_number_background = 1
" Enable active-inactive status line
let g:nord_uniform_status_lines = 1
" Enable bold and italic
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1

silent! colorscheme nord                " Set theme
" set termguicolors                       " Use colors from terminal

" ================== Keys mapping ==========================
" Map leader
let mapleader = ","

" Save, quit, normal mode, help
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
inoremap jj <Esc>
inoremap ,, <Esc>
noremap <Leader>h :vert h 

" Move between windows
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

" Toggle line wrap
nnoremap <Leader>z :set wrap!<CR>

" Turn off search highlight temporarily
nnoremap <Leader><space> :nohlsearch<CR>

" Toggle termguicolors (to use transparency from terminal)
nnoremap <Leader>t :set termguicolors!<CR>

" ================== File Explorer =========================
" Fix highlight current line issue
hi CursorLine ctermfg=white

" Automatically open NERDTree
autocmd StdinReadPre * let s:std_in = 1 " Detect if using stdin
function! s:startNerdTree()
    if !exists('s:std_in')              " Skip if using stdin
        " First argument is directory
        if argc() > 0 && isdirectory(argv()[0])
            " Change working directory
            exec 'cd' argv()[0]
            NERDTree                    " Open NERDTree
            wincmd p | quit!            " Close the duplicated
        endif
    endif
endfunction
autocmd VimEnter * call s:startNerdTree()

" Preferences
let NERDTreeMinimalUI = 1               " Use mininal UI
let NERDTreeShowHidden = 1              " Show hidden files 

" Exclude files and folders
let NERDTreeIgnore = ['\.git']

" Toggle NERDTree bar
nnoremap <Leader>b :NERDTreeToggle<CR>

" Expand and collapse NERDTree node
let NERDTreeMapActivateNode='l'

" ================== Status line ===========================
" No need to show mode
set noshowmode

" Customize status line
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ ],
    \              [ 'lineinfo', 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component': {
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
\ }

" Powerline symbol for read-only file
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

" Powerline symbol and fugitive for git branch
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

" ================== Autosave ==============================
" Enable autosave
let g:auto_save = 1

" ================== Default input =========================
" Input method and layout for normal mode
let g:barbaric_default = 'xkb:us::eng'

" ================== Commenter =============================
" Toggle comment
nmap <Leader>C <Plug>NERDCommenterToggle
vmap <Leader>C <Plug>NERDCommenterToggle

" ================== Markdown Preview ======================
" Prevent automatically close when change buffer
let g:mkdp_auto_close = 0

" Toggle markdown preview
nmap <Leader>m <Plug>MarkdownPreviewToggle

" Preview in Chromium instead of Chrome
let g:mkdp_browser = '/usr/bin/chromium' 
