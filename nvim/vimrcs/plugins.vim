call plug#begin('~/.config/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdcommenter' " 注释
Plug 'scrooloose/nerdtree'
Plug 'peitalin/vim-jsx-typescript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch (recommend)


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
" Plug 'Shougo/deoplete.nvim'
" Plug 'lighttiger2505/deoplete-vim-lsp'

" Plug 'Valloric/YouCompleteMe', { 'do': 'git submodule update --init --recursive && python install.py' }
" Plug 'dense-analysis/ale'
" Plug 'suan/vim-instant-markdown'
" Plug 'pangloss/vim-javascript'
" Plug 'tpope/vim-surround'
" Plug 'mattn/emmet-vim' " html
" Plug 'Yggdroot/indentLine' " displaying thin vertical lines

call plug#end()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neoclide/coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_disable_startup_warning=1
let g:coc_global_extensions = ['coc-html', 'coc-tsserver', 'coc-json',
            \ 'coc-gitignore', 'coc-translator', 'coc-python', 'coc-jedi',
            \ 'coc-pairs', 'coc-git', 'coc-highlight', 'coc-marketplace',
            \ 'coc-snippets']

inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<tab>'
nmap <Leader>t :CocCommand translator.popup <CR>
nmap <Leader>g <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <Leader>f :call CocAction('format')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <Leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => preservim/nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>c <plug>NERDCommenterToggle

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=30
let g:NERDTreeDirArrows = 1
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>n <ESC> :NERDTreeToggle<CR>
"nmap <S-M> :CocCommand explorer --position right --sources=buffer+,file+ <CR>



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
