#!/usr/bin/python3

"""
调用方式： ~/.vim/cut_copy.py  f1 f2 d1/ d2/ cut or copy
把相关的文件/目录的绝对路径写到文件里保存
最后一个参数代表粘贴的时候是复制copy还是移动mv
"""

import sys


argv = sys.argv
with open('/tmp/tmp_clipboard.txt', 'w') as f:
    f.write('\n'.join(argv[1:]))
