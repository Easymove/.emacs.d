(require-package 'go-mode)

(require-package 'exec-path-from-shell)


(setq exec-path (cons "/usr/lib/golang/bin/linux_amd64" exec-path))
;; (add-to-list 'exec-path "/Users/tleyden/Development/gocode/bin")
(setenv "GOPATH" "/home/dasd/Development/gocode")

(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(provide 'init-golang)
