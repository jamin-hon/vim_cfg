"=============================== auto cmd ==================================
"autocmd {{         增加自动执行配置命令

"auto chmod {       .py .sh 自动增加执行权限
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile> 
"}
"

"}}    

"============================= make =======================================
"make conf {        vim 内置命令make 配置修改
    set makeprg=gcc\ -Wall\ %<.c\ -o\ %<.o
"}

"============================= pathogen =======================================
"pathogen{          Vim用来管理插件的插件
    execute pathogen#infect()
"}


"================================ config =================================
syn on                     
"common conf {{             通用配置
    set ai                      "自动缩进
    set bs=2                    "在insert模式下用退格键删除
    set showmatch               "代码匹配
    set laststatus=2            "总是显示状态行
    "set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
    set shiftwidth=4
    set tabstop=4
    set cursorline              "为光标所在行加下划线
    set number                  "显示行号
    set autoread                "文件在Vim之外修改过，自动重新读入

    set ignorecase              "检索时忽略大小写
    set encoding=utf-8
    set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
    set hls                     "检索时高亮显示匹配项
    set helplang=cn             "帮助系统设置为中文
    "set foldmethod=syntax       "代码折叠
    "colorscheme 256-jungle 

"}}

if has("gui_macvim")
    set guifont=Menlo:h14
endif


"================================ map ===================================
let mapleader = ','
"设置生成ctag索引
    map <F7> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <CR>
    map <F8> :!cscope -bRq <CR>
"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换窗口,用,t创建新标签等
    nnoremap <C-l> <C-w>l
    nnoremap <C-h> <C-w>h

nnoremap <leader>t : tabe<CR>
nnoremap <leader>tn : tabn<CR>

"================================插件====================================
"
"=============================== vundle ==================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-powerline'
Plugin 'qiaoshouxing/cscope_maps'
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'scrooloose/nerdtree'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'nerdtree-ack'
Plugin 'tagbar'
Plugin 'L9'
Plugin 'OmniCppComplete'
Plugin 'autoload_cscope.vim'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
"
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"conf for plugins {{ 插件相关的配置

"状态栏的配置 
"powerline{
    set guifont=PowerlineSymbols\ for\ Powerline
    set nocompatible
    set t_Co=256
    let g:Powerline_symbols = 'fancy'
"}


"NERDTree配置{
    let NERDTreeDirArrows = 0
    let NERDTreeShowBookMarks = 1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeKeepTreeInNewTab=1
    nnoremap <leader>e : NERDTree<CR>
	let NERDTreeWinPos=0     "将NERDTree放置在编辑区,1右边 0左边
	let NERDTreeWinSize=25   "设置NERDTree的宽度,默认为30
	let NERDTreeShowHidden=1 "显示隐藏文件
	"autocmd BufReadPost * :NERDTree        "启动vim时 自动打开NERDTree
                                            "vim没有文件时,自动退出NERDTree
	"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
	"wincmd w                    "光标自动显示在编辑区
	"autocmd VimEnter * wincmd w "光标自动显示在编辑区
"}

"
"Tagbar{
    nnoremap <leader>tl : Tagbar<CR> 
	let g:tagbar_width=25
"}
"OmniCppComplete {
    set nocp
    filetype plugin on
"}


"autocomment {
function AddFileHead()
    call append(0, "/*******************************************************************************")
    call append(1, "           Copyright (C), 2014-2015,  Co., Ltd.")
    call append(2, " FileName    : ".expand("%:t"))
    call append(3, " Author      : alexander")
    call append(4, " Data        : ".strftime("%Y-%m-%d %H:%M"))
    call append(5, " Description :")
    echohl WarningMsg | echo "Successful in adding the copyrigh." | echohl None
    call append(6, "*******************************************************************************/")
    call append(7, "")
    call append(8, "#ifdef __cplusplus")
    call append(9, "extern \"C\" {")
    call append(10, "#endif")
    call append(11, "#ifdef __cplusplus")
    call append(12, "}")
    call append(13, "#endif")
endfunction

function AddFuncHead()
    let start = line(".")
    call append(start, "/*******************************************************************************")
    call append(start + 1, " Function name : ")
    call append(start + 2, " Input         : ")
    call append(start + 3, " Output        : ")
    call append(start + 4, " Return        : ")
    call append(start + 5, " Author        : alexander")
    call append(start + 6, " Data          : ".strftime("%Y-%m-%d"))
    call append(start + 7, " Description   : ") 
    call append(start + 8, "*******************************************************************************/")
    echohl WarningMsg | echo "Successful in adding the comment" | echohl None
endfunction
map <F4> : call AddFileHead()<cr> 
map <F5> : call AddFuncHead()<cr>
"}

"}}
