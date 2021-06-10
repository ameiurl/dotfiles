" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
"set relativenumber number
" au FocusLost * :set norelativenumber number
" au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
" autocmd InsertEnter * :set norelativenumber number
" autocmd InsertLeave * :set relativenumber
" function! NumberToggle()
"   if(&relativenumber == 1)
"     set norelativenumber number
"   else
"     set relativenumber
"   endif
" endfunc

" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif


"==========================================
" others 其它设置
"==========================================
" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu

" 离开插入模式后自动关闭预览窗口
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
"autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
" autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
" autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
" autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> <ESC> :cclose<CR>

" quickfix高度
au FileType qf call AdjustWindowHeight(5, 20)
function! AdjustWindowHeight(minheight, maxheight)
	let l = 1
	let n_lines = 0
	let w_width = winwidth(0)
	while l <= line('$')
		" number to float for division
		let l_len = strlen(getline(l)) + 0.0
		let line_width = l_len/w_width
		let n_lines += float2nr(ceil(line_width))
		let l += 1
	endw
	exe max([min([n_lines, a:maxheight]), a:minheight]) .  "wincmd _"
endfunction

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"set tags=tags; 
set tags=./.tags;,.tags
"set autochdir 
" 每次保存自动生成tags
" 如启动报错，请先安装ctags
" 跳转快捷键：<ctrl-]>跳转 <ctrl-t>返回
"au BufWritePost *.c,*.cpp,*.h,*.php,*.json,*.erl,*.sh,*.html,*.css,*.conf silent! !cmd !(ps -ef|grep ctags|grep -v grep|awk '{print $2}'|xargs -I{} kill -9 {}; rm -f .ctags1; ctags -Rf .tags1 --exclude='*.js' && mv -f .tags1 .tags) &> /dev/null &

" 保存时自动将tab转换为相应长度的空格
" 此行禁止开启，否则会导致撤销到最新时保存后，无法重做！！！
" autocmd BufWritePre * :%retab!

" 设置退出vim后，不显示文件内容
if &term =~ "xterm"
    " SecureCRT versions prior to 6.1.x do not support 4-digit DECSET
    "    let &t_ti = "\<Esc>[?1049h"
    "    let &t_te = "\<Esc>[?1049l"
    " Use 2-digit DECSET instead
    let &t_ti = "\<Esc>[?47h"
    let &t_te = "\<Esc>[?47l"
endif

"标签高亮匹配
runtime macros/matchit.vim 

" 系统剪贴板
set clipboard+=unnamedplus

"最后一个窗口，quickfix一起关闭
aug QFClose
	au!
	au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END


