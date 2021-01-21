" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
            \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
            \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
            \ 'python': ['~/.pyenv/py3/bin/pyls'],
            \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
            \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)
