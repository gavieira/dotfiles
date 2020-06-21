set number 
set linebreak
set hls "Search highlighting
set ic 
set clipboard+=unnaeddplus "use system clipboard
":let g:markdown_folding = 1 
let mapleader = "\<Space>"


""" Powerline
set rtp+=~/.vim/plugged/powerline/build/lib/powerline/bindings/vim
set laststatus=2
set t_Co=256

"Add terminal to bottom
":set splitbelow
":set termwinsize=10x0
":term


"Add NerdTree to left
"autocmd vimenter * NERDTree

"Disable folding for markdown files
autocmd BufNewFile,BufRead *.md set nofoldenable


"Set templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.bash 0r ~/.vim/templates/skeleton.bash
    autocmd BufNewFile *.Rmd 0r ~/.vim/templates/skeleton.Rmd
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
  augroup END
endif

"Set NERDTree to F2
nnoremap <silent> <special> <F2> :NERDTreeToggle<RETURN>

"Set terminal to F3
set splitbelow 
nnoremap <silent> <special> <F3> :! $SHELL<RETURN>

"Set enter to add newline in normal mode
:nnoremap <ENTER> o<ESC>

"Set jj to esc insert mode 
inoremap jj <ESC>

"Set commands to edit and source dotfiles (.vimrc, .tmux.conf, .zhsrc) in a vertical splitted
"window
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>
nnoremap <leader>st :! tmux source-file ~/.tmux.conf<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>sz :! source ~/.zshrc<cr>

"Make j and k go only one wrap in long lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/sedm0784/vim-you-autocorrect.git' "For simple autocorrection

Plug 'preservim/nerdtree' "File browser 

Plug 'ron89/thesaurus_query.vim' "Multi-language Thesaurus 

Plug 'powerline/powerline' "Line with information about mode/file

Plug 'vim-pandoc/vim-rmarkdown'

Plug 'vim-pandoc/vim-pandoc'

Plug 'vim-pandoc/vim-pandoc-syntax'

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()
