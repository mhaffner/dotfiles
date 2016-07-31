(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode t)
(load-theme 'monokai t)	 
;;(load-theme 'suscolors t)
(global-linum-mode t)
(column-number-mode t)
;; (desktop-save-mode 1)
(setq-default evil-escape-key-sequence "jk")

;; extra evil keybindings
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(setq-default evil-escape-key-sequence "jk") ; declare evil escape key sequence; this is a minor mode
(setq-default evil-escape-delay 0.2) ; set delay for evil-escape
(evil-escape-mode 1) ; enable evil-escape by default

;; function to wrap words and sentences in org mode
(setq-default fill-column 80)
(add-hook 'org-mode-hook 'my-org-mode-hook)
(defun my-org-mode-hook ()
  (auto-fill-mode 1)) ; set word wrap at the set column limit

;; disable pointless gui stuff
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)

;; others
(setq-default tab-width 4)

;; packages

;; auto-generated by (load-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("97d039a52cfb190f4fd677f02f7d03cf7dbd353e08ac8a0cb991223b135ac4e6" "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
