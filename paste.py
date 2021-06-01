#!/usr/bin/python3

"""
需要粘贴的文件路径已经存放在文件~/.vim/tmp_clipboard.txt
文件最后一行表示要cut还是copy, 。
调用方法： ~/.vim/paste.py dst
"""
import os
import sys
import shutil
def clean_dst(one_path, dst):
    """
    当dst是一个目录时，要把剪贴板上的文件和目录都放到dst下面;
    当dst是一个文件时，要把剪贴板上的文件和目录都放到其父目录下。
    函数的功能就是清理dst,使得粘贴的时候不会发生文件存在异常。
    """
    dst = os.path.dirname(dst) if os.path.isfile(dst) else dst
    path = os.path.join(dst, os.path.basename(one_path))
    if path == one_path:
        return None

    if os.path.exists(path):
        try:
            os.remove(path)
        except:
            shutil.rmtree(path)
    return path


def paste():
    """
    完成粘贴任务，如果同名目标已经存在，就覆盖
    """
    dst = sys.argv[1].strip()
    FILE = "/tmp/tmp_clipboard.txt"
    if os.path.exists(FILE):
        with open(FILE) as f:
            files = f.readlines()

    # 查看复制还是剪切
    CUT = True if files[-1].strip() == 'cut' else False
    for f in files[: -1]:
        f = f.strip()
        if not f:
            continue
        dst_f = clean_dst(f, dst)
        if dst_f is None:  # 粘贴到原位置
            continue
        if CUT:
            shutil.move(f, dst_f)
        else:
            try:
                shutil.copy(f, dst_f)
            except:
                shutil.copytree(f, dst_f)


assert len(sys.argv) == 2, '输入dst'
paste()
