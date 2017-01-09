(require-package 'auto-complete)
(global-auto-complete-mode)
;; (ac-linum-workaround)

(setq ac-auto-start t)

(global-set-key (kbd "C-<tab>") 'auto-complete)
(global-set-key (kbd "M-n") 'ac-expand)
(global-set-key (kbd "M-p") 'ac-previous)

(require 'haskell-ac)

(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))

(add-hook 'ielm-mode-hook 'ielm-auto-complete)

(provide 'init-auto-complete)
