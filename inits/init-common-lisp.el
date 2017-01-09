(require-package 'slime)
(require-package 'ac-slime)

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'slime-repl-mode))

;; set lisp interpreter

(setq inferior-lisp-program "/usr/bin/sbcl --load /home/easymove/libs-n-bins/quicklisp.lisp")

(setq *FASL-DIRECTORY* "~/.fasls.d/")

(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy))
(slime-setup slime-contribs)

(modify-syntax-entry ?- "w" lisp-mode-syntax-table)

(provide 'init-common-lisp)

;; (setf asdf:*central-registry*
;;        (list* '*default-pathname-defaults*
;;               #p"/home/me/cl/systems/"
;;               #p"/usr/share/common-lisp/systems/"
;;               asdf:*central-registry*))
