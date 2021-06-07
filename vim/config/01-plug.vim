"""""""" 插件管理vim-plug""""""""
set nocompatible
filetype off
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'                     " 状态栏增强
Plug 'vim-airline/vim-airline-themes'              " 状态栏增强
Plug 'christoomey/vim-tmux-navigator'              " 让vim能兼容tmux
Plug 'jiangmiao/auto-pairs'                        " 自动补全括号
Plug 'mg979/vim-visual-multi',{'branch': 'master'} " <c-m>批量量更新
Plug 'terryma/vim-expand-region'                   " v/V 快速选择区域/取消选择区域
Plug 'tpope/vim-surround'						   " yss\' ysiw\" cs\"\' ds\"
Plug 'tpope/vim-repeat'							   " 重复上一次操作
Plug 'scrooloose/nerdcommenter'					   " 快速注释/解开注释
Plug 'psliwka/vim-smoothie'						   " 滚动翻页效果插件
Plug 'liuchengxu/vista.vim'						   " taglist
" 补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " 自动补全
Plug 'mattn/emmet-vim'							   " <c-e> html代码补全
" 文件查找
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  } " <Leader>f/b/h 快速打开文件
" 文件目录树
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'kristijanhusak/defx-icons'
" gtags 函数跳转
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
" 代码补全
Plug 'SirVer/ultisnips'							   
Plug 'honza/vim-snippets'
" 对齐
Plug 'junegunn/vim-easy-align'					   " <Leader>a符号 快速对齐
Plug 'plasticboy/vim-markdown'                     " markdown插件
"Git
Plug 'tpope/vim-fugitive'						   " Gdiff Gstatus
Plug 'airblade/vim-gitgutter'					   " show git status [c上一个 ]c下一个
" 终端
Plug 'voldikss/vim-floaterm'					   " 终端插件
" 搜索
"Plug 'rking/ag.vim'                                " Ag
"Plug 'wsdjeg/FlyGrep.vim'						   " <Leader>s
call plug#end()
filetype plugin indent on

let mapleader=','
let g:mapleader=','
let g:maplocalleader=';'

" 引入插件的设置

" defx ===================================================================={{{
nmap <Tab> :Defx -columns=indent:icons:filename:type<cr>
 " 使用 ,e 查找到当前文件位置
nnoremap <silent> <Leader>e
			\ :<C-u>Defx -columns=indent:icons:filename:type 
			\ -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
	nnoremap <silent><buffer><expr> <Esc>	 defx#do_action('quit')
	nnoremap <silent><buffer><expr> o		 <SID>defx_toggle_tree()                    " 打开或者关闭文件夹，文件
	nnoremap <silent><buffer><expr> <CR>     defx#do_action('drop')
	nnoremap <silent><buffer><expr> cc       defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> dd       defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> yy       defx#do_action('copy')
	nnoremap <silent><buffer><expr> mm       defx#do_action('move')
	nnoremap <silent><buffer><expr> pp       defx#do_action('paste')
	nnoremap <silent><buffer><expr> N        defx#do_action('new_file')				" 新建文件
	nnoremap <silent><buffer><expr> M        defx#do_action('new_multiple_files')   " 批量新建文件
	nnoremap <silent><buffer><expr> R        defx#do_action('rename')
	nnoremap <silent><buffer><expr> j        line('.') == line('$') ? 'gg' : 'j'	" 最上面跳到底下
	nnoremap <silent><buffer><expr> k        line('.') == 1 ? 'G' : 'k'				" 最下面跳到顶部
	nnoremap <silent><buffer><expr> h    
				\ defx#is_opened_tree() ? 
				\ defx#do_action('close_tree', defx#get_candidate().action__path) : 
				\ defx#do_action('search',  fnamemodify(defx#get_candidate().action__path, ':h'))
	nnoremap <silent><buffer><expr> l        defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> u        defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> E        defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P        defx#do_action('preview')
	nnoremap <silent><buffer><expr> C        defx#do_action('toggle_columns',  'mark:indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S        defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> !        defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x        defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> ~        defx#do_action('cd')
	nnoremap <silent><buffer><expr> .        defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> q        defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space>  defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *        defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> m        defx#do_action('clear_select_all')
	nnoremap <silent><buffer><expr> r        defx#do_action('redraw')
	nnoremap <silent><buffer><expr> pr       defx#do_action('print')
	nnoremap <silent><buffer><expr> <        defx#do_action('resize',  defx#get_context().winwidth - 10)
	nnoremap <silent><buffer><expr> >        defx#do_action('resize',  defx#get_context().winwidth + 10)
	nnoremap <silent><buffer><expr> <2-LeftMouse>
endfunction

function! s:defx_toggle_tree() abort
	"Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction
" }}}

" fzf ===================================================================={{{
"map <LocalLeader>f :Files<CR>
map <leader>h :History<CR>
map <leader>b :Buffers<CR>
map <leader>l :Lines<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path "1;39" --color-line "1;31" --color-match "1;31"', 
			\                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
