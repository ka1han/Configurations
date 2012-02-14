; Emacs
;; Hide the tool bar
(tool-bar-mode 0)
;; Hide the scroll bar
(scroll-bar-mode 0)
;; Highlight the matching parenthesis
(show-paren-mode 1)
;; Give the key sequence C-tab the binding as switching among windows
(global-set-key [C-tab] 'other-window)
;; Give the key home the binding as moving point to the begining of the buffer
(global-set-key [home] 'beginning-of-buffer)
;; Give the key end the binding as moving point to the end of the buffer
(global-set-key [end] 'end-of-buffer)
;; Distinguish the buffers with same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;; Prevent from creating the backup file
(setq make-backup-files nil)
;; Share the clipborad with other X programs
(setq x-select-enable-clipboard t)

; Plug-ins
;; Register the directory contains the source files of plug-ins includes Paredit
(add-to-list 'load-path "~/myEmacs/")
;; Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))
;; Template
(require 'template)
(template-initialize)
;; Sawfish
(add-to-list 'load-path "~/building/sawfish-1.8.1/")
(autoload 'sawfish-mode "sawfish" "sawfish-mode" t)
(setq auto-mode-alist (cons '("\\.sawfishrc$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.jl$" . sawfish-mode) auto-mode-alist)
      auto-mode-alist (cons '("\\.sawfish/rc$" . sawfish-mode) auto-mode-alist))
;; Programming Languages
(add-to-list 'load-path "~/src/Configurations/emacs/prolang/")
;;; Common Lisp
(load "Lisp.el")
;;; Python
(load "Python.el")
;;; Scheme
(load "Scheme.el")
;;; LaTeX
(load "LaTeX.el")