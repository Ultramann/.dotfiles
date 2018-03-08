let mapleader="\<Space>"

"General settings
    "Stop writing stuff
        set nobackup
        set nowritebackup
        set noswapfile
    "Line numbers
        set number
        set numberwidth=6
        set relativenumber
    "Searching
        set smartcase
        set ignorecase
        set gdefault
        set hlsearch
        set incsearch
    "Indenting
        set autoindent
        set smarttab
        set expandtab
    "Wildmenu
        set wildmenu
        set wildignore+=.git,*.pyc
        set wildmode=longest:list,full
    "Bottom
        set noruler
        set scrolloff=5
        set laststatus=2
        set statusline=%<\ %f\ %m%y%=%-35.(Line:\ %l\ of\ %L,\ Col:\ %c%V\ (%P)%)
    "Misc
        set path=**
        set linebreak
        set splitbelow
        set cursorline
        set hidden
        set novisualbell
        set nocompatible
        set spelllang=en_us
        set backspace=indent,eol,start
        set foldmethod=indent
        set foldlevelstart=20

"Colors
    syntax enable
    colorscheme bossColors

"Filetype settings
    filetype on
    filetype plugin indent on
    autocmd FileType python,text,html,css,json,javascript,vim
        \ setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType haskell,cabal,yaml,sh,sql,tex,markdown
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2

"Plugin settings
    "Syntatic
        let g:syntastic_enable_signs=0
        let g:syntastic_check_on_open=1
        let g:syntastic_check_on_wq=0
        let g:syntastic_python_checkers=['pyflakes']
        let g:syntastic_haskell_checkers=['hlint']

    "Netrw
        let g:netrw_banner=0
        let g:netrw_liststyle=3

"Mappings
    "Productivity
        nnoremap     j     gj
        nnoremap     k     gk
        inoremap    jj    <ESC>
        vnoremap    vj    <ESC>
        nnoremap    ga    ggVG
        nnoremap    gb    V`]
        nnoremap    gl    :find <C-R><C-W>
        vnoremap    //    y/<C-R>"<CR>
        nnoremap <leader>Q :q!<CR>
        nnoremap <leader>f :find<Space>
        nnoremap <leader>e :edit<Space>
        vnoremap <leader>a :norm<Space>A
        nnoremap <leader>a :%norm<Space>A
        nnoremap <leader>u <C-R>
        nnoremap <silent> <leader>t :Explore<CR>
        nnoremap <silent> <leader>o :noh<CR>
        nnoremap <silent> <leader>w :call TrimWhitespace()<CR>
        nnoremap <silent> <leader>c :call ToggleCursorLines()<CR>
        nnoremap <silent> <leader>n :set relativenumber!<CR>

    "Spell checking
        nnoremap <silent> <leader>sc :set spell!<CR>
        nnoremap <silent> <leader>ss z=
        nnoremap <silent> <leader>sa 1z=

    "Buffers
        nnoremap <silent> <Tab>     :b#<CR>
        nnoremap <silent> <S-Tab>   :bnext<CR>
        nnoremap <silent> <leader>x :bdelete<CR>
        nnoremap <leader>b :ls<CR>:buffer<Space>

    "Splits
        nnoremap <silent> <leader>s= :resize +5<CR>
        nnoremap <silent> <leader>s- :resize -5<CR>

    "Quickfix things
        nnoremap <silent> <leader>q :call QuickfixToggle()<CR>
        nnoremap <leader>pg :ProjectGrep 

    "Clipboard
        nnoremap <silent> <leader>y :call Clipboard(v:count1, '"+yy')<CR>
        nnoremap <silent> <leader>p :call Clipboard(v:count1, '"+p')<CR>
        nnoremap <silent> <leader>P :call Clipboard(v:count1, '"+P')<CR>
        nnoremap <silent> <leader>d :call Clipboard(v:count1, '"+dd')<CR>
        vnoremap <silent> <leader>y "+y
        vnoremap <silent> <leader>p "+p
        vnoremap <silent> <leader>d "+d

    "Fugitive
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>ga :Gwrite<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gp :Git push<CR>

    "Swaps
        nnoremap    v    <C-V>
        nnoremap  <C-V>    v
        nnoremap    '      `
        nnoremap    `      '

    "Runners
        nnoremap <silent> <leader>rp :! python %<CR>
        nnoremap <silent> <leader>rh :! stack runghc %<CR>
        nnoremap <silent> <leader>rt :! pdflatex -shell-escape %<CR>

    "No arrow keys
        nnoremap   <up>   <nop>
        nnoremap  <down>  <nop>
        nnoremap  <left>  <nop>
        nnoremap  <right> <nop>
        inoremap   <up>   <nop>
        inoremap  <down>  <nop>
        inoremap  <left>  <nop>
        inoremap  <right> <nop>

"Other
    "Commands
        command -nargs=1 ProjectGrep call ProjectGrep(<f-args>)

    "Functions
        function TrimWhitespace()
            let l:save_cursor = getpos('.')
            %s/\s\+$//e
            call setpos('.', l:save_cursor)
        endfunction

        function ToggleCursorLines()
            if &cursorline && &cursorcolumn
                hi  clear CursorLine
                set nocursorcolumn
            else
                hi  CursorLine   ctermbg=236
                set cursorline
                set cursorcolumn
            endif
        endfunction

        function ProjectGrep(search)
            execute 'noautocmd vimgrep /' . a:search . '/j ./**'
            execute 'call QuickfixToggle()'
        endfunction

        function Clipboard(count, command)
            execute 'normal ' . a:count . a:command
        endfunction

        let g:quickfix_is_open = 0
        function QuickfixToggle()
            if g:quickfix_is_open
                cclose
                let g:quickfix_is_open = 0
                execute g:quickfix_return_to_window . "wincmd w"
            else
                let g:quickfix_return_to_window = winnr()
                copen
                let g:quickfix_is_open = 1
            endif
        endfunction
