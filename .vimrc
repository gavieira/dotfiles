set number 
set linebreak
set hls "Search highlighting
set ic 
set clipboard+=unnaeddplus "use system clipboard
set modeline "file-specific setting changes on first or last line https://www.howtoforge.com/tutorial/vim-modeline-settings/
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

"Markdown previewing with F4
nmap <F4> <Plug>MarkdownPreviewToggle

"Set Rmarkdown to F5 (pdf) and F6 (word) 
nnoremap <silent> <special> <F5> :RMarkdown! pdf<RETURN>
nnoremap <silent> <special> <F6> :RMarkdown! pdf<RETURN>


"Set enter to add newline in normal mode
":nnoremap <ENTER> o<ESC>

"Set vv to esc insert mode - used it instead of jj to avoid conflicts with zsh tab completion usig hjkl 
inoremap vv <ESC>

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

"Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/sedm0784/vim-you-autocorrect.git' "For simple autocorrection

Plug 'preservim/nerdtree' "File browser 

Plug 'ron89/thesaurus_query.vim' "Multi-language Thesaurus 

Plug 'powerline/powerline', {'do': 'python3 ./setup.py build'} "Line with information about mode/file

Plug 'vim-pandoc/vim-rmarkdown'

Plug 'vim-pandoc/vim-pandoc'

Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': 'bash ./install --all' } "fuzzy finder. Has to be installed using bash shell

Plug 'tpope/vim-surround'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
