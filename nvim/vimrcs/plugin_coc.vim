
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neoclide/coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_disable_startup_warning=1
let g:coc_global_extensions = ['coc-html', 'coc-tsserver', 'coc-json',
            \ 'coc-gitignore', 'coc-translator', 'coc-python', 'coc-jedi',
            \ 'coc-pairs', 'coc-git', 'coc-highlight', 'coc-marketplace',
            \ 'coc-snippets', 'coc-vimlsp', 'coc-explorer']

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
nmap gd <Plug>(coc-definition)
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

nmap <Space>n :CocCommand explorer<CR>
