"""""""" 插件管理vim-plug""""""""
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
" -------------------------------插件列表----------------------------------
" 被动技能
Plug 'jiangmiao/auto-pairs'       " 自动补全括号
Plug 'vim-airline/vim-airline'    " 状态栏增强
Plug 'vim-airline/vim-airline-themes' " 状态栏增强
Plug 'christoomey/vim-tmux-navigator' " 让vim能兼容tmux

" 主动技能
Plug 'majutsushi/tagbar'          " <Leader>t tag列表
Plug 'godlygeek/tabular'          " <Leader>符号 快速对齐
Plug 'scrooloose/nerdcommenter'	  " 快速注释/解开注释
Plug 'terryma/vim-expand-region'  " v/V 快速选择区域/取消选择区域
Plug 'terryma/vim-multiple-cursors' " ctrl-m 多光标操作
Plug 'rking/ag.vim'

"文件目录树
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
else
	Plug 'Shougo/defx.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

"自动补全
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}

"<Leader>f/b/h 快速打开文件
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }

"Snippets are separated from the engine. Add this if you want them:
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"markdown插件
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'plasticboy/vim-markdown'"
call plug#end()
filetype plugin indent on

let mapleader=','
let g:mapleader=','
let g:maplocalleader=';'

" 引入插件的设置

" tagbar ===================================================================={{{
nmap <Leader>t :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1
let g:tagbar_left=0 " 在左边显示
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width = 30
let g:tagbar_sort = 0

let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
	\ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constants',
        \ 'f:functions',
        \ 'j:javascript functions:1'
    \ 
	\]
	\}
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

" defx ===================================================================={{{
map <Tab> :Defx<cr>
 " 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
"nnoremap <silent> <LocalLeader>e
			"\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>
"nnoremap <silent> <LocalLeader>a
			"\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
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
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> u  defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> <CR>
	                \ defx#is_directory() ? 
	                \ defx#do_action('open_tree') : 
	                \ defx#do_action('multi', ['drop'])
endfunction

function! s:defx_toggle_tree() abort
	"Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop'])
endfunction
" }}}

" LeaderF ===================================================================={{{
 let g:Lf_ReverseOrder = 1
 nnoremap <silent> <Leader>h :LeaderfMru<CR>
 nnoremap <silent> <Leader>f :LeaderfFile<CR>
 nnoremap <silent> <Leader>b :LeaderfBuffer<CR>
 nnoremap <silent> <LocalLeader>t :LeaderfFunction<CR>
 nnoremap <LocalLeader>f :LeaderfFile 
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

"解决启动稍微延迟问题
let g:coc_start_at_startup=0
function! CocTimerStart(timer)
	exec "CocStart"
endfunction
call timer_start(500,'CocTimerStart',{'repeat':1})

"解决coc.nvim大文件卡死状况
let g:trigger_size = 0.5 * 1048576

augroup hugefile
	autocmd!
	autocmd BufReadPre *
				\ let size = getfsize(expand('<afile>')) |
				\ if (size > g:trigger_size) || (size == -2) |
				\   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
				\   exec 'CocDisable' |
				\ else |
				\   exec 'CocEnable' |
				\ endif |
				\ unlet size
augroup END

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" }}}

" tabular ===================================================================={{{
nmap <Leader>=       :Tabularize /=<CR>
vmap <Leader>=       :Tabularize /=<CR>
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

" ag ===================================================================={{{
let g:ag_prg="/usr/local/bin/ag --vimgrep"
" }}}
