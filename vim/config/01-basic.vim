"==========================================
" General Settings 基础设置
"==========================================

" 禁用 vi 兼容模式
set nocompatible

" history存储容量
set history=1000

" 检测文件类型
"filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread

" 取消备份。 视情况自己改
set nobackup

" 关闭交换文件
set noswapfile

" 突出显示当前行
set cursorline

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
"set t_ti= t_te=

" 鼠标暂不启用, 键盘党....
set mouse-=a

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

" change the terminal's title
" set title
" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Remember info about open buffers on close
"set viminfo^=%

" For regular expressions turn magic on
"set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 三种缩进模式
set ai si ci

" set winwidth=79

" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number


" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

"split新窗口右侧底部
set splitright
set splitbelow

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent


" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
"set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest

" 00x增减数字时使用十进制
set nrformats=

" 卡顿问题
"let g:loaded_matchparen=1
set lazyredraw "should make scrolling faster"
set ttyfast "same as above"

" 换行
set wrap

" 显示整个单词
set linebreak

" 解决自动换行格式下, 如折行之后高在超过窗口高度看不到最后一行的问题
set display+=lastline

"----------------------------------------------------------------------
" FileEncode Settings 文件编码,格式
"----------------------------------------------------------------------
"
" 设置新文件的编码为 UTF-8
set encoding=utf-8

" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

"----------------------------------------------------------------------
" 搜索设置
"----------------------------------------------------------------------

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch

" 设置为搜索时不要回卷
set wrapscan

"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
if has('folding')
	" 允许代码折叠
	set foldenable

	" 折叠方法
	" manual    手工折叠
	" indent    使用缩进表示折叠
	" expr      使用表达式定义折叠
	" syntax    使用语法定义折叠
	" diff      对没有更改的文本进行折叠
	" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
	" 代码折叠默认使用缩进
	set fdm=indent
	
	" 默认打开所有缩进
	set foldlevel=99
endif

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
