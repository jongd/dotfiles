(require 'package)

; List the packages you want
(setq package-list '(cider
         auto-complete
         base16-theme
         cider
         clojure-mode
         ;; coffee-mode
         elscreen
         evil
         evil-leader
         evil-surround
         exec-path-from-shell
         flx-ido
         ido-vertical-mode
         gist
         git-gutter
         js2-mode
         linum-relative
         magit
         markdown-mode
         powerline
         projectile
         rainbow-delimiters
         slime
         smartparens
         yasnippet))

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
  "p" 'projectile-switch-project
  "c" 'comment-or-uncomment-region
  "b" 'switch-to-buffer
  "l" 'buffer-menu-other-window
  "w" 'save-buffer
  "k" 'kill-buffer
  "e" 'evil-buffer
  "f" 'ido-find-file
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
(setq-default indent-tabs-mode nil)
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
;;(setq projectile-enable-caching 0)

(require 'flx-ido)
;; (require 'ido-vertical-mode)
(ido-mode 1)
;; (ido-vertical-mode 0)
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
(load-theme 'base16-ocean t)
(setq-default line-spacing 4)
(set-default-font "Source Code Pro Light-13")

(require 'powerline)
(powerline-default-theme)

;; (setq tab-always-indent 'complete)
;; (add-to-list 'completion-styles 'initials t)

;; coffeescript
;; (custom-set-variables
;;  '(coffee-tab-width 2)
;;  '(coffee-args-compile '("-c" "--bare")))

;; (eval-after-load "coffee-mode"
;;   '(progn
;;      (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
;;      (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" default)))
 '(org-agenda-files (quote ("~/Dropbox/org/personal.org" "~/Dropbox/org/yld.org" "~/Dropbox/Internet&Things/Talks/ftf.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)

;; org-mode
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-todo-keywords
      '((sequence "TODO"
                  "IN-PROGRESS"
                  "BLOCKED"
                  "DONE")))

;; Stop dialog boxes breaking
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;; auto complete mode
;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; set the trigger key so that it can work together with yasnippet on tab key,
;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


;; javascripting
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)

(defconst clojure--prettify-symbols-alist
  '(("fn"  . ?λ)))
