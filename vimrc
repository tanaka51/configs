set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'cespare/vim-toml'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/vim-easy-align'
Plugin 'justinmk/vim-dirvish'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mxw/vim-jsx'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pangloss/vim-javascript'
Plugin 'racer-rust/vim-racer'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'thinca/vim-quickrun'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'w0ng/vim-hybrid'

call vundle#end()
filetype plugin indent on

set ambiwidth=double
set clipboard+=unnamedplus
set encoding=utf-8
set et
set foldlevel=4
set hidden
set hls
set incsearch
set number
set shiftwidth=2
set smartcase
set smartindent
set t_Co=256
set t_ut=
set tabstop=2
set undofile

noh

nnoremap ; :
nnoremap : ;

let mapleader = " "

noremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <silent><leader>j :JunkFile<CR>
nnoremap <silent><leader>q :QuickRun<CR>
nnoremap <silent><leader>cb :Dispatch cargo run<CR>

nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>

nnoremap <silent><Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <silent><Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR><CR>

nnoremap <silent><Leader>s :CtrlPSwitcher<CR>

vnoremap <silent> <Enter> :EasyAlign<cr>

"" copy & paste to system
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"" filetype
au BufNewFile,BufRead *.jbuilder setf ruby
au BufNewFile,BufRead *.rabl setf ruby

"" colorschema
syntax enable
set background=dark
colorscheme hybrid

"" %% expamds to %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

let g:ctrlp_extensions = ['quickfix', 'funky']
let g:ctrlp_max_height = 50
"" vim-ctrlp-tjump
let g:ctrlp_tjump_only_silent = 1

"" vim-indent-guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg = 234
hi IndentGuidesEven ctermbg = 16
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_gides_size            = $tabstop

"" matchit
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

"" CtrlP with current filename
command! -nargs=0 CtrlPSwitcher call s:ctrlp_switcher()
function! s:ctrlp_switcher()
  try
    let default_input_save = get(g:, 'ctrlp_default_input', '')
    let g:ctrlp_default_input = expand('%:t:r')

    call ctrlp#init(g:ctrlp_builtins)
  finally
    if exists('default_input_save')
      let g:ctrlp_default_input = default_input_save
    endif
  endtry
endfunction!

"" Open Junk File
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction

" c.f. http://celt.hatenablog.jp/entry/2014/07/11/205308
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif

"" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = {
  \ 'outputter/buffer/split' : 'below 8sp',
  \ }

"" racer
set hidden
let g:racer_cmd = "$HOME/src/github.com/phildawes/racer/target/release/racer"
let $RUST_SRC_PATH="/home/tanaka51/src/github.com/rust-lang/rust/src"
