set background=light
hi clear

"Console
"======================================================================================================================="
hi        Cursor         ctermfg=Black            ctermbg=White             cterm=NONE        "光标所在的字符
hi        CursorColumn                            ctermbg=255				cterm=NONE        "光标所在的屏幕列
hi        CursorLine                              ctermbg=255				cterm=NONE        "光标所在的屏幕行
hi        Directory      ctermfg=Blue             ctermbg=231               cterm=NONE        "目录名

hi        DiffAdd                                 ctermbg=227				cterm=NONE        "diff: 增加的行
hi        DiffDelete                              ctermbg=254				cterm=NONE        "diff: 删除的行
hi        DiffChange                              ctermbg=189				cterm=NONE        "diff: 改变的行
hi        DiffText								  ctermbg=215				cterm=NONE        "diff: 改变行里的改动文本

hi        ErrorMsg       ctermfg=lightmagenta     ctermbg=black             cterm=BOLD        "命令行上的错误信息
hi        VertSplit      ctermfg=lightmagenta     ctermbg=lightblue         cterm=BOLD        "分离垂直分割窗口的列
hi        Folded         ctermfg=darkgrey		  ctermbg=231				cterm=BOLD        "用于关闭的折叠的行
hi        IncSearch      ctermfg=231			  ctermbg=black				cterm=BOLD        "'incsearch' 高亮
hi        LineNr         ctermfg=252			  ctermbg=231				cterm=BOLD        "置位 number 选项时的行号
hi        MatchParen	 ctermfg=red			  ctermbg=254				cterm=NONE        "配对的括号
hi        ModeMsg        ctermfg=lightgreen       ctermbg=black             cterm=BOLD        "showmode 消息(INSERT)
hi        MoreMsg        ctermfg=lightcyan        ctermbg=black             cterm=BOLD        "|more-prompt|
hi        NonText        ctermfg=lightcyan        ctermbg=231				cterm=BOLD        "窗口尾部的'~'和 '@'
hi        Normal         ctermfg=black			  ctermbg=231				cterm=BOLD        "正常内容

hi        Pmenu          ctermfg=lightgrey        ctermbg=lightblue         cterm=BOLD        "弹出菜单普通项目
hi        PmenuSel       ctermfg=yellow           ctermbg=lightmagenta      cterm=BOLD        "弹出菜单选中项目
hi        PmenuSbar      ctermfg=lightcyan        ctermbg=231				cterm=BOLD        "弹出菜单滚动条。
hi        PmenuThumb     ctermfg=black            ctermbg=lightgreen        cterm=BOLD        "弹出菜单滚动条的拇指

