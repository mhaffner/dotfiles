;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     csv
     auto-completion
     emacs-lisp
     spacemacs-layouts
     eyebrowse
     php
     git
     markdown
     org
     python
     latex
     ess
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     workgroups2
     forecast
     ssh
     helm-google
    )
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'random
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'Fundamental
   dotspacemacs-themes '(
                         spacemacs-dark
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 20
                               :weight normal
                               :width normal
                               :powerline-scale 1.00)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.1
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers 'relative
   dotspacemacs-smartparen-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq-default evil-escape-key-sequence "jk") ; set escape keybinding to "jk"
  (setq spacemacs-useless-buffers-regexp '("\\*helm\.+\\*"))
  (add-hook 'ess-mode-hook 'linum-mode)
  (with-eval-after-load 'org ; must be evaluated after load to prevent version conflicts
    (add-hook 'org-mode-hook 'auto-fill-mode)
    (add-hook 'org-mode-hook 'abbrev-mode)
    (add-hook 'org-mode-hook 'flyspell-mode)
    (add-hook 'ess-mode-hook 'linum-mode)
    (setq org-agenda-files '("~/MEGA/megasync/agenda"))
    (setq org-startup-indented t)
    )
  (with-eval-after-load 'flyspell
    (define-key flyspell-mode-map (kbd "C-SPC") 'flyspell-auto-correct-word))
  (setq forecast-latitude 36.11236
        forecast-longitude -97.07025
        forecast-api-key "e6a50bacd182e9bae30bae1e878d9355"
        forecast-units "us")
(spacemacs|define-custom-layout "@startup"
  :binding "+"
  :body
  (find-file "~/Sync/agenda/todo-list.org")
  (persp-add-buffer (current-buffer))
  (split-window-right-and-focus)
  (eshell)
  (persp-add-buffer (current-buffer))
  (split-window-below-and-focus)
  (forecast)
  (persp-add-buffer (current-buffer))
  )
;; Set startup layout
(find-file "~/Sync/agenda/todo-list.org")
(split-window-right-and-focus)
(eshell)
(split-window-below-and-focus)
(forecast)
)
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
