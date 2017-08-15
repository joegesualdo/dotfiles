" OLD THOUGHTBOT SETTTINGS
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load vim-plug
" if empty(glob("~/.vim/autoload/plug.vim"))
"   execute '!sudo curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
" endif
if filereadable(expand("~/.config/nvim/bundles.vim"))
" if filereadable(expand('%:p:h')."/vimrc.bundles")
  " source expand('%:p:h')."/vimrc.bundles"
  source ~/.config/nvim/bundles.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  " autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  " autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  " autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  " autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
" colorscheme github
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" " Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
" let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
"
" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1

" Local config
" if filereadable($HOME . "/.vimrc.local")
"   source ~/.vimrc.local
" endif
" END OLD THOUGHTBOT SETTINGS

" TODO: Go through file and arrange the lines into
" related groups. Some places to start might be: “Basic Settings”,
" “FileType-specific settings”, “Mappings”, and “Status Line”. Add folding
" markers with headings to each section.
"
" Need this for base16:
"   (https://github.com/chriskempson/base16-vim) 
let base16colorspace=256  " Access colors present in 256 colorspace"

syntax enable
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Color Themes
" colorscheme solarized
" colorscheme lucius
" colo seoul256
" colorscheme base16-solarized
" colorscheme OceanicNext
"
" LOVE
" colorscheme SpacegrayEighties
"
colorscheme nova

" Hihglight the line the cursor is on
set cursorline

" For vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
set t_Co=256
" let g:airline_theme = 'luna'
" let g:airline_theme = 'solarized'
let g:airline_theme='oceanicnext'

" Show relative line numbers, opposed to absolute:
"   (http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/)
" set relativenumber 

" Hides the tilde(~) for empty lines
" WARNING! this approach is not a complete solution, because this highlighting group is used also for list chars (see the list and listchars options) making it impossible to specify highlighting just for the beyond-last-line markings.
" highlight NonText ctermfg=237 guifg=#073642


" For syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " configure Syntastic to use ESLint
" "   https://github.com/jaxbot/syntastic-react
" let g:syntastic_javascript_checkers = ['eslint']
"
" For Neomake
let g:python3_host_prog = '/usr/local/bin/python3'
autocmd! BufWritePost * Neomake
highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeErrorMsg'}
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_css_enabled_makers = ['stylelint']



" For YouCompleteMe
" These are the tweaks I apply to YCM's config, you don't need them but they
" might help. YCM gives you popups and splits by default that some people might not
" like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" For NerdTree
let NERDTreeShowHidden=1
nnoremap <Leader>nt :NERDTree<CR>

" highlight current line"
" set cursorline

" highlight matches when searched
set hlsearch

" TODO: Create shortcut to turn of highlight after vim is done searching
" turn off search highlight
" nnoremap <leader><space> :nohlsearch<CR>

" highlights the background in a subtle red for text that goes over the 80 column limit
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" Key mappings for xmpfilter:
" http://commandercoriander.net/blog/2012/10/10/evaluate-lines-of-ruby-in-vim/
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)
nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

" Navigate 2x faster when holding down Shift
" nmap <s-j> 2j
" nmap <s-k> 2k
" nmap <s-h> 2h
" nmap <s-l> 2l
" Navigate 4x faster when holding down Ctrl
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l

" Remove nasty grey from git gutter background
highlight clear SignColumn

" LimeLight integration with Goyo
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" enable markdown syntax highlight for my .md files.
" THIS ISN'T WORKING
" au BufRead,BufNewFile *.md set filetype=markdown
" So I added BufWinEnter based on:
" http://superuser.com/questions/113455/vim-highlighting-for-specific-file-types-where-to-put-syntax-files-vim-events
au BufWinEnter,BufRead,BufNewFile *.md set filetype=markdown

" disable folding for vim-markdown.vim
let g:vim_markdown_folding_disabled=1

" disable folding". When in markdown, files kept folding
set nofoldenable

" This removes the grey color behing the line numbers
" highlight LineNr ctermbg=black

" Change the indent vertical line character
"let g:indentLine_char = '︙'

" Send rspec from vim to tmux:
" http://robots.thoughtbot.com/use-rspec-vim-with-tmux-and-dispatch
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
"   http://robots.thoughtbot.com/running-specs-from-vim-sent-to-tmux-via-tslime
nnoremap <Leader>a :call RunAllSpecs()<CR>

" Add sytax highlighting for makefiles
"   style definitions can be found at ~/.vim/syntax/make.vim
au BufRead,BufNewFile *.make set filetype=make

" Toggle spell checking on and off with ` s`
nnoremap <silent> <leader>s :set spell!<CR>
" Set region to USA
set spelllang=en_us

" For vim-instant-markdown :
"   https://github.com/suan/vim-instant-markdown
" This will prevent vim-instand-markdow from opening up a broswer
"   preview when you open the markdown file. Instead we just enter
"   ":InstantMarkdownPreview" when we want to open the markdow 
"   preview.
let g:instant_markdown_autostart = 0
nnoremap <Leader>prev :InstantMarkdownPreview<CR>

" FZF
nnoremap <c-p> :FZF<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" For deoplete.
"   https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" Allow ‘yank’ and paste using y and p from Vim as well, and make it
"   usable by pasting anywhere outsite of vim
set clipboard=unnamed

" For NeoFormat
let g:neoformat_enabled_javascript = ['eslint_d']
" let g:neoformat_enabled_ruby = ['rubocop']
" run format on save
augroup fmt
  autocmd!
  autocmd BufWritePre *.js Neoformat! javascript
augroup END
" Prettier
" autocmd FileType javascript set formatprg=prettier\ --stdin
" autocmd BufWritePre *.js :normal gggqG " auto format on save with prettier
"  " restore cursor pointer on save with prettier
" " autocmd BufWritePre *.js exe 'normal! gggqG\<C-o>\<C-o>'