hi        Question       ctermfg=34				  ctermbg=231				cterm=BOLD        "提示和 yes/no 问题
hi        Search         ctermfg=231			  ctermbg=33				cterm=BOLD        "最近搜索模式的高亮
hi        SpecialKey     ctermfg=red			  ctermbg=231				cterm=BOLD        "特殊键，字符和'listchars'
hi        SpellBad       ctermfg=21				  ctermbg=231				cterm=BOLD        "拼写检查器不能识别的单词
hi        SpellCap       ctermfg=21				  ctermbg=231				cterm=BOLD        "应该大写字母开头的单词
hi        SpellLocal     ctermfg=21				  ctermbg=231				cterm=BOLD        "只在其它区域使用的单词
hi        SpellRare      ctermfg=21				  ctermbg=231				cterm=BOLD        "很少使用的单词
hi        StatusLine     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "当前窗口的状态行
hi        StatusLineNC   ctermfg=yellow           ctermbg=black             cterm=BOLD        "非当前窗口的状态行
hi        TabLine        ctermfg=black            ctermbg=231               cterm=BOLD        "非活动标签页标签
hi        TabLineFill    ctermfg=black            ctermbg=lightgrey         cterm=BOLD        "没有标签的地方
hi        TabLineSel     ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "活动标签页标签
hi        Title          ctermfg=black			  ctermbg=231				cterm=BOLD        ":set all 等输出的标题
hi        Visual         ctermfg=yellow           ctermbg=lightblue         cterm=BOLD        "可视模式的选择区
hi        WarningMsg     ctermfg=red			  ctermbg=231				cterm=BOLD        "警告消息
hi        WildMenu       ctermfg=lightgreen       ctermbg=lightblue         cterm=BOLD        "wildmenu补全的当前匹配
"======================================================================================================================="
"Console group-name
"======================================================================================================================="
hi        Comment        ctermfg=250										cterm=NONE        "任何注释 
"-----------------------------------------------------------------------------------------------------------------------"
hi        Constant       ctermfg=196				ctermbg=231             cterm=BOLD        "任何常数
hi        String         ctermfg=28											cterm=BOLD        "一个字符串常数: "字符串"
hi        Character      ctermfg=Red				ctermbg=231             cterm=BOLD        "一个字符常数: 'c'、'\n'
hi        Number         ctermfg=Red										cterm=BOLD        "一个数字常数: 234、0xff
hi        Float          ctermfg=Red										cterm=BOLD        "一个浮点常数: 2.3e10
hi        Boolean        ctermfg=Red										cterm=BOLD        "一个布尔型常数: TRUE、false
"-----------------------------------------------------------------------------------------------------------------------"
hi        Identifier     ctermfg=88											cterm=BOLD        "任何变量名
hi        Function       ctermfg=black				ctermbg=231             cterm=BOLD        "函数名 (也包括: 类的方法名)
"-----------------------------------------------------------------------------------------------------------------------"
hi        Statement      ctermfg=black				ctermbg=231				cterm=BOLD        "任何语句
hi        Conditional    ctermfg=21					ctermbg=231				cterm=BOLD        "if、then、else、endif、switch
hi        Repeat         ctermfg=21					ctermbg=231				cterm=BOLD        "for、do、while 等
hi        Label          ctermfg=21					ctermbg=231				cterm=BOLD        "case、default 等
hi        Operator       ctermfg=black				ctermbg=231				cterm=BOLD        ""sizeof"、"+"、"*" 等
hi        Keyword        ctermfg=21					ctermbg=231				cterm=BOLD        "任何其它关键字
hi        Exception      ctermfg=21					ctermbg=231				cterm=BOLD        "try、catch、throw
"-----------------------------------------------------------------------------------------------------------------------"
hi        PreProc        ctermfg=21					ctermbg=231             cterm=BOLD        "通用预处理命令
hi        Include        ctermfg=21					ctermbg=231             cterm=BOLD        "预处理命令 #include
hi        Define         ctermfg=21					ctermbg=231             cterm=BOLD        "预处理命令 #define
hi        Macro          ctermfg=21					ctermbg=231             cterm=BOLD        "等同于 Define
hi        PreCondit      ctermfg=21					ctermbg=231             cterm=BOLD        "预处理命令 #if、#else、#endif
"-----------------------------------------------------------------------------------------------------------------------"
hi        Type           ctermfg=21					ctermbg=231             cterm=BOLD        "int、long、char 等
hi        StorageClass   ctermfg=21					ctermbg=231             cterm=BOLD        "static、register、volatile 等
hi        Structure      ctermfg=21					ctermbg=231             cterm=BOLD        "struct、union、enum 等
hi        Typedef        ctermfg=21					ctermbg=231             cterm=BOLD        "一个 typedef
"-----------------------------------------------------------------------------------------------------------------------"
hi        Special        ctermfg=black				ctermbg=231             cterm=BOLD        "任何特殊符号
hi        SpecialChar    ctermfg=black				ctermbg=231             cterm=BOLD        "常数中的特殊字符
hi        Tag            ctermfg=lightcyan			ctermbg=231             cterm=BOLD        "这里可以使用 CTRL-]
hi        Delimiter      ctermfg=black				ctermbg=231             cterm=BOLD        "需要注意的字符
hi        SpecialComment ctermfg=lightred			ctermbg=231             cterm=BOLD        "注释里的特殊字符
hi        Debug          ctermfg=red				ctermbg=231             cterm=BOLD        "调试语句
"-----------------------------------------------------------------------------------------------------------------------"
hi        Underlined     ctermfg=lightcyan			ctermbg=231             cterm=BOLD        "需要突出的文本，HTML 链接
hi        Ignore         ctermfg=darkgrey			ctermbg=231             cterm=NONE        "留空，被隐藏
hi        Error          ctermfg=Red				ctermbg=231				cterm=BOLD        "任何有错的构造
hi        Todo           ctermfg=Black				ctermbg=231				cterm=BOLD        "任何需要特殊注意的部分
"======================================================================================================================="


" - PHP -
hi		  phpVarSelector ctermfg=88
"hi		  phpKeyword	 ctermfg=21
"hi		  phpRepeat		 ctermfg=21
"hi		  phpConditional ctermfg=21
"hi		  phpStatement	 ctermfg=21
"hi		  phpFunctions	 ctermfg=21
"hi		  phpType		 ctermfg=21
"hi		  phpTodo		 ctermfg=red
"hi		  phpMemberSelector	ctermfg=black
"
"" - HTML -
"hi		  htmlTag				ctermfg=29
"hi		  htmlEndTag			ctermfg=29
"hi		  htmlTagName			ctermfg=29
"hi	      htmlArg				ctermfg=90
"hi		  htmlString			ctermfg=21 
"hi		  htmlScript			ctermfg=21
"hi		  htmlScriptTag			ctermfg=21
"hi	      htmlScriptEndTag		ctermfg=21
"hi	      htmlSpecialTagName    ctermfg=21
"hi	      htmlError				ctermfg=black
"hi		  htmlLink				ctermfg=black
"
"" JavaScript Highlighting
"hi		  javaScriptBoolean            ctermfg=brown
"hi		  javaScriptConditional        ctermfg=90
"hi		  javaScriptRepeat             ctermfg=90
"hi		  javaScriptStatement          ctermfg=90
"hi		  javaScriptIdentifier         ctermfg=90
"hi		  javaScriptException          ctermfg=90
"hi		  javaScriptBranch             ctermfg=90
"hi		  javaScriptLabel              ctermfg=90
"hi		  javaScriptFunction           ctermfg=90
"hi		  javaScriptGlobal             ctermfg=31
"hi		  javaScriptMember             ctermfg=darkgrey
"hi		  javaScriptMessage            ctermfg=darkgrey
"hi		  javaScriptOperator           ctermfg=darkgrey
"hi		  javaScriptParens             ctermfg=black
"hi		  javaScriptBraces             ctermfg=black
"hi		  javaScriptSpecial            ctermfg=31
"hi		  javaScriptSpecialCharacter   ctermfg=31
"hi		  javaScriptStringD            ctermfg=21
"hi		  javaScriptStringS            ctermfg=21
"hi		  javaScriptThis               ctermfg=brown
"hi		  javaScriptType               ctermfg=brown
"hi		  javaScriptNumber             ctermfg=Red
"hi		  javaScriptNull               ctermfg=brown
