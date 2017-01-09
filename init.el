;;; requironments
(let ((default-directory user-emacs-directory))
  (normal-top-level-add-subdirs-to-load-path))

(require 'init-packages)
(require 'init-auto-complete)
(require 'init-clojure)
(require 'init-common-lisp)
;; (require 'init-elisp)
(require 'init-paredit)
(require 'init-c)
;; (require 'init-org)
(require 'init-ido)
(require 'init-haskell)
;; (require 'init-golang)
;; (require 'init-webmode)
;; (require-package 'yasnippet)
;; (require-package 'clojure-snippets)
;; (require-package 'expand-region)
(require-package 'highlight-symbol)
(package-install-if-not-present 'magit)
;; (package-install-if-not-present 'magit-svn)


;;; basic emacs settings
(modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq scroll-preserve-screen-position t)
(setq undo-limit 2000)

(setq highlight-symbol-idle-delay 0.2)
(setq show-paren-style 'parenthesis)

(global-visual-line-mode t)

(setq mouse-wheel-scroll-amount '(3))
(setq mouse-wheel-progressive-speed nil)


;;; backup files options
(setq backup-directory-alist `(("." . "~/.saves.d")))

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setq custom-file "~/.emacs.d/custom.el")


;;; general keybindings
(global-set-key (kbd "C-c e o") 'find-dot-emacs)
(global-set-key (kbd "C-c e s") 'source-dot-emacs)

(global-set-key (kbd "C-x C-p") nil)
(global-set-key (kbd "C-c C-l") 'eval-buffer)

(global-set-key [(control f12)] 'highlight-symbol)
(global-set-key [f12] 'highlight-symbol-next)
(global-set-key [(shift f12)] 'highlight-symbol-prev)
(global-set-key [(meta f12)] 'highlight-symbol-query-replace)

;; (global-set-key (kbd "C-=") 'er/expand-region)


;;; hooks
;; (add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)
;; (add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq-local show-trailing-whitespace t)))
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
;; (add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)
(add-hook 'prog-mode-hook 'line-number-mode)
(add-hook 'prog-mode-hook 'column-number-mode)


;;; thems and customization
(setq custom-theme-directory "~/.emacs.d/themes/")
(package-install-if-not-present 'gotham-theme)
(package-install-if-not-present 'solarized-theme)
(package-install-if-not-present 'zenburn-theme)
(setq theme-to-load 'gruvbox)
(set-face-attribute 'default nil :height 100)
(load-theme theme-to-load t)
(load custom-file 'noerror)


;;; auxilaru functions
(defun find-dot-emacs ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (find-file "~/.emacs.d/init.el"))

(defun source-dot-emacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))


;;; g4-mode setup
;; (load "~/.emacs.d/g4-mode/g4-mode.el")
;; (require 'g4-mode)


(provide 'init)
