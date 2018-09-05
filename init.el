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

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; list the packages you want
(setq package-list '(clojure-mode company rainbow-delimiters))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'clojure-mode)
;; Enter cider mode when entering clojure-mode
(add-hook 'clojure-mode-hook 'cider-mode)
;; Replace return key with newline-and-indent when in cider-mode.
(add-hook 'cider-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; Turn on auto-completion with company-mode
(require 'company)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; Show parenthesis mode
(show-paren-mode 1)

(require 'rainbow-delimiters)
;; Rainbow delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Configure heml-ag
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   (quote
    ("4561c67b0764aa6343d710bb0a6f3a96319252b2169d371802cc94adfea5cfc9" default)))
 '(helm-ag-base-command "/usr/local/bin/ag --nocolor --nogroup")
 '(package-selected-packages
   (quote
    (markdown-mode tagedit smex sesman rainbow-delimiters projectile paredit magit ido-ubiquitous highlight-symbol helm-ag exec-path-from-shell company clojure-mode-extra-font-locking cider))))
(global-set-key (kbd "M-s") 'helm-do-ag)

;; Do NOT CHANGE!
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
