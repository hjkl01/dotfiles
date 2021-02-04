call plug#begin('~/.config/nvim/plugged')

Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdcommenter' " 注释
Plug 'dstein64/nvim-scrollview'

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch (recommend)

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" Plug 'autozimu/LanguageClient-neovim', {
"             \ 'branch': 'next',
"             \ 'do': 'bash install.sh',
"             \ }
" " (Optional) Multi-entry selection UI.
" Plug 'junegunn/fzf'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'davidhalter/jedi-vim'
" Plug 'Valloric/YouCompleteMe', { 'do': 'git submodule update --init --recursive && python install.py' }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'lighttiger2505/deoplete-vim-lsp'

" Plug 'preservim/nerdtree'
" Plug 'airblade/vim-gitgutter'
" Plug 'dense-analysis/ale'
" Plug 'jiangmiao/auto-pairs'
" Plug 'leafgarland/typescript-vim'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'suan/vim-instant-markdown'
" Plug 'pangloss/vim-javascript'
" Plug 'tpope/vim-surround'
" Plug 'mattn/emmet-vim' " html
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'Yggdroot/indentLine' " displaying thin vertical lines

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:multi_cursor_next_key="\<C-s>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let b:ale_linters = ['flake8', 'pylint']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fatih/vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:go_version_warning = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 支持任意ASCII码，也可以使用特殊字符：¦, ┆, or │ ，但只在utf-8编码下有效
" let g:indentLine_char='�'
"let g:indentLine_char_list = ['┆']
"" 使indentline生效
"let g:indentLine_enabled = 1
"let g:indentLine_setColors = 0
"" Vim
"let g:indentLine_color_term = 239
"autocmd Filetype json let g:indentLine_enabled = 0
