
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neoclide/coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch (recommend)

let g:coc_disable_startup_warning=1
let g:coc_global_extensions = [
            \ 'coc-translator',
            \ 'coc-fzf-preview',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-cssmodules',
            \ 'coc-pairs',
            \ 'coc-git',
            \ 'coc-gitignore',
            \ 'coc-highlight',
            \ 'coc-marketplace',
            \ 'coc-explorer']

            " \ 'coc-python',
            " \ 'coc-go',
            " \ 'coc-snippets',
            " \ 'coc-vimlsp',
            " \ 'coc-tsserver',
            " \ 'coc-json',

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<tab>'
nmap <Space>t :CocCommand translator.popup <CR>
" nmap gd <Plug>(coc-definition)
" nmap <silent> gr <Plug>(coc-references)
nmap <Space>f :call CocAction('format')<CR>

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <Space>k :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     else
"         call CocAction('doHover')
"     endif
" endfunction

nmap <Space>n :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
