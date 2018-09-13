;;; init -- Hugo's init file
;;; Commentary:
;;; Code:

;; Disable welcome screen
(setq inhibit-startup-screen t)
(setq
  backup-by-copying t      ; don't clobber symlinks
  backup-directory-alist
    '(("." . "~/.emacs.d/backups/"))    ; don't litter my fs tree
    delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)       ; use versioned backups

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; Ctrl-h map to delete-backward
(keyboard-translate ?\C-h ?\C-?);
;; Setting my theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'weyland-yutani t)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (xref-js2 js2-mode emmet-mode flycheck flycheck-inline rainbow-delimiters company clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
