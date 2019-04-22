" Samuel's vimrc
let mapleader =","

"==========[ PLUGINS]=========="
                " safety check for plugged
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p ~/.config/nvim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vifm/vifm.vim'
Plug 'w0rp/ale'
call plug#end()

"=====[ ALE ]====="
                " fix files on save
let g:ale_fix_on_save = 1

"=====[ Goyo ]====="
                " makes text more readable when writing prose
map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
                " enable Goyo by default for mutt writting,
                " goyo's width will be the line limit in mutt.
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

"=====[ NERD Tree ]====="
                " toggle nerdtree
map <leader>n :NERDTreeToggle<CR>
                " configuration for nerdtree window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"=====[ vimwiki ]====="
                " ensure files are read properly (part 1)
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

"==========[ Global Config ]=========="
                " character encoding: UTF-8
set encoding=utf-8
                " hybrid relative line numbers e.g. [3,2,1,26,1,2,3]
set number relativenumber
                " syntax highlighting (can be really trash)
                " TODO map `syntax off`
syntax on
                " splits open at the bottom and right
set splitbelow splitright

"=====[ Colour ]====="
set bg=light    " mostly for syntaxhl & contrast with my term setup
                " 81st column with text will pop
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v',100)

"=====[ Search ]====="
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
                " turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"=====[ Generic Remaps ]====="
                " obligatory controversial esc remap
inoremap jk <Esc>
inoremap kj <Esc>
                " why waste time using shift
noremap ; :
                " move vertically by visual line
nnoremap j gj
nnoremap k gk
                " move to beginning/end of line
nnoremap B ^
nnoremap E $
                " $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

"=====[ Whitespace ]====="
set tabstop=4   " number of visual spaces per TAB
                " number of spaces in tab when editing
set softtabstop=4
set expandtab   " tabs are spaces
                " '>>' indents are 4 spaces
set shiftwidth=4
                " sith whitespace detection
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
                " deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

"==========[ File Config ]=========="
                " TODO find out what this means
filetype plugin on
                " disable auto comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
                " compile document (groff/LaTeX/markdown/etc)
map <leader>c :w! \| !compiler <c-r>%<CR>
                " open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>
                " cleans out tex build files upon quit of .tex
autocmd VimLeave *.tex !texclear %
                " ensure files are read properly (part 2)
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

"=====[ shstsk ]====="
" super handy shortcuts to save keystrokes
" TODO make this programmatic
                " latex
source ~/.config/nvim/fileconfig/latex.vim
                " html
source ~/.config/nvim/fileconfig/html.vim
                " markdown
source ~/.config/nvim/fileconfig/markdown.vim
                " bib (bibliography)
source ~/.config/nvim/fileconfig/bib.vim
                " xml
source ~/.config/nvim/fileconfig/xml.vim

"==========[ Pending Organisation ]=========="
                " TODO find out what this means
set go=a
                " TODO find out what this means
set mouse=a
                " TODO find out what this means
set clipboard=unnamedplus
                " TODO find out what this means
nnoremap c "_c
set nocompatible
                " enable autocompletion
set wildmode=longest,list,full
                " spell-check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>
                " shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

                " check file in shellcheck:
map <leader>s !clear && shellcheck %<CR>

                " open my bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

                " replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

                " copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P
                " when shortcut files are updated, renew shortcuts
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

                " when Xdefaults/Xresources are updated, run xrdb
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

                " navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l
