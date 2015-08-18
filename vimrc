"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~/.vimrc                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                               "
" Author:   Henry                                               "
" Version:  1.0                                                 "
" Date:     2015/08/09 10:29:00                                 "
" Desc:                                                         "
"                                                               "
"                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings {{{
"
" Plugins and indentation based on the file type
filetype on
filetype plugin on

" Don't remember source of this, i think it was already in my .vimrc
" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :5000 : up to 5000 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:5000,%,n~/.viminfo

" auto change directory from:
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif

" Mark the whitespace EOL
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Encoding
set encoding=utf-8
set termencoding=utf-8

set ttymouse=xterm2
set rtp+=~/.vim

" 开启语法高亮功能
syntax enable

" 允许用指定语法高亮配色方案替换默认方案
syntax on

" End of Basic settings }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 添加辅助信息
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler

" 开启行号显示
set number

" 高亮显示当前行/列
set cursorline
set cursorcolumn

" 高亮显示搜索结果
set hlsearch

" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
set expandtab

" 设置编辑时制表符占用空格数
set tabstop=4

" 设置格式化时制表符占用空格数
set shiftwidth=4

" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码折叠
"
" 操作：
"       za，打开或关闭当前折叠
"       zM，关闭所有折叠
"       zR，打开所有折叠
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax

" 启动 vim 时关闭折叠代码
set nofoldenable



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-solarized
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme {{{
" set term=xterm-256color
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
" colorscheme solarized
" set background=dark
" End of colorscheme }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-molokai
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme {{{
colorscheme molokai
set background=dark
" End of colorscheme }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline {{{
set guifont=Monaco\ for\ Powerline:h14.5
let g:Powerline_colorscheme='solarized256'
"let g:Powerline_symbols = 'fancy'
"set guifont=PowerlineSymbols\ for\ Powerline
"set nocompatible              " be iMproved
"set fillchars+=stl:\ ,stlnc:\
"set t_Co=256
" end of powerline }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags {{{
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"set tags+=/Users/henry/netease/vmms/lib/netmgr/tags
set tags+=/Users/henry/netease/network-manager/netmgr/tags
set autochdir
" end of ctags }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python comment
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python add comments {{{
fun! InsertPythonComment()
    exe 'normal'.1.'G'
    let line = getline('.')
    if line =~ '^#!.*$' || line =~ '^#.*coding:.*$'
        return
    endif
    normal O
    call setline('.', '#!/usr/bin/env python')
    normal o
    call setline('.', '# -*- coding:utf-8 -*-')
    normal o
    call setline('.', '#')
    normal o
    call setline('.', '#   Author  :   '.g:python_author)
    normal o
    call setline('.', '#   E-mail  :   '.g:python_email)
    normal o
    call setline('.', '#   Date    :   '.strftime("%y/%m/%d %H:%M:%S"))
    normal o
    call setline('.', '#   Desc    :   ')
    normal o
    call setline('.', '#')
    normal o
    call cursor(7, 17)
endfun

fun! InsertCommentWhenOpen()
    if a:lastline == 1 && !getline('.')
        call InsertPythonComment()
    end
endfun

au FileType python :%call InsertCommentWhenOpen()
au FileType python map <F2> :call InsertPythonComment()<cr>

let g:python_author = 'henry'
let g:python_email  = 'gzguohongwei@corp.netease.com'
" end of pycomments }}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 将 pathogen 自身也置于独立目录中，需指定其路径
runtime bundle/pathogen/autoload/pathogen.vim

" 运行 pathogen
execute pathogen#infect()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
"
"   o       open/close(fold) the high level tags
"   x       open/close the program files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置 tagbar 子窗口的位置出现在主编辑区的左边
let tagbar_left=1

" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list
nnoremap <silent> <F8> :TagbarToggle<CR>

" 设置标签子窗口的宽度
let tagbar_width=32

" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1

" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nnoremap <silent> <F9> :NERDTreeToggle<CR>

" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32

" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"

" 显示隐藏文件
let NERDTreeShowHidden=1

" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1

" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grep
"
"   :Grep       - Search for the specified pattern in the specified files
"   :Rgrep      - Run recursive grep
"               [<grep_options>] [<search_pattern> [<file_name(s)>]]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F3> :Rgrep<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlsf
"
"   Enter   - Open corresponding file of current line in the window
"             which CtrlSF is launched from.
"   t       - Like Enter but open file in a new tab.
"   p       - Like Enter but open file in a preview window.
"   O       - Like Enter but always leave CtrlSF window opening.
"   T       - Like t but focus CtrlSF window instead of new opened tab.
"   q       - Quit CtrlSF window.
"   <C-J>   - Move cursor to next match.
"   <C-K>   - Move cursor to previous match.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F4> :CtrlSF<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5

" 选中项
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0

" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1

" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap <leader>; <C-x><C-o>

" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview

" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1

" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0

" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Signature
"
" mx        Toggle mark 'x' and display it in the leftmost column
" m.        If no mark on line, place the next available mark. Otherwise,
"           remove (first) existing mark.
" m<space>  Delete all marks from the current buffer
" ]`        jump to next mark
" [`        jump to previous mark
" m/        Open location list and display marks from current buffer
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent Guides
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
"
"" 从第二层开始可视化显示缩进
"let g:indent_guides_start_level=2
"
"" 色块宽度
"let g:indent_guides_guide_size=1
"
"" 快捷键 i 开/关缩进可视化
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle


