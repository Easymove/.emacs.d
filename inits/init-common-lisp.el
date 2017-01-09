(require-package 'slime)
(require-package 'ac-slime)

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'slime-repl-mode))

(defun shell-command-to-list (command-str &optional arg)
  (let ((split-char (or arg " ")))
    (remove-if
     (lambda (s) (= (length s) 0))
     (reduce
      #'append
      (mapcar (lambda (s) (split-string s split-char))
              (split-string (shell-command-to-string command-str) "\n"))))))

(defun find-sbcl ()
  (interactive)
  (block tmp
    (dolist (str (shell-command-to-list "whereis sbcl"))
      (when (string-match-p (regexp-quote "bin") str)
        (return-from tmp str)))))

;;; TODO: optimize this
(defun find-ql ()
  (interactive)
  (block tmp
    (dolist (str (shell-command-to-list "find / -name quicklisp.lisp"))
      (when (string-match-p (regexp-quote "quicklisp.lisp") str)
        (return-from tmp str)))))

;;; redirecting fasls
(make-directory "/tmp/slime-fasls/" t)
(setq slime-compile-file-options '(:fasl-directory "/tmp/slime-fasls/"))

;; set lisp interpreter
(setq inferior-lisp-program (format "%s --load /home/easymove/libs-n-bins/quicklisp.lisp" (find-sbcl)))

(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy))
(slime-setup slime-contribs)

(modify-syntax-entry ?- "w" lisp-mode-syntax-table)

(provide 'init-common-lisp)
