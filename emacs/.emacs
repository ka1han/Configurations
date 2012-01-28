; 利用分号的数量来表示代码的层次
; 将对Emacs的缺省功能的设置放到文件的最后
; 自定义的函数在需要使用的位置前定义

; Emacs缺省模式的配置
;; CC模式
;;; 设置C语言的缩进单元为4个空白符的宽度
(setq c-basic-offset 4)
;; CPerl模式
(setq auto-mode-alist (cons '("\\.pl" . cperl-mode) auto-mode-alist))
;; Org模式
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(setq org-log-done )
;;; 在Org模式中开启自动换行功能
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines nil)))
;;; 只显示表示层次的连续星号的最前面的一个
(setq org-hide-leading-stars t)
;;; 设定给agenda扫描的以生成TODO列表的.org文件
(setq org-agenda-files (list "~/org/coding.org"))
;; Scheme模式
(setq scheme-program-name "/usr/local/bin/scheme48")

; Emacs的额外插件的配置
;; AUCTeX
(load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;;; 输入换行时缩进新行
;; (setq TeX-newline-function 'newline-and-indent)

;; auto-complete
;; (add-to-list 'load-path "~/.emacs.d/")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;; (ac-config-default)
;; (setq-default ac-sources
;; 	      '(ac-source-words-in-same-mode-buffers
;; 		ac-source-yasnippet))
;;; 在键入5个字符之后弹出补全菜单
;; (setq ac-auto-start 5)
;;; 在0.7秒之后再显示补全菜单
;; (setq ac-auto-show-menu 0.7)
;;; 设定颜色
;; (set-face-background 'ac-candidate-face "gray")
;; (set-face-underline-p 'ac-candidate-face "black")
;; (set-face-background 'ac-selection-face "blue")

;; CEDET
;; (load "~/building/cedet-1.0/common/cedet")
;; (semantic-load-enable-code-helpers)
;; (require 'semantic-tag-folding nil 'noerror)
;; (global-semantic-tag-folding-mode 1)
;;; 绑定M-n组合键为调出弹出式的代码补全选项菜单的功能
;; (global-set-key "\M-n" 'semantic-ia-complete-symbol-menu)

;; color-theme
(add-to-list 'load-path "~/building/color-theme-6.6.0/")
(require 'color-theme)
(defvar *theme*
  '(color-theme-blippblopp
    color-theme-gray1
    color-theme-gray30
    color-theme-hober
    color-theme-jedit-grey
    color-theme-katester
    color-theme-kingsajz
    color-theme-pok-wog
    color-theme-shaman
    color-theme-subtle-hacker
    color-theme-snowish
    color-theme-xemacs))
;; (eval-after-load "color-theme"
;;   `(progn
;;      (color-theme-initialize)
;;      (,(let ((len (length *theme*)))
;; 	 (nth (mod (car (decode-time)) len)
;; 	      *theme*)))))
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-xemacs)))

;; Cscope
(add-to-list 'load-path "~/building/cscope-15.7a/contrib/xcscope/")
(require 'xcscope)

;; Emacs-w3m
(require 'w3m-load)
;;; 允许w3m显示网页中的图片
;; (setq w3m-default-display-inline-images t)
;;; 允许w3m启用Cookie功能
(setq w3m-use-cookies t)

;; EMMS
(require 'emms-setup)
(emms-standard)
(emms-default-players)
;;; 将~/music/作为默认的多媒体文件搜索路径
(setq emms-source-file-default-directory "~/music/")

;; Graphviz
(load-file "~/myEmacs/graphviz-dot-mode.el")

;; Haskell
;; (load "~/building/haskell-mode-2.8.0/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (setq haskell-program-name "/usr/local/bin/ghci")

;; JDEE
;; (add-to-list 'load-path "~/building/jdee-2.4.0.1/lisp/")
;; (require 'jde)
;; (setq jde-jdk-registry
;;       '(("1.6.0" . "~/installer/jdk1.6.0_26/")))
;; (setq jde-jdk '("1.6.0"))

;; Maxima
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
;;; 启动imaxima模式时也启动maxima模式
(setq imaxima-use-maxima-mode-flag t)

;; MMM
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)

;; OCaml
(add-to-list 'load-path "~/building/ocaml-3.12.0/emacs/")
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
(if window-system (require 'caml-font))

;; ParEdit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))

;; python-mode
(add-to-list 'load-path "~/building/python-mode.el-6.0.3/")
(require 'python-mode)

;; rect-mark
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

;; Sawfish
(add-to-list 'load-path "~/building/sawfish-1.8.1/")
(autoload 'sawfish-mode "sawfish" "sawfish-mode" t)
(setq auto-mode-alist (cons '("\\.sawfishrc$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.jl$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.sawfish/rc$" . sawfish-mode) auto-mode-alist))

;; Scheme48
(add-to-list 'load-path "~/building/scheme48-1.8/emacs/")
(autoload 'run-scheme "cmuscheme48" "Run an inferior Scheme process." t)

;; sdcv
(require 'showtip)
(require 'sdcv)
;;; 绑定C-c d组合键为以提示的方式显示光标所处位置的单词的解释
(global-set-key "\C-cd" 'sdcv-search-pointer+)

;; SLIME
(add-to-list 'load-path "~/building/slime-2011-01-22/")
;;; 设定Common Lisp实现的可执行文件的路径
(setq slime-lisp-implementations
      '((sbcl ("/usr/bin/sbcl" "--core" "/home/liutos/sbcl.core-for-slime") :coding-system utf-8-unix)
	(clisp ("/usr/bin/clisp" "-K" "full") :coding-system utf-8-unix)
	(new-clisp ("/usr/local/bin/clisp") :coding-system utf-8-unix)
	(new-sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
	(ecl ("/usr/local/bin/ecl") :coding-system utf-8-unix)))
(require 'slime)
(slime-setup '(slime-fancy))
;;; 打开Lisp源文件时启动SLIME
(add-hook 'slime-mode-hook
	  (lambda ()
	    (unless (slime-connected-p)
	      (save-excursion (slime)))))
;;; 设置HyperSpec文档在本机上的路径
(setq common-lisp-hyperspec-root "/home/liutos/myEmacs/HyperSpec/")
;;; 在Emacs-w3m中打开HyperSpec文档
(setq browse-url-browser-function
      '(("/home/liutos/myEmacs/HyperSpec/" . w3m-browse-url)
	("." . browse-url-browser-function)))
;;; 绑定C-c e组合键为利用macroexpand-1函数展开当前宏表达式
(global-set-key "\C-ce" 'slime-macroexpand-1)

;; template
(require 'template)
(template-initialize)

;; yasnippet
(add-to-list 'load-path "~/building/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/building/yasnippet-0.6.1c/snippets/")

; Emacs缺省功能的配置
;; 定义交互函数gtd为打开~/org/coding.org文件
(defun gtd ()
  (interactive)
  (find-file "~/org/coding.org"))
;; 绑定C-c g组合键为调用gtd交互函数
(global-set-key "\C-cg" 'gtd)
;; 绑定C-c n组合键为跳转到下一个匹配的括号
(global-set-key "\C-cn" 'forward-list)
;; 绑定C-c p组合键为跳转到上一个匹配的括号
(global-set-key "\C-cp" 'backward-list)
;; 使用C-c w组合键为打开Emacs-w3m对当前缓冲区所对应的.html文件的内容进行预览
(defun my-browse-current-buffer ()
  "Using Emacs-w3m to browse the file associated with current buffer."
  (interactive)
  (w3m-find-file (buffer-file-name (window-buffer))))

(global-set-key "\C-cw" 'my-browse-current-buffer)
;; 绑定C-c x为交换当前窗口和左上角窗口的缓冲区
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
;; 绑定C-TAB组合键为在可视窗口之间切换光标
(global-set-key [(control tab)] 'other-window)
;; 绑定C-;组合键为调用yas/expand函数
(global-set-key "\C-c;" 'yas/expand)
;; 绑定M-g g组合键为调用函数my-goto-line进行行间跳转
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
;; 绑定End键为光标定位到缓冲区结束处
(global-set-key [(end)] 'end-of-buffer)
;; 绑定F11键为切换菜单栏的显示状态
(global-set-key [(f11)] 'menu-bar-mode)
;; 绑定Home键为光标定位到缓冲区开始处
(global-set-key [(home)] 'beginning-of-buffer)
;; 在同名缓冲区前添加各自的父目录名以区分
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;; 不生成备份文件
(setq make-backup-files nil)
;; 让Emacs和外部程序共用剪贴板
(setq x-select-enable-clipboard t)
;; 移除滚动栏
(scroll-bar-mode 0)
;; 遇到匹配的括号时高亮该括号而不进行跳转
(show-paren-mode 1)
;; 移除工具栏
(tool-bar-mode 0)
