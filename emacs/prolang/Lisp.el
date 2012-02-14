; SLIME - the Superior Lisp Interaction Mode for Emacs
(add-to-list 'load-path "~/building/slime-2011-01-22/")
;; The list of my Lisp system
(setq slime-lisp-implementations
      '((sbcl ("/usr/bin/sbcl" "--core" "/home/liutos/sbcl.core-for-slime")
	      :coding-system utf-8-unix)))
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
;; Starts SLIME when opening a Lisp source file if unconnected yet
(add-hook 'slime-mode-hook
	  (lambda ()
	    (unless (slime-connected-p)
	      (save-excursion (slime)))))
;; Set the path of the HyperSpec document
(setq common-lisp-hyperspec-root "/home/liutos/myEmacs/HyperSpec/")