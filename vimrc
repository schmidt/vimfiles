set nocompatible

augroup vimrc
autocmd! vimrc
augroup end

" Load pathogen ***************************************************************
call pathogen#infect()

" Initialize helptags
" call pathogen#helptags()

" Misc ************************************************************************
set backspace=indent,eol,start
set matchpairs+=<:>
set ruler
set showcmd
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how
syntax on

" Automatically load vimrc after it was updated
autocmd vimrc bufwritepost .vimrc,vimrc source $MYVIMRC

" Scrolling *******************************************************************
set scrolloff=2  " keep the current line two lines above fold while scrolling

" Highlight lines longer than 80 chars ****************************************
set textwidth=80
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
match ColorColumn '\%80v.*'

" Tabstops ********************************************************************
set ts=4 sts=4 sw=4 expandtab
autocmd vimrc FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd vimrc FileType eruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd vimrc FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd vimrc FileType css setlocal ts=2 sts=2 sw=2 expandtab

" Indenting *******************************************************************
set autoindent  " Automatically set the indent of a new line
set smartindent
filetype plugin indent on

" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size

" Improve behavior when using tab completion in command mode
set wildmode=longest,list,full
set wildmenu



" Searching *******************************************************************
set hlsearch   " highlight search
set incsearch  " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase  " Ignore case when searching lowercase

" Insert New Line *************************************************************
" awesome, inserts new line without going into insert mode
map <S-Enter> O<ESC>==
map <Enter> o<ESC>==

" Filetype changes ************************************************************
au BufNewFile,BufRead *.jspf set filetype=jsp
au BufNewFile,BufRead config.ru,Gemfile set filetype=ruby


" Emacs-style editing on the command-line *************************************
" start of line
:cnoremap <C-A>		<Home>
" back one character
:cnoremap <C-B>		<Left>
" delete character under cursor
:cnoremap <C-D>		<Del>
" end of line
:cnoremap <C-E>		<End>
" forward one character
:cnoremap <C-F>		<Right>
" recall newer command-line
:cnoremap <C-N>		<Down>
" recall previous (older) command-line
:cnoremap <C-P>		<Up>
" back one word
:cnoremap <Esc><C-B>	<S-Left>
" forward one word
:cnoremap <Esc><C-F>	<S-Right>


" Strip white space ***********************************************************
function! Preserve(command)
" Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
" Do the business:
  execute a:command
" Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" strip trailing white space only on non-empty lines
" autocmd BufWritePre * :call Preserve("%s/\\(\\S\\+\\)\\s\\+$/\\1/e")

" strip trailing white space on all lines
autocmd vimrc BufWritePre * :call Preserve("%s/\\s\\+$//e")




" Plugins *********************************************************************

" fugitive.vim *************************************************************
" add current git branch to status line
set laststatus=2
set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" syntastic   *************************************************************
" Enable status line indicator
set statusline+=%{SyntasticStatuslineFlag()}
" Enable signs interface
let g:syntastic_enable_signs=1
" let :E open netrw again - to avoid conflicts with Errors
command! -nargs=* E Explore
" fancier signs for errors and warnings in syntastic
sign define SyntasticError text=⚡ texthl=error
sign define SyntasticWarning text=→ texthl=todo