"command! -bang -nargs=* Ag
  "\ call fzf#vim#ag(<q-args>,
  "\                 <bang>0 ? fzf#vim#with_preview('up:60%')
  "\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  "\                 <bang>0)
nnoremap <silent> <Leader>s :Ag<CR>
" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '20split enew' }
" }}}

" LeaderF ===================================================================={{{
"function! s:ProjectRootDirectory() abort
   "return fnamemodify(finddir('.git', '.;'), ':h')
"endfunction

"let g:Lf_ReverseOrder = 1  "文件倒序
"let g:Lf_UseCache = 0   "启动LeaderF的时候刷新
"let g:Lf_RootMarkers = ['.git', '.hg', '.svn']
"let g:Lf_WorkingDirectoryMode = 'a'
"let g:Lf_WorkingDirectory = s:ProjectRootDirectory()
"nnoremap <silent> <Leader>f :LeaderfFile<CR>
"nnoremap <silent> <LocalLeader>f :LeaderfFile<CR>
"nnoremap <silent> <Leader>fu :LeaderfFunction<CR>
"nnoremap <silent> <Leader>h :LeaderfMru<CR>
"nnoremap <silent> <Leader>b :LeaderfBuffer<CR>
"let g:Lf_WindowPosition = 'popup'
"let g:Lf_PreviewInPopup = 0
" }}}

" coc ===================================================================={{{
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" }}}

" vim-airline ===================================================================={{{
let g:airline_theme="light" 
set laststatus=2
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1    " enable tabline
let g:airline#extensions#tabline#buffer_nr_show=1    " 显示buffer行号
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" mg979/vim-visual-multi ===================================================================={{{
"let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
"let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
"let g:VM_maps['i']                  = 'm'
"let g:VM_maps['I']                  = 'M'
let g:VM_maps['Find Under']         = '<C-m>'
let g:VM_maps['Find Subword Under'] = '<C-m>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<c-x>'
let g:VM_maps["Undo"]               = 'l'
let g:VM_maps["Redo"]               = '<C-r>'
" }}}

"禁止自动折叠
" vim-markdown ===================================================================={{{
let g:vim_markdown_folding_disabled=1
" }}}

" ag ===================================================================={{{
let g:ag_prg="/usr/local/bin/ag --vimgrep"
" }}}


" vim-gutentags ===================================================================={{{
source ~/dotfiles/gtags/gtags.vim
source ~/dotfiles/gtags/gtags-cscope.vim

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
"if executable('ctags')
	"let g:gutentags_modules += ['ctags']
"endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 " ctrl + ] 跳转下一个
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
" 避免多个项目数据库相互干扰
" 使用plus插件解决问题
let g:gutentags_auto_add_gtags_cscope = 0"
" }}}

" gutentags_plus ===================================================================={{{
" You can disable the default keymaps by:
let g:gutentags_plus_nomap = 1
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
" }}}


" vim-preview ===================================================================={{{
"P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
"noremap <Leader>u :PreviewScroll -1<cr>
"noremap <leader>d :PreviewScroll +1<cr>
" }}}

" vista.vim ===================================================================={{{
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
			\ 'cpp': 'coc',
			\ 'php': 'coc',
			\ }
let g:vista_ctags_cmd = {
			\ 'haskell': 'hasktags -x -o - -c',
			\ }
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
			\   "function": "\uf794",
			\   "variable": "\uf71b",
			\  }
"nnoremap <silent><nowait> <space>m :<C-u>Vista!!<cr>
nnoremap <silent> <Leader>t :<C-u>Vista!!<CR>
autocmd FileType vista nnoremap <silent><Esc> :Vista!<CR>
let g:vista_ignore_kinds = ['Variable']
" }}}

" emmet.vim ===================================================================={{{
let g:user_emmet_expandabbr_key = '<C-y>'
" }}}

" vim-easy-align ===================================================================={{{
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
	let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String']  }
" }}}


" vim-floaterm ===================================================================={{{
let g:floaterm_wintype='split'
"let g:floaterm_height=8

let g:floaterm_opener = 'drop'

let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'
let g:floaterm_title=''

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.4
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1"

map <Leader>g :FloatermNew lazygit<cr> 
"map <LocalLeader>f :FloatermNew fzf --preview 'ccat --color=always {}'<cr> 
map <Leader>f :FloatermNew fzf --preview 'cat {}'<cr> 

" Set floaterm window's background to black
hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=orange guifg=cyan
hi FloatermNC guibg=gray
" }}}"

" vim-expand-region ===================================================================={{{
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i)'  :1,
      \ 'i]'  :1,
      \ 'i}'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ 'it'  :0,
	  \}
" }}}"
" FlyGrep ===================================================================={{{
"nmap <Leader>s :FlyGrep<CR>
" }}}"
