call plug#begin('~/.config/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdcommenter' " 注释
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch (recommend)
Plug 'dstein64/nvim-scrollview'
Plug 'leafgarland/typescript-vim'

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"" (Optional) Multi-entry selection UI.
"Plug 'junegunn/fzf'

" Plug 'terryma/vim-multiple-cursors'
" Plug 'jiangmiao/auto-pairs'
" Plug 'airblade/vim-gitgutter'

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
"
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
"
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'lighttiger2505/deoplete-vim-lsp'

" Plug 'Valloric/YouCompleteMe', { 'do': 'git submodule update --init --recursive && python install.py' }
" Plug 'dense-analysis/ale'
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
" => vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:gitgutter_highlight_lines = 1
" let g:gitgutter_highlight_linenrs = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lsp pls
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:lsp_settings = {
"             \   'pyls': {
"             \     'workspace_config': {
"             \       'pyls': {
"             \         'configurationSources': ['flake8']
"             \       }
"             \     }
"             \   },
"             \}
" nmap <S-K> :LspPeekDefinition<CR>
" nmap <silent> gd :LspDefinition<CR>
" "map <S-F> :LspDocumentFormat<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => autozimu/LanguageClient-neovim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" note that if you are using Plug mapping you should not use `noremap` mappings.
"nmap <F5> <Plug>(lcn-menu)
"" Or map each action separately
"nmap <silent>K <Plug>(lcn-hover)
"nmap <silent> gd <Plug>(lcn-definition)
"nmap <silent> <F2> <Plug>(lcn-rename)
"
"set hidden
"
"let g:LanguageClient_serverCommands = {'python': ['/Users/jinlong/.pyenv/py3/bin/pyls']}


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
