"""""""" 插件管理vim-plug""""""""
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'                     " 状态栏增强
Plug 'vim-airline/vim-airline-themes'              " 状态栏增强
Plug 'christoomey/vim-tmux-navigator'              " 让vim能兼容tmux
Plug 'terryma/vim-expand-region'                   " v/V 快速选择区域/取消选择区域
Plug 'terryma/vim-multiple-cursors'                " ctrl-m 多光标操作
Plug 'scrooloose/nerdcommenter'                    " 快速注释/解开注释
Plug 'jiangmiao/auto-pairs'                        " 自动补全括号
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " 自动补全
Plug 'rking/ag.vim'                                " 搜索
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'

Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  } " <Leader>f/b/h 快速打开文件
                                                   
" 文件目录树
if has('nvim')
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
else
	Plug 'Shougo/defx.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

"Snippets are separated from the engine. Add this if you want them:
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'godlygeek/tabular'                           " <Leader>符号 快速对齐
Plug 'plasticboy/vim-markdown'                     " markdown插件
call plug#end()
filetype plugin indent on

let mapleader=','
let g:mapleader=','
let g:maplocalleader=';'

" 引入插件的设置

" defx ===================================================================={{{
map <Tab> :Defx<cr>
 " 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
nnoremap <silent> <LocalLeader>e
			\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>
nnoremap <silent> <LocalLeader>a
			\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
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
	nnoremap <silent><buffer><expr> o     <SID>defx_toggle_tree()                    " 打开或者关闭文件夹，文件
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')     " 显示隐藏文件
	nnoremap <silent><buffer><expr> <C-r> defx#do_action('redraw')
	nnoremap <silent><buffer><expr> u     defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> <CR>
	                \ defx#is_directory() ? 
	                \ defx#do_action('open_tree') : 
	                \ defx#do_action('multi', ['drop', 'quit'])
endfunction

function! s:defx_toggle_tree() abort
	"Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction
" }}}

" LeaderF ===================================================================={{{
"function! s:ProjectRootDirectory() abort
	"return fnamemodify(finddir('.git', '.;'), ':h')
"endfunction

 "let g:Lf_ReverseOrder = 1  "文件倒序
 let g:Lf_UseCache = 0   "启动LeaderF的时候刷新
 let g:Lf_RootMarkers = ['.git', '.hg', '.svn']
 let g:Lf_WorkingDirectoryMode = 'a'
 "let g:Lf_WorkingDirectory = s:ProjectRootDirectory()
 nnoremap <silent> <Leader>f :LeaderfFile<CR>
 nnoremap <silent> <Leader>fu :LeaderfFunction<CR>
 nnoremap <silent> <Leader>h :LeaderfMru<CR>
 nnoremap <silent> <Leader>b :LeaderfBuffer<CR>
 nnoremap <silent> <LocalLeader>f :LeaderfFile
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

" tabular ===================================================================={{{
nmap <Leader>=       :Tabularize /=<CR>
vmap <Leader>=       :Tabularize /=<CR>
nmap <Leader>==       :Tabularize /=><CR>
vmap <Leader>==       :Tabularize /=><CR>
nmap <Leader>"       :Tabularize /"<CR>
nmap <Leader>"       :Tabularize /"<CR>
vmap <Leader>'       :Tabularize /'<CR>
vmap <Leader>'       :Tabularize /'<CR>
nmap <Leader>(       :Tabularize /(<CR>
vmap <Leader>(       :Tabularize /(<CR>
nmap <Leader>)       :Tabularize /)<CR>
vmap <Leader>)       :Tabularize /)<CR>
nmap <Leader>;       :Tabularize /,<CR>
vmap <Leader>;       :Tabularize /,<CR>
nmap <Leader>[       :Tabularize /[<CR>
vmap <Leader>[       :Tabularize /[<CR>
nmap <Leader>]       :Tabularize /]<CR>
vmap <Leader>]       :Tabularize /]<CR>
nmap <Leader>{       :Tabularize /{<CR>
vmap <Leader>{       :Tabularize /{<CR>
nmap <Leader>}       :Tabularize /}<CR>
vmap <Leader>}       :Tabularize /}<CR>
nmap <Leader>-       :Tabularize /-<CR>
vmap <Leader>-       :Tabularize /-<CR>
nmap <Leader>/       :Tabularize //<CR>
vmap <Leader>/       :Tabularize //<CR>
nmap <Leader>:       :Tabularize /:<CR>
vmap <Leader>:       :Tabularize /:<CR>
nmap <Leader><space> :Tabularize / <CR>
vmap <Leader><space> :Tabularize / <CR>
nmap <Leader>\|      :Tabularize /\|<CR>
vmap <Leader>\|      :Tabularize /\|<CR>
" in insert mode，if code is already aligned by |, then vim can auto aligned code when input |
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
" }}}

" vim-airline ===================================================================={{{
let g:airline_theme="light" 
set laststatus=2
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1    " enable tabline
let g:airline#extensions#tabline#buffer_nr_show=1    " 显示buffer行号
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" vim-expand-region ===================================================================={{{
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" vim-multiple-cursors ===================================================================={{{
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

"禁止自动折叠
" vim-markdown ===================================================================={{{
let g:vim_markdown_folding_disabled=1
" }}}

" ag ===================================================================={{{
let g:ag_prg="/usr/local/bin/ag --vimgrep"
" }}}

"vimrc 中设置环境变量启用 pygments
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/gtags/share/gtags/gtags.conf'  "此路径根据实际设置（ find一下）

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'"

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0"
let g:gutentags_trace = 1

"P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
"noremap <Leader>u :PreviewScroll -1<cr>
"noremap <leader>d :PreviewScroll +1<cr>
