;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     csv
     emacs-lisp
     ess
     ruby
     html
     javascript
     yaml
     spacemacs-layouts
     git
     python
     latex
     markdown
     spell-checking
     syntax-checking
     version-control
     (mu4e :variables
           mu4e-account-alist t)
     (org :variables
          org-enable-reveal-js-support t)
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'complete)
     (shell :variables
            shell-default-shell 'eshell
            shell-default-full-span nil
            shell-default-height 30
            shell-default-position 'bottom)
     )

   dotspacemacs-additional-packages
   '(
     forecast
     mu4e-alert
     ssh
     ;ox-reveal
     helm-google
     org-publish
     ov
     smtpmail ;; necessary?
    )
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
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
                         monokai
                         spacemacs-dark
                         gruvbox
                         badwolf
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; use different size font on laptop/desktop
   dotspacemacs-default-font (if (string-equal (system-name) "panopticon") 
                                 '("Source Code Pro"
                                   :size 16
                                   :weight normal
                                   :width normal
                                   :powerline-scale 1.00)
                                 '("Source Code Pro"
                                   :size 16
                                   :weight normal
                                   :width normal
                                   :powerline-scale 1.00))
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
   dotspacemacs-fullscreen-at-startup t
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

  )

(defun dotspacemacs/user-config ()
  (setq-default evil-escape-key-sequence "jk") ; set escape keybinding to "jk"
  (setq
   spacemacs-useless-buffers-regexp '("\\*helm\.+\\*") ; make only helm buffers useless
   powerline-default-separator 'arrow
   vc-follow-symlinks nil
   org-reveal-root "")
  (display-time)
  (set-fill-column 70)
  (add-hook 'ess-mode-hook 'linum-mode)
  (if (string-equal system-name "manjaro")
      (fancy-battery-mode))
  (add-to-list 'auto-mode-alist '("README" . org-mode))
  (with-eval-after-load 'org ; must be evaluated after load to prevent version conflicts
    (add-hook 'org-mode-hook 'auto-fill-mode)
    (add-hook 'org-mode-hook 'abbrev-mode)
    (add-hook 'org-mode-hook 'flyspell-mode)
    (add-hook 'ess-mode-hook 'linum-mode)
    ;(add-to-list 'org-export-backends 'org) ; doesn't work
    (add-hook 'org-mode-hook (lambda () (setq fill-column 70)))
    (setq org-agenda-files '("~/MEGA/megasync/agenda"))
    (setq org-startup-indented t)
    (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n,\"")
    (setcar (nthcdr 4 org-emphasis-regexp-components) 100)
    (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
    )
  (with-eval-after-load 'flyspell
    (define-key flyspell-mode-map (kbd "C-SPC") 'flyspell-auto-correct-word))

;; these need to be separate from other setq's?
  (setq
   calendar-latitude 36.11236
   calendar-location-name "Stillwater, Oklahoma"
   calendar-longitude -97.07025
   forecast-api-key "e6a50bacd182e9bae30bae1e878d9355"
   forecast-units "si")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mu4e
  (setq mu4e-account-alist
        '(("gmail"
           (mu4e-sent-messages-behavior delete)
           (mu4e-sent-folder "/[Gmail].Sent Mail")
           (mu4e-drafts-folder "/[Gmail].Drafts")
           (mu4e-trash-folder "/[Gmail].Trash")
           (user-mail-address "haffner.matthew.m@gmail.com")
           (user-full-name "Matthew Haffner"))
          ("osu"
           (mu4e-sent-messages-behavior delete)
           (mu4e-sent-folder "/[Gmail].Sent Mail")
           (mu4e-drafts-folder "/[Gmail].Drafts")
           (mu4e-trash-folder "/[Gmail].Trash")
           (user-mail-address "matt.haffner@okstate.edu")
           (user-full-name "Matthew Haffner"))))

  (mu4e/mail-account-reset) ; activates account information

  (setq mu4e-maildir "~/Maildir"
        mu4e-get-mail-command "mbsync -a"
        ; mu4e-update-interval 30
        mu4e-compose-signature-auto-include t
        mu4e-view-show-images t
        mu4e-view-show-addresses t
        mu4e-get-mail-command "offlineimap"
        mu4e-compose-signature
        (concat "Matthew Haffner\n"
                "PhD Student/Graduate Research Assistant\n"
                "Department of Geography\n"
                "Oklahoma State University"))

  ;; For sending mail
  ;(require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        starttls-use-gnutls t
        smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
        smtpmail-auth-credentials
        '(("smtp.gmail.com" 587 "haffner.matthew.m@gmail.com" nil))
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Different settings for various machines
;;(if (string-equal (system-name) "panopticon")
;;    (progn
;;      ;; Set startup layout
;;      (spacemacs/layout-triple-columns)
;;      (winum-select-window-1)
;;      (spacemacs/find-dotfile)
;;      (winum-select-window-2)
;;      (find-file "~/Sync/agenda/todo-list.org")
;;      (split-window-below-and-focus)
;;      (eshell)
;;      (winum-select-window-4)
;;      (forecast)
;;      (shrink-window-horizontally 15)))

;; For jekyll
;;(setq org-publish-project-alist
;;      '(("org-blog"
;;         ;; Path to your org files.
;;         :base-directory "~/git-repos/blog/org/"
;;         :base-extension "org"
;;
;;         ;; Path to your Jekyll project.
;;         :publishing-directory "~/git-repos/blog/"
;;         :recursive t
;;         :publishing-function org-html-publish-to-html
;;         :headline-levels 4
;;         :html-extension "html"
;;         :body-only t ;; Only export section between <body> </body>
;;         :table-of-contents nil)
;;
;;        ("org-static-blog"
;;         :base-directory "~/git-repos/blog/org"
;;         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;;         :publishing-directory "~/git-repos/blog/"
;;         :recursive t
;;         :publishing-function org-publish-attachment
;;         :table-of-contents nil)
;;
;;        ("blog" :components ("org-blog" "org-static-blog"))))

(setq org-publish-project-alist
      '(("org-blog"
         ;; Path to your org files.
         :base-directory "~/git-repos/mhaffner.github.io/org/"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/git-repos/mhaffner.github.io/jekyll/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t ;; Only export section between <body> </body>
         :table-of-contents nil)

        ("org-static-blog"
         :base-directory "~/git-repos/mhaffner.github.io/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "~/git-repos/mhaffner.github.io/"
         :recursive t
         :publishing-function org-publish-attachment
         :table-of-contents nil)

        ("blog" :components ("org-blog" "org-static-blog"))))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby xterm-color shell-pop multi-term git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck eshell-z eshell-prompt-extras esh-help diff-hl auto-dictionary powerline spinner org-plus-contrib ht alert log4e gntp markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode hydra parent-mode window-purpose imenu-list projectile pkg-info epl google request haml-mode autothemer gitignore-mode flx magit magit-popup git-commit with-editor smartparens iedit anzu evil goto-chg undo-tree highlight ctable ess julia-mode diminish web-completion-data dash-functional tern company bind-map bind-key yasnippet packed auctex anaconda-mode pythonic f dash s helm avy helm-core async auto-complete popup yaml-mode zenburn-theme yapfify ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit ssh spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox ox-reveal ov orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file neotree mu4e-maildirs-extension mu4e-alert move-text monokai-theme mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc info+ indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-google helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag gruvbox-theme google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy forecast flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view emmet-mode elisp-slime-nav dumb-jump define-word cython-mode csv-mode company-web company-tern company-statistics company-auctex company-anaconda column-enforce-mode coffee-mode clean-aindent-mode badwolf-theme auto-yasnippet auto-highlight-symbol auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
