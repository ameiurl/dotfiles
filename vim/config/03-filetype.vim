"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
" autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
" autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
" autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
" autocmd BufRead,BufNewFile *.part set filetype=html
" disable showmatch when use > in php
"au BufWinEnter *.php set mps-=<:>



" 保存python文件时删除多余空格
"fun! <SID>StripTrailingWhitespaces()
    "let l = line(".")
    "let c = col(".")
    "%s/\s\+$//e
    "call cursor(l, c)
"endfun
"autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" 定义函数AutoSetFileHead，自动插入文件头
"autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
"function! AutoSetFileHead()
"    "如果文件类型为.sh文件
"    if &filetype == 'sh'
"        call setline(1, "\#!/bin/bash")
"    endif
"
"    "如果文件类型为python
"    if &filetype == 'python'
"        call setline(1, "\#!/usr/bin/env python")
"        call append(1, "\# encoding: utf-8")
"    endif
"
"    normal G
"    normal o
"    normal o
"endfunc


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


" File type specific configs

" Vim ======================================================================={{{
autocmd FileType vim set tabstop=2 shiftwidth=2 expandtab ai
" }}}

" Python ===================================================================={{{
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
" set colorcolumn
function! ColorColumn()
    if(&colorcolumn == 80)
        set colorcolumn=0
    else
        set colorcolumn=80
    endif
endfunc
autocmd FileType python nnoremap <leader>b :call ColorColumn()<cr>
" }}}

" JS ===================================================================={{{
autocmd FileType javascript set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType typescript set tabstop=2 shiftwidth=2 expandtab ai
" }}}

" Ruby ======================================================================{{{
if v:version >= 703
  " Note: Relative number is quite slow with Ruby, so is cursorline
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 ai expandtab nocursorline nocursorcolumn
else
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 ai expandtab
endif
" }}}

" Golang ===================================================================={{{
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" }}}

" Text ======================================================================{{{
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd
autocmd FileType yaml set sw=2 sts=2 et
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType puppet set sw=2 sts=2 et
" }}}

" vim: set fdl=0 fdm=marker:
