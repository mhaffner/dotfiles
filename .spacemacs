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
     (shell :variables
            shell-default-shell 'eshell
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-full-span nil)
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
  (set-default 'truncate-lines t)
  (set-fill-column 70)
  (setq ess-ask-for-ess-directory nil)
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


;; Define custom keybindings
  (defun add-src-elements ()
    "Add #+BEGIN/END _SRC elements easier"
    (interactive)
    (insert "#+BEGIN_SRC\n#+END_SRC")
    (forward-line -1)
    (evil-append-line 1)
    (insert " "))

; define key in org-mode only
  (define-key org-mode-map (kbd "C-c s") 'add-src-elements)

;; Custom layouts
  (spacemacs|define-custom-layout "home-desktop"
    :binding "h d"
    :body
    (spacemacs/find-dotfile)
    (spacemacs/layout-triple-columns)
    (winum-select-window-2)
    (find-file "~/Sync/agenda/todo-list.org")
    (spacemacs/default-pop-shell)
    (winum-select-window-4)
    (forecast)
    (persp-add-buffer (buffer-name))
    (shrink-window-horizontally 20))

  (spacemacs|define-custom-layout "home-laptop"
    :binding "h l"
    :body
    (spacemacs/find-dotfile)
    (find-file "~/Sync/agenda/todo-list.org")
    (split-window-right-and-focus)
    (spacemacs/default-pop-shell)
    (winum-select-window-2)
    (forecast))

  (spacemacs|define-custom-layout "shp2nosql"
    :binding "s"
    :body
    (find-file "~/git-repos/shp2nosql/README")
    (split-window-right-and-focus)
    (find-file "~/git-repos/shp2nosql/bin/shp2es")
    (find-file "shp2mongo")
    (winum-select-window-1)
    (spacemacs/default-pop-shell))

  (spacemacs|define-custom-layout "non-english-tweets"
    :binding "n"
    :body
    (R)
    (find-file "~/git-repos/non-english-tweets/README.org")
    (split-window-right-and-focus)
    (find-file "~/git-repos/non-english-tweets/statistical-analysis/data-preparation.R")
    (find-file "regression-analysis.R")
    (winum-select-window-1)
    (spacemacs/default-pop-shell))

  (defun count-words-in-doc-section ()
    "This function counts the number of words in the section of a
  document. It may be useful when a manuscript's word count is
  limiting and you are working in an org-file with much more than
  just the document's text (e.g. you have notes, an outline, etc.).
  It looks for the tags 'begin_region_word_count' and
  'end_region_word_count' and prints the number of words two lines
  after the tag region_word_count_print."
    (interactive)
    (save-excursion
      (beginning-of-buffer)
      (let* ((section-beginning
              (search-forward "start_region_word_count"))
             (section-end
              (search-forward "end_region_word_count"))
             (word-count
              (count-region section-beginning section-end)))
        (print word-count)))))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
