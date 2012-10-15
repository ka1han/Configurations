; Emacs缺省功能
;; 外观
;;; 隐藏菜单栏
;; (menu-bar-mode 0)
;;; 隐藏滚动栏
(scroll-bar-mode 0)
;;; 高亮匹配的括号
(show-paren-mode 1)
;;; 隐藏工具栏
(tool-bar-mode 0)

;; 功能
(setq inhibit-startup-message t)
;;; 以父目录来区分同名缓冲区
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;;; 取消生成备份文件
(setq make-backup-files nil)
;;; 和其它程序共享剪贴板
(setq x-select-enable-clipboard t)
;;; 取消使用制表符
(setq-default indent-tabs-mode nil)

;; 键绑定
;;; 绑定C-c n为跳转到匹配的右括号
(global-set-key "\C-cn" 'forward-list)
;;; 绑定C-c p为跳转到匹配的左括号
(global-set-key "\C-cp" 'backward-list)
;;; 绑定C-tab为在窗口间切换
(global-set-key [C-tab] 'other-window)
;;; 绑定end为跳转到缓冲区的结尾处
(global-set-key [end] 'end-of-buffer)
;;; 绑定home为跳转到缓冲区的开始处
(global-set-key [home] 'beginning-of-buffer)

;; 缺省主模式
;;; CC
;;;; 设定C语言的缩进单元为4个字符的宽度
(setq c-basic-offset 4)

;;; CPerl
;;;; 为Perl源文件启动CPerl模式
;; (setq auto-mode-alist (cons '("\\.pl" . cperl-mode) auto-mode-alist))

; 第三方插件功能
;; 添加使用Paredit、rect-mark、showtip、sdcv、template插件所需要的路径
(add-to-list 'load-path "~/myEmacs/")
;; 通用文本编辑
;;; auto-complete
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq-default ac-sources
	      '(ac-source-words-in-same-mode-buffers
		ac-source-yasnippet))

;;; Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;;; rect-mark
(add-to-list 'load-path "~/myEmacs/")
(autoload 'rm-set-mark "rect-mark"
  "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
  "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
  "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
  "Copy a rectangular region to the kill ring." t)
(autoload 'rm-mouse-drag-region "rect-mark"
  "Drag out a rectangular region with the mouse." t)
(define-key ctl-x-map "r\C-@" 'rm-set-mark)
(define-key ctl-x-map [?r ?\C-\ ] 'rm-set-mark)
(define-key ctl-x-map "r\C-x" 'rm-exchange-point-and-mark)
(define-key ctl-x-map "r\C-w" 'rm-kill-region)
(define-key ctl-x-map "r\M-w" 'rm-kill-ring-save)
(define-key global-map [S-down-mouse-1] 'rm-mouse-drag-region)

;;; template
(require 'template)
(template-initialize)

;;; yasnippet
(add-to-list 'load-path "~/building/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/building/yasnippet-0.6.1c/snippets/")

;; 单语言编程
;;; C
;; (load "~/building/cedet-1.0/common/cedet")
;; (semantic-load-enable-code-helpers)
;;;; 绑定M-n为以弹出式菜单的方式提供候选的代码补全功能
;; (global-set-key "\M-n" 'semantic-ia-complete-symbol-menu)

;;; Clojure
;; (add-to-list 'load-path "~/opt/clojure-mode/")
;; (require 'clojure-mode)
;; (setq inferior-lisp-program "lein repl")

;;; Common Lisp
(add-to-list 'load-path "~/building/slime-2011-01-22/")
(setq slime-lisp-implementations
      '((sbcl-1.0.57 ("/home/liutos/bin/bin/sbcl" "--core" "/home/liutos/bin/lib/sbcl/sbcl.core")
		     :coding-system utf-8-unix)
	(ccl-1.8 ("/home/liutos/building/ccl/lx86cl") :coding-system utf-8-unix)
	(ccl ("/usr/local/bin/ccl") :coding-system utf-8-unix)
	(sbcl ("/usr/bin/sbcl" "--core" "/home/liutos/sbcl.core-for-slime")
	      :coding-system utf-8-unix)
	;; (new-sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
	(clisp ("/usr/local/bin/clisp") :coding-system utf-8-unix)
	(ecl ("/usr/local/bin/ecl") :coding-system utf-8-unix)))
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
;;;; 打开Lisp源文件时启动SLIME
(add-hook 'slime-mode-hook
	  (lambda ()
	    (unless (slime-connected-p)
	      (save-excursion (slime)))))
;;;; 将.lisp文件的主模式添加到auto-complete-mode将运行的模式列表中
;; (add-to-list 'ac-modes 'lisp-mode)
;;;; 绑定C-c e为调用macroexpand-1函数展开当前宏调用
(define-key lisp-mode-map "\C-ce" 'slime-macroexpand-1)
;;; 在Emacs-w3m中浏览HyperSpec文档
(setq browse-url-browser-function
      '(("/home/liutos/myEmacs/HyperSpec/" . w3m-browse-url)
	("." . browse-url-browser-function)))
;;;; 设定HyperSpec文档的本地位置
(setq common-lisp-hyperspec-root "/home/liutos/myEmacs/HyperSpec/")
;;;; 绑定C-c f为交换()和[]的默认键映射
;; (defvar *exchange-status* 0
;;   "The exchange status of parenthesis and bracket. 0 means unchanged and 1 means the key map has been changed.")
;; (defun exchange-parenthesis-bracket ()
;;   "Exchange the key map of the parenthesises and square brackets."
;;   (interactive)
;;   (cond ((= 0 *exchange-status*)
;; 	 (define-key key-translation-map [?\(] [?\[])
;; 	 (define-key key-translation-map [?\)] [?\]])
;; 	 (define-key key-translation-map [?\[] [?\(])
;; 	 (define-key key-translation-map [?\]] [?\)])
;; 	 (setq *exchange-status* 1))
;; 	(t
;; 	 (define-key key-translation-map [?\[] [?\[])
;; 	 (define-key key-translation-map [?\]] [?\]])
;; 	 (define-key key-translation-map [?\(] [?\(])
;; 	 (define-key key-translation-map [?\)] [?\)])
;; 	 (setq *exchange-status* 0))))
;; (global-set-key "\C-cf" 'exchange-parenthesis-bracket)
;;;; 添加ParEdit次模式
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;;;; 添加SLIME对cl-annot库的支持
(require 'slime-annot)

;;; Dot
(load-file "~/myEmacs/graphviz-dot-mode.el")

;;; Dylan
;; (add-to-list 'load-path "/home/liutos/myEmacs/dylan-lang-dylan-mode-c101cff/")
;; (autoload 'dylan-mode "dylan-mode" "Dylan-mode" t)
;; (add-to-list 'auto-mode-alist '("\\.dylan\\'" . dylan-mode))
;; (setq inferior-dylan-program "/opt/opendylan-2011.1/bin/dswank")
;; (require 'dime)
;; (dime-setup '(dime-dylan dime-repl dime-compiler-notes-tree))

;;; Erlang
;; (add-to-list 'load-path "/usr/lib/erlang/lib/tools-2.6.5/emacs/")
;; (require 'erlang-start)
;; (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
;; (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
;; (setq erlang-root-dir "/usr/lib/erlang/")
;; (add-to-list 'exec-path "/usr/lib/erlang/bin/")
;; (setq erlang-man-root-dir "/usr/lib/erlang/man/")
;;;; 将erlang-mode添加到auto-complete-mode所监听的模式列表中
;; (add-to-list 'ac-modes 'erlang-mode)

;;; Haskell
;; (load "~/building/haskell-mode-2.8.0/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (setq haskell-program-name "/usr/local/bin/ghci")

;;; Lua
;; (add-to-list 'load-path "~/building/immerrr-lua-mode-a070284/")
;; (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;; (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;;; OCaml
;; (add-to-list 'load-path "~/building/ocaml-3.12.0/emacs/")
;; (setq auto-mode-alist
;;       (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
;; (autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
;; (autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;; (if window-system (require 'caml-font))

;;; Python
;; (add-to-list 'load-path "~/building/python-mode.el-6.0.3/")
;; (require 'python-mode)

;;; Scheme
;; (setq scheme-program-name "/usr/local/bin/scheme48")
;; (add-to-list 'load-path "~/building/scheme48-1.8/emacs/")
;; (autoload 'run-scheme "cmuscheme48" "Run an inferior Scheme process." t)
;; (add-to-list 'auto-mode-alist '("\\.scm$" . scheme-mode))

;;; Scheme
;; (load "~/building/geiser-0.2/build/elisp/geiser-load")
;; (setq geiser-racket-binary "/home/liutos/building/racket-5.2/bin/racket")

;;; Smalltalk
;; (setq auto-mode-alist
;;       (append '(("\\.st\\'" . smalltalk-mode))
;; 	      auto-mode-alist))
;; (autoload 'smalltalk-mode "~/building/smalltalk-3.2.4/smalltalk-mode.elc" "" t)

;; 多语言编程
;;; Cscope
(add-to-list 'load-path "~/building/cscope-15.7a/contrib/xcscope/")
(require 'xcscope)

;;; MMM
;; (require 'mmm-mode)
;; (setq mmm-global-mode 'maybe)
;; (mmm-add-mode-ext-class 'html-mode "\\.php\\" 'html-php)
;; (mmm-add-mode-ext-class 'html-mode "\\.html\\" 'html-js)
;; (mmm-add-mode-ext-class 'html-mode "\\.html\\" 'embedded-css)

;;; Zencoding
;; (add-to-list 'load-path "~/building/rooney-zencoding-fc15836/")
;; (require 'zencoding-mode)
;;;; 在书写HTML文档时自动启动zencoding-mode
;; (add-hook 'html-mode-hook 'zencoding-mode)

;; 结构化文档编辑
;;; AUCTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-parse-self t)

;;; Markdown
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text" . markdown-mode))

;;; Org
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(setq org-log-done t)
;;;; 添加自动换行
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines nil)))
;;;; 隐藏不必要的前缀星号
(setq org-hide-leading-stars t)
;;; 设定Agenda模式的扫描文件列表
(setq org-agenda-files (list "~/src/org/wants.org"))

;; 外部环境交互
;;; EMMS - Emacs MultiMedia System
(add-to-list 'load-path "~/building/emms/lisp")
(require 'emms-setup)
(emms-standard)
(emms-default-players)
;;;; 设定EMMS的多媒体文件默认搜索路径
(setq emms-source-file-default-directory "~/music/")

;;; Maxima - Computer Algebra System
;; (autoload 'maxima-mode "maxima" "Maxima mode" t)
;; (autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
;; (autoload 'maxima "maxima" "Maxima interaction" t)
;; (autoload 'imath-mode "imath" "Imath mode for math formula input" t)
;;;; 启用imaxima模式时同时启动maxima模式
;; (setq imaxima-use-maxima-mode-flag t)

;;; Sawfish - Window Manager
(add-to-list 'load-path "~/building/sawfish-1.8.1/")
(autoload 'sawfish-mode "sawfish" "sawfish-mode" t)
(setq auto-mode-alist (cons '("\\.sawfishrc$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.jl$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.sawfish/rc$" . sawfish-mode) auto-mode-alist))

;;; sdcv - StarDict Command-line Version
(require 'showtip)
(require 'sdcv)
;;;; 绑定C-c d为查找当前光标所在处的单词的解释
(global-set-key "\C-cd" 'sdcv-search-pointer+)

;;; w3m - text-based browser
(require 'w3m-load)

;; 其它
;;; color-theme
(add-to-list 'load-path "~/building/color-theme-6.6.0/")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-xemacs)))

; 自己定义的功能
;; 绑定C-c x为将当前窗口和左上角的窗口进行互换
(defun get-top-left-window ()
  "Return the window at the top-left corner."
  (get-window-with-predicate
   #'(lambda (window)
       (let ((pos (window-edges window)))
	 (and (= 0 (nth 0 pos))
	      (= 0 (nth 1 pos)))))))
(defun swap-current-buffer-to-top-left ()
  "Swap the buffer in the current window with the buffer in the window at the top-left corner."
  (interactive)
  (let ((cur-buffer (window-buffer))
	(top-left-window (get-top-left-window)))
    (let ((top-left-buffer (window-buffer top-left-window)))
      (switch-to-buffer top-left-buffer)
      (select-window top-left-window)
      (switch-to-buffer cur-buffer))))
(global-set-key "\C-cx" 'swap-current-buffer-to-top-left)
;; 绑定F11为切换菜单栏的显示状态
;; (defvar *menu-bar-toggle-status* 0
;;   "The display status of the menu bar. 0 means hidden and 1 means showed.")
;; (defun menu-bar-toggle ()
;;   (interactive)
;;   (menu-bar-mode *menu-bar-toggle-status*)
;;   (if (= 1 *menu-bar-toggle-status*)
;;       (setq *menu-bar-toggle-status* 0)
;;     (setq *menu-bar-toggle-status* 1)))
;; (global-set-key [f11] 'menu-bar-toggle)
;; 绑定M-g g为临时显示行号并按行进行跳转
(defun my-goto-line ()
  "Turn on the LINUM-MODE in the current buffer and invoke function GOTO-LINE and finally turn off LINUM-MODE."
  (interactive)
  (linum-mode 1)
  (unwind-protect (let ((linum (string-to-number (read-from-minibuffer "Goto line: "))))
		    (progn
		      (goto-char (point-min))
		      (forward-line (1- linum))))
    (linum-mode 0)))
(global-set-key "\M-gg" 'my-goto-line)