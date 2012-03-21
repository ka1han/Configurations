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
(setq auto-mode-alist (cons '("\\.pl" . cperl-mode) auto-mode-alist))

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
;;; Common Lisp
(add-to-list 'load-path "~/building/slime-2011-01-22/")
(setq slime-lisp-implementations
      '((sbcl ("/usr/bin/sbcl" "--core" "/home/liutos/sbcl.core-for-slime")
	      :coding-system utf-8-unix)
	(clisp ("/usr/local/bin/clisp") :coding-system utf-8-unix)
	(ccl ("/usr/local/bin/ccl") :coding-system utf-8-unix)))
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
;;;; 打开Lisp源文件时启动SLIME
(add-hook 'slime-mode-hook
	  (lambda ()
	    (unless (slime-connected-p)
	      (save-excursion (slime)))))
;;; 将.lisp文件的主模式添加到auto-complete-mode将运行的模式列表中
(add-to-list 'ac-modes 'lisp-mode)
;;;; 绑定C-c e为调用macroexpand-1函数展开当前宏调用
(global-set-key "\C-ce" 'slime-macroexpand-1)
;;; 在Emacs-w3m中浏览HyperSpec文档
(setq browse-url-browser-function
      '(("/home/liutos/myEmacs/HyperSpec/" . w3m-browse-url)
	("." . browse-url-browser-function)))
;;;; 设定HyperSpec文档的本地位置
(setq common-lisp-hyperspec-root "/home/liutos/myEmacs/HyperSpec/")

;;; Haskell
(load "~/building/haskell-mode-2.8.0/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-program-name "/usr/local/bin/ghci")

;;; Lua
(add-to-list 'load-path "~/building/immerrr-lua-mode-a070284/")
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;;; OCaml
(add-to-list 'load-path "~/building/ocaml-3.12.0/emacs/")
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
(if window-system (require 'caml-font))

;;; Python
(add-to-list 'load-path "~/building/python-mode.el-6.0.3/")
(require 'python-mode)

;;; Scheme
(setq scheme-program-name "/usr/local/bin/scheme48")
(add-to-list 'load-path "~/building/scheme48-1.8/emacs/")
(autoload 'run-scheme "cmuscheme48" "Run an inferior Scheme process." t)

;; 多语言编程
;;; Cscope
(add-to-list 'load-path "~/building/cscope-15.7a/contrib/xcscope/")
(require 'xcscope)

;; 结构化文档编辑
;;; AUCTeX
(load "auctex.el" nil t t)

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
(setq org-agenda-files (list "~/org/coding.org"
			     "~/org/lang.org"
			     "~/src/org/gtd.org"))

;; 外部环境交互
;;; EMMS - Emacs MultiMedia System
(add-to-list 'load-path "~/building/emms/lisp")
(require 'emms-setup)
(emms-standard)
(emms-default-players)
;;;; 设定EMMS的多媒体文件默认搜索路径
(setq emms-source-file-default-directory "~/music/")

;;; Maxima - Computer Algebra System
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
;;;; 启用imaxima模式时同时启动maxima模式
(setq imaxima-use-maxima-mode-flag t)

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
(defvar *menu-bar-toggle-status* 1
  "The display status of the menu bar. 0 means hidden and 1 means showed.")
(defun menu-bar-toggle ()
  (interactive)
  (menu-bar-mode *menu-bar-toggle-status*)
  (if (= 1 *menu-bar-toggle-status*)
      (setq *menu-bar-toggle-status* 0)
    (setq *menu-bar-toggle-status* 1)))
(global-set-key [f11] 'menu-bar-toggle)
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