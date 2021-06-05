"--------------------------自定义快捷键---------------------

"Treat long lines as break lines (useful when moving around in them)
""se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j"

nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nnoremap cc dd
"nnoremap x "_x
"nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
vnoremap d "_d
vnoremap dd "_dd

" F1 - F6 设置

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
"noremap <F1> <Esc>"
"nnoremap <F2> :call HideNumber()<CR>
" F3 显示可打印字符开关
"nnoremap <F3> :set list! list?<CR>
" F4 换行开关
"nnoremap <F4> :set wrap! wrap?<CR>
" F6 语法开关，关闭语法可以加快大文件的展示
"nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
"set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F5 set paste问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
"function! HideNumber()
  "if(&relativenumber == &number)
    "set relativenumber! number!
  "elseif(&number)
    "set number!
  "else
    "set relativenumber!
  "endif
  "set number?
"endfunc

" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

map <leader>zz :call ToggleFold()<cr>

map <C-n> :bnext<cr>
map <C-p> :bprev<cr>

map <leader>1 :bfirst<cr>
map <leader>2 :b2<cr>
map <leader>3 :b3<cr>
map <leader>4 :b4<cr>
map <leader>5 :b5<cr>
map <leader>6 :b6<cr>
map <leader>7 :b7<cr>
map <leader>8 :b8<cr>
map <leader>9 :b9<cr>
map <leader>0 :blast<cr>
map <leader>d :bd<cr>

" Toggles between the active and last active tab "
let g:lastTabNr = 1
autocmd TabLeave * let g:lastTabNr = tabpagenr()
nnoremap <silent> <c-o> exec "tabnext ".g:lastTabNr

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

map Y y$

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Map ; to : and save a million keystrokes 用于快速进入命令行
"nnoremap ; :

" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" Quickly save the current file
nnoremap <leader>w :w<CR>

" Quickly close the current window
nnoremap <leader>q :q<CR>

" 复制选中区到系统剪切板中
"vnoremap <leader>y "+y

" select block
nnoremap <leader>v V`}

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" select all
map <Leader>sa ggVG

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" 命令行模式增强，ctrl - a到行首， -e 到行尾
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>

" 绑定插入模式下的方向键
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" 滚动Speed up scrolling of the viewport slightly
"nnoremap <C-e> 2<C-e>
"nnoremap <C-y> 2<C-y>

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
