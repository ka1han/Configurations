; Scheme48
;; Set my Scheme system
(setq scheme-program-name "/usr/local/bin/scheme48")
(add-to-list 'load-path "~/building/scheme48-1.8/emacs/")
(autoload 'run-scheme "cmuscheme48" "Run an inferior Scheme process." t)