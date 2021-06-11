"==========================================
" Theme Settings  主题设置
"==========================================

" Set extra options when running in GUI mode
"if has("gui_running")
"    set guifont=Monaco:h14
"    if has("gui_gtk2")   "GTK2
"        set guifont=Monaco\ 12,Monospace\ 12
"    endif
"    set guioptions-=T
"    set guioptions+=e
"    set guioptions-=r
"    set guioptions-=L
"    set guitablabel=%M\ %t
"    set showtabline=1
"    set linespace=2
"    set noimd
"    set t_Co=256
"endif

" theme主题
"set background=dark

set t_Co=256

" colorscheme molokai
colorscheme zend

"----------------------------------------------------------------------
" 状态栏设置
"----------------------------------------------------------------------
"set statusline=                                 " 清空状态了
"set statusline+=\ %F                            " 文件名
"set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
"set statusline+=%=                              " 向右对齐
"set statusline+=\ %y                            " 文件类型

" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
"set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)

" 设置可以高亮的关键字
"if has("autocmd")
"  " Highlight TODO, FIXME, NOTE, etc.
"  if v:version > 701
"    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
"    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
"    autocmd Syntax * call matchadd('phpTodo', '<?php\|?>\|<?=')
"    autocmd Syntax * call matchadd('phpKeyword', 'empty\|isset')
"    " autocmd Syntax * call matchadd('htmlLink', '<a\|<\/a>\|<img\|src\|href\|<input\|<form\|</form>')
"  endif
"endif
