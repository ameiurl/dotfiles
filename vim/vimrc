let s:curdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let &rtp.=','.s:curdir

" Set leader key
let mapleader = ','

" Load configs
for fpath in split(globpath(expand(s:curdir.'/config'), '*.vim'), '\n')
  exe 'source' fpath
endfor
