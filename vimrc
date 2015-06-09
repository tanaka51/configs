set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'glidenote/memolist.vim'
Plugin 'glidenote/octoeditor.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'h1mesuke/vim-alignta'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'justinmk/vim-dirvish'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'w0ng/vim-hybrid'

call vundle#end()
filetype plugin indent on

set ambiwidth=double
set clipboard+=unnamed,autoselect
set encoding=utf-8
set et
set foldlevel=4
set hls
set incsearch
set number
set smartcase
set smartindent
set sw=2
set t_Co=256
set t_ut=
set ts=2
set undofile

noh

let mapleader = " "

noremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap ; :
nnoremap : ;

nnoremap <silent><leader>j :JunkFile<CR>

nnoremap <silent><Leader>mn :MemoNew<CR>
nnoremap <silent><Leader>mf :exe "CtrlP" g:memolist_path<CR><f5>
nnoremap <silent><Leader>mg :MemoGrep<CR>

nnoremap <silent><Leader>on :OctopressNew<CR>
nnoremap <silent><Leader>ol :OctopressList<CR>
nnoremap <silent><Leader>of :exec "CtrlP" g:octopress_path . "/source/_posts"<CR>
nnoremap <silent><Leader>og :OctopressGrep<CR>
nnoremap <silent><Leader>,og :OctopressGenerate<CR>
nnoremap <silent><Leader>,od :OctopressDeploy<CR>

nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>

nnoremap <silent><Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <silent><Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"" filetype
au BufNewFile,BufRead *.jbuilder setf ruby
au BufNewFile,BufRead *.rabl setf ruby

"" colorschema
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

"" %% expamds to %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

let g:ctrlp_extensions = ['quickfix', 'funky']

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

"" octoeditor.vim
let g:octopress_path = "~/src/github.com/tanaka51/tanaka51.github.com"
let g:octopress_bundle_exec = 1

"" memolist.vim
let g:memolist_path = "~/Dropbox/memo"

"" vim-ctrlp-tjump
let g:ctrlp_tjump_only_silent = 1

" c.f. http://celt.hatenablog.jp/entry/2014/07/11/205308
" ag入ってたらagで検索させる
" ついでにキャッシュファイルからの検索もさせない
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif

"" gist-vim
let g:gist_detect_filetype = 1