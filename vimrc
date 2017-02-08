set nocompatible

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'bronson/vim-trailing-whitespace'
Plug 'cespare/vim-toml'
Plug 'cocopon/vaffle.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gmarik/Vundle.vim'
Plug 'itchyny/lightline.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'racer-rust/vim-racer'
Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim'
Plug 'slim-template/vim-slim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'thinca/vim-quickrun'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'
Plug 'w0ng/vim-hybrid'

call plug#end()

set ambiwidth=double
set clipboard+=unnamed,autoselect
set encoding=utf-8
set et
set foldlevel=4
set hidden
set hls
set incsearch
set laststatus=2
set number
set shiftwidth=2
set smartcase
set smartindent
set splitright
set t_Co=256
set t_ut=
set tabstop=2
set timeout timeoutlen=500
set ts=2
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
" vmap <Leader>y "+y
" vmap <Leader>d "+d
" nmap <Leader>p "+p
" nmap <Leader>P "+P
" vmap <Leader>p "+p
" vmap <Leader>P "+P

"" filetype
au BufNewFile,BufRead *.jbuilder setf ruby
au BufNewFile,BufRead *.rabl setf ruby

"" colorschema
syntax enable
set background=dark
colorscheme hybrid

"" %% expands to %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

let g:ctrlp_extensions = ['quickfix', 'funky']
let g:ctrlp_max_height = 30
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
    let l:path = expand('%:t:r')
    let l:path = substitute(l:path, "_spec", "", "")
    let g:ctrlp_default_input = l:path

    call ctrlp#init(0)
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

"" typescript tsx
autocmd BufNewFile,BufRead *.{ts,tsx} set filetype=typescript

"" racer
set hidden
let g:racer_cmd = "$HOME/src/github.com/phildawes/racer/target/release/racer"
let $RUST_SRC_PATH="/home/tanaka51/src/github.com/rust-lang/rust/src"

"" rspec
let g:rspec_command = "Dispatch bundle exec rspec {spec}"
nmap <silent><leader>rc :call RunCurrentSpecFile()<CR>
nmap <silent><leader>rn :call RunNearestSpec()<CR>
nmap <silent><leader>rl :call RunLastSpec()<CR>
nmap <silent><leader>ra :call RunAllSpecs()<CR>

set tags+=tags,Gemfile.lock.tags,schema.tags
