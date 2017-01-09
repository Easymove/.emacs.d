(require-package 'slime)
(require-package 'ac-slime)

(setq inferior-lisp-program (expand-file-name "~/.emacs.d/ee.sh"))

(defvar *** nil "*** contains the previous value of **")
(defvar **  nil "** contains the previous value of *")
(defvar *   nil "* contains the most recent form eval'd at the top-level repl")
(defvar +++ nil "+++ contains the previous value of ++")
(defvar ++  nil "++ contains the previous value of +")
(defvar +   nil "+ contains the most recent form read at the top-level repl")
(defvar -   nil "- contains the current form read at the top-level repl")
(defun quit () (setq quit-flag t))

(princ (format "%s\n" (emacs-version)))
(defun read-multiline (prompt left)
  (let ((s (read-from-minibuffer prompt)))
    (setq s (concat left s " "))
    (condition-case nil
        (car (read-from-string s))
      (error (read-multiline "    " s)))))

(while (not quit-flag)
  (setq - (read-multiline "? " ""))
  (condition-case current-error
      (let ((r (eval -)))
        (print r)
        (setq *** **   +++ ++
  	      **  *    ++  +
  	      *   r    +   -))
    (error (princ (format "error: %s\n" current-error)))))

(provide 'init-elisp)
