(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "6124d0d4205ae5ab279b35ac6bc6a180fbb5ca594616e1e9a22097024c0a8a99" default)))
 '(package-selected-packages
   (quote
    (paredit lush-theme puppet-mode spacemacs-theme httprepl dumb-jump dockerfile-mode docker com-css-sort transpose-frame hackernews haml-mode soft-charcoal-theme cyberpunk-theme groovy-mode counsel-projectile projectile fzf counsel swiper ivy yaml-mode highlight-symbol treemacs cider markdown-mode markdown-mode+ markdown-preview-mode exec-path-from-shell json-mode web-mode coffee-mode feature-mode jade-mode pug-mode company-shell tide reykjavik-theme rjsx-mode js2-refactor xref-js2 js2-mode emmet-mode flycheck flycheck-inline rainbow-delimiters company clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; init -- Hugo's init file
;;; Commentary:
;;; Code:

;; Disable welcome screen
(setq inhibit-startup-screen t)

;; Ask for emacs to confirm exit
(setq confirm-kill-emacs 'y-or-n-p)

;; disable ctrl-x ctrl-z that send emacs to the background
(global-unset-key (kbd "C-z"))

;; enable line number for all!
(global-linum-mode t)

;; yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Ctrl-h map to delete-backward
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "RET") 'newline-and-indent)

;; Mapping control+cursor to change window pane size
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;; Disable ctrl-x, ctrl-b
(global-unset-key [(control x)(control b)])


;; Disable ctrl-x ctrl-z that minimizes emacs
(global-unset-key [(control x)(control z)])

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

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backups" t)))

;; disable the lockfiles
(setq create-lockfile nil)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; Setting font
(when (member "Victor Mono" (font-family-list))
  (set-frame-font "Victor Mono 16" nil t))

;; (set-frame-font "Inconsolata 16" nil t)
;; (when (member "Monoid" (font-family-list))
;;   (set-frame-font "Monoid 16" nil t))

;; change tabs to 2 spaces width
(setq-default indent-tabs-mode nil) ;; use spaces, no tab chars
(setq tab-width 2)
(setq default-tab-width 2)
(setq-default js-indent-level 2)
(setq-default js2-basic-offset 2)

;; Setting my theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'soft-charcoal)
;;(load-theme 'cyberpunk t)
;;(load-theme 'weyland-yutani t)
;;(load-theme 'misterioso t)
;;(load-theme 'tron t)

;; Set font-size
(set-face-attribute 'default nil :height 160)
;; Disable sound bell
(setq visible-bell t)

;; Other functions
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer 
          (delq (current-buffer) 
                (remove-if-not 'buffer-file-name (buffer-list)))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; packages
(defvar user-packages '
  (clojure-mode
   coffee-mode
   company
   counsel
   cyberpunk-theme
   dumb-jump
   highlight-symbol
   jade-mode
   flycheck
   flycheck-inline
   ivy
   js2-mode
   js2-refactor
   markdown-mode
   pug-mode
   rainbow-delimiters
   spacemacs-theme
   soft-charcoal-theme
   swiper
   treemacs
   xref-js2
   yaml-mode))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p user-packages)
  (when (not (package-installed-p p))
    (package-refresh-contents)
    (package-install p)))

;; Configuring individual packages
(show-paren-mode 1)

;; active wind-move!!
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; I want cyberpunk theme and I wanted now
;;(load-theme 'cyberpunk t)
;;(load-theme 'soft-charcoal)
(load-theme 'spacemacs-dark t)

;; feature-mode -- set steps path
;; (setq feature-step-search-path "test/features/step_definitions/**/*.rb")

;; enable dumb-jump
(dumb-jump-mode)

;; set treemacs command to <f12>
(require 'treemacs)
(global-set-key [(f12)] 'treemacs)

(require 'company)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook      #'company-mode)
;; This enables case sensitive completions => https://goo.gl/MBqNu6
(setq company-dabbrev-downcase nil)

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
 
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; Ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; fzf configuration
(require 'fzf)
(global-set-key (kbd "<f8>") 'fzf-git)
(setq fzf/directory-start "~/src/biscoff")

;; Adding to the exec-path $PATH
;;(add-to-list 'exec-path "/usr/local/bin")
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(put 'suspend-frame 'disabled nil)
