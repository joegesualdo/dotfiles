" Install vim-plug if it doesn't exist.
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" Start the vim-plug section and install the plugins in ./vim/bundle/
call plug#begin("~/.config/nvim/plugged/")
" Define bundles via Github repos
Plug 'danro/rename.vim'
" Plug 'kien/ctrlp.vim'
" Plug 'scrooloose/syntastic'
Plug 'Yggdroot/LeaderF'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
" Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/ctags.vim'
Plug 'vim-scripts/tComment'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
" Plug 'rking/ag.vim'
" Color: css/less/sass/html color preview for vim
Plug 'https://github.com/gorodinskiy/vim-coloresque.git'
"
Plug 'scrooloose/nerdcommenter'
"
Plug 'godlygeek/tabular' "This is required for plasticboy/vim-markdown

"  It uses signs to indicate added, modified and removed lines based on data
"  of an underlying version control system.
Plug 'mhinz/vim-signify'
"
"  a vim plug-in which provides support for expanding abbreviations similar to
"  emmet.
" TODO: emmet isn't available via Plug
" Plug "mattn/emmet-vim"


"  provides facilities to integrate Vim with the pandoc document converter and
"  work with documents written in its markdown variant (although textile
"  documents are also supported).
Plug 'vim-pandoc/vim-pandoc'

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'
" Hyperfocus-writing in Vim.
Plug 'junegunn/limelight.vim'
" A vim plugin for syntax highlighting Ansible's common filetypes
Plug 'pearofducks/ansible-vim'

" instantly preview finnicky markdown files,
Plug 'suan/vim-instant-markdown'

" Vim syntax file for Docker's Dockerfile and snippets for snipMate.
" Plug 'ekalinin/Dockerfile.vim'
"
"  displaying thin vertical lines at each indentation level for code indented
"  with spaces.
" Plug 'Yggdroot/indentLine'
"
" This script is based on Vim Arduino, but uses the Ino command line utility
" instead of the Java Arduino compiler. It therefore runs in 64-bit
" environments and allows for compiling and deployment of Arduino
" (*.pde/*.ino) sketches directly from Vim.
Plug 'jplaut/vim-arduino-ino'
"
"
" ###########################
" # Syntax Coloring
" ###########################
" Syntax highlighting and other things for nginx
Plug 'mv/mv-vim-nginx'
"Markdown syntax
Plug 'plasticboy/vim-markdown'

" Color themes
" Used for vim scheme
Plug 'hhff/SpacegrayEighties.vim'
" Used for tmux scheme
Plug 'mhartington/oceanic-next'
Plug 'trevordmiller/nova-vim'

" for full HTML5 colors
Plug 'othree/html5.vim'

"for full CSS Colors
Plug 'hail2u/vim-css3-syntax'
" Javascript settings: http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gavocanov/vim-js-indent' "This was added because es6 indentation was off
Plug 'othree/javascript-libraries-syntax.vim'
" React JSX syntax highlighting and indenting for vim.
Plug 'mxw/vim-jsx'

Plug 'Raimondi/delimitMate'
" Removing this to speed up vim
" Plug 'Valloric/YouCompleteMe'
Plug 'marijnh/tern_for_vim'

"For NEOVim
" Plug 'neomake/neomake'

" For auto-formatting
Plug 'sbdchd/neoformat'

" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Plug 'lambdatoast/elm.vim'
Plug 'ElmCast/elm-vim'

" Haskell
Plug 'neovimhaskell/haskell-vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'purescript-contrib/purescript-vim'
Plug 'https://github.com/frigoeu/psc-ide-vim.git'
" Plug 'frigoeu/psc-ide-vim'
" Plug 'raichoo/purescript-vim'

" For autocompletion
" function! DoRemote(arg)
"   UpdateRemotePlugins
" endfunction

" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" Add plugins to &runtimepath

Plug 'leafgarland/typescript-vim'

" A vim plugin that open the link to current line at Github
"   (Also support Bitbucket and self deployed gitlab)
Plug 'ruanyl/vim-gh-line'

Plug 'w0rp/ale'
call plug#end()
