;;; init -- Hugo's init file
;;; Commentary:
;;; Code:

;; Disable welcome screen
(setq inhibit-startup-screen t)

;; enable line number for all!
(global-linum-mode t)

;; yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; backup/auto-save files
(setq
  backup-by-copying t      ; don't clobber symlinks
  backup-directory-alist
  '(("." . "~/.emacs.d/backups/")
      (,tramp-file-name-regexp nil))    ; don't litter my fs tree
    delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)       ; use versioned backups

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; change tabs to 2 spaces width
(setq tab-width 2)
(setq default-tab-width 2)
(setq-default js-indent-level 2)
(setq-default js2-basic-offset 2)

;; Ctrl-h map to delete-backward
(keyboard-translate ?\C-h ?\C-?);
;; Setting my theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'weyland-yutani t)
(load-theme 'misterioso t)

;; Set font-size
(set-face-attribute 'default nil :height 160)
;; Disable sound bell
(setq visible-bell t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; packages
(defvar user-packages '
  (clojure-mode
   company
   rainbow-delimiters
   flycheck
   flycheck-inline
   js2-mode
   xref-js2))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p user-packages)
  (when (not (package-installed-p p))
    (package-refresh-contents)
    (package-install p)))

;; configuring individual packages
(show-paren-mode 1)

;; active wind-move!!
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(require 'company)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook      #'company-mode)

(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'cider) ;; enter cider mode when entering clojure-mode
(add-hook 'cider-mode-hook '(lambda () (local-set-key (kdb "RET") 'newline-and-indent))) ;; In cider-mode return does newline-and-indent

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(require 'js2-refactor)
(require 'xref-js2)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)
(define-key js-mode-map (kbd "M-.") nil) ;; js-mode binds "M-." which conflicts with xref, so unbinding
(add-hook 'js2-mode-hook (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (exec-path-from-shell json-mode web-mode coffee-mode feature-mode treemacs jade-mode pug-mode company-shell tide reykjavik-theme rjsx-mode js2-refactor xref-js2 js2-mode emmet-mode flycheck flycheck-inline rainbow-delimiters company clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
