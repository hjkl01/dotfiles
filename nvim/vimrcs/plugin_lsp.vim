"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lsp pls
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:lsp_settings_filetype_python = ['python-language-server']

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
" nmap <Space>g :LspDefinition<CR>
" map <Space>f :LspDocumentFormat<CR>
"
"
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"                 \ 'name': 'pyls',
"                 \ 'cmd': {server_info->['pyls']},
"                 \ 'allowlist': ['python'],
"                 \ 'workspace_config': {
"                 \    'pyls':
"                 \        {'configurationSources': ['flake8'],
"                 \         'plugins': {'flake8': {'enabled': v:true},
"                 \                     'pyflakes': {'enabled': v:false},
"                 \                     'pycodestyle': {'enabled': v:false,"ignore": [
"                 \                                                                   "E201",
"                 \                                                                   "E501"
"                 \                                                                   ]}
"                 \                    }
"                 \         }}
"                 \ })
" endif
"
" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gs <plug>(lsp-document-symbol-search)
"     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"
"     let g:lsp_format_sync_timeout = 1000
"     " autocmd! BufWritePre *.rs,*.go,*.py call execute('LspDocumentFormatSync')
"     autocmd! BufWritePre *.rs,*.go,*.py call execute('LspDocumentFormat')
"
"     " refer to doc to add more commands
" endfunction
"
" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END
"
" let g:lsp_fold_enabled = 1
