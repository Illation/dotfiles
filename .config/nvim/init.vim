" Setup dein  ---------------------------------------------------------------{{{
	if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
		call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
		call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
	endif

	set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
	call dein#begin(expand('~/.config/nvim'))
	call dein#add('Shougo/dein.vim')
	call dein#add('haya14busa/dein-command.vim')

" nerdtree stuff
	call dein#add('scrooloose/nerdtree')
	call dein#add('Xuyuanp/nerdtree-git-plugin')
	call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

" git goodness
	call dein#add("tpope/vim-fugitive")
	call dein#add("airblade/vim-gitgutter")

" c++, syntax highlighting, autocompletion
	call dein#add("Rip-Rip/clang_complete")
	call dein#add("Townk/vim-autoclose")
	call dein#add("terryma/vim-multiple-cursors")
	call dein#add("tpope/vim-surround")
	call dein#add("SirVer/ultisnips")
	call dein#add("vim-scripts/a.vim")
	call dein#add("majutsushi/tagbar")
	call dein#add("ervandew/supertab")
	call dein#add("octol/vim-cpp-enhanced-highlight")

" utility
	call dein#add('Yggdroot/indentLine')
	call dein#add('vim-airline')

	if dein#check_install()
		call dein#install()
	    let pluginsExist=1
	endif

	call dein#end()
	filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{
	set t_Co=256

	set number
	set rnu
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab

	syntax on
" }}}
" Plugin Settings  ----------------------------------------------------------{{{
	nmap <F8> :TagbarToggle<CR>
	nmap <F7> :NERDTreeToggle<CR>

	let g:clang_library_path='/usr/lib/libclang.so.3.9'
" }}}
