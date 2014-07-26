(require 'package)

; List the packages you want
(setq package-list '(cider
         base16-theme
         cider
         clojure-mode
         elscreen
         evil
         evil-leader
         evil-surround
         exec-path-from-shell
         flx-ido
         ido-vertical-mode
         gist
         git-gutter
         linum-relative
         magit
         markdown-mode
         powerline
         projectile
         rainbow-delimiters
         slime
         smartparens))

; Add Melpa as the default Emacs Package repository
; only contains a very limited number of packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

; Activate all the packages (in particular autoloads)
(package-initialize)

; Update your local package index
(unless package-archive-contents
  (package-refresh-contents))

; Install all missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Slime
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))


;; Elscreen
(elscreen-start)
(elscreen-set-prefix-key "\C-a")

;; Evil mode
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "r" 'recentf-ido-find-file
  "," 'projectile-find-file
  "c" 'comment-or-uncomment-region
  "b" 'switch-to-buffer
  "l" 'buffer-menu-other-window
  "w" 'save-buffer
  "k" 'kill-buffer
  "e" 'evil-buffer
  "q" 'eval-buffer)

(require 'evil)
(evil-mode t)

(define-key evil-motion-state-map ";" 'evil-ex)
(define-key evil-window-map "x" 'evil-window-delete)
(define-key evil-window-map "c" 'evil-window-split)
(define-key evil-window-map (kbd "<up>") 'evil-window-up)
(define-key evil-window-map (kbd "<right>") 'evil-window-right)
(define-key evil-window-map (kbd "<down>") 'evil-window-down)
(define-key evil-window-map (kbd "<left>") 'evil-window-left)

(define-key evil-normal-state-map (kbd "C-a <right>") 'elscreen-next)
(define-key evil-normal-state-map (kbd "C-a <left>") 'elscreen-previous)
(define-key evil-normal-state-map (kbd "C-a c") 'elscreen-create)
(define-key evil-normal-state-map (kbd "C-a x") 'elscreen-kill)

(setq evil-auto-indent t)

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'linum-relative)


;; Always ALWAYS use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")

;; Automatically save buffers before compiling
(setq compilation-ask-about-save nil)

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

; General UI stuff
(global-linum-mode t)
(global-hl-line-mode t)
(setq default-tab-width 2)
(setq inhibit-startup-message t)
(setq visible-bell 'top-bottom)
(setq x-underlineino-at-descent-line t)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

(require 'exec-path-from-shell)
(setq exec-path-from-shell-arguments (delete "-i" exec-path-from-shell-arguments))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching 0)

(require 'flx-ido)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'recentf)
(recentf-mode 1)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(require 'rainbow-delimiters nil)
(rainbow-delimiters-mode 1)

(require 'icomplete)

(smartparens-global-mode t)

(require 'git-gutter)
(global-git-gutter-mode t)

;; Theme
(load-theme 'base16-eighties t)
(setq-default line-spacing 2)
(set-default-font "Akkurat Mono-12")

(require 'powerline)
(powerline-default-theme)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; only use spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
