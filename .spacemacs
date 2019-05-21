;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     lua
     haskell
     (auto-completion :variables
                      auto-completion-return-key-behavior 'nil
                      auto-completion-tab-key-behavior 'complete
                      disabled-for 'eshell)
     (ranger :variables
              ranger-show-preview t)
     pdf
     ;pdf-tools
     csv
     csharp
     docker
     emacs-lisp
     ess
     ruby
     html
     javascript
     yaml
     spacemacs-layouts
     git
     bibtex
     python
     latex
     markdown
     rust
     spell-checking
     sql
     syntax-checking
     version-control
     (org :variables
          org-enable-reveal-js-support t)
     (shell :variables
            shell-default-shell 'eshell
            shell-default-height 35
            shell-default-position 'bottom
            shell-default-full-span nil
            :packages (not company))
     )

   dotspacemacs-additional-packages
   '(
     bongo
     forecast
     ;mu4e-alert
     epresent
     ssh
     helm-google
     polymode
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
                         noctilux
                         gruvbox
                         badwolf
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; use different size font on laptop/desktop
   dotspacemacs-default-font (if (string-equal (system-name) "960-evo")
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
  )

(defun dotspacemacs/user-config ()

  (defun open-html-firefox ()
    "When working with Rmarkdown or .org files that have been
    rendered into .html, I frequently find myself entering
    commands like ':! firefox my-rmarkdown.html' to open the
    current .Rmd file (often newly rendered) in a browser. If the
    .html file is already open in a browser, you can simply
    refresh it, but I often use emacs as a navigation tool, then
    open files from the evil shell (correct name?).

    This function gets the current buffer name, strips the 'Rmd'
    suffix, appends 'html' to it, and opens the file in firefox."
    (interactive)
    ;; create the new string of the file to open
    (setq file-string (concat (file-name-sans-extension (buffer-file-name)) ".html"))
    ;; execute command
    (shell-command (concat "firefox " file-string)))

    ; assign this function to a keybinding in org mode
    (add-hook 'org-mode-hook
              (lambda ()
                (local-set-key (kbd "C-c f") 'open-html-firefox)))

  (defun rmd-render ()
    "Spawning an R process is a pain to simply render an RMarkdown
     file from within Emacs. Here I do it as a function. Must be in
     the buffer you want to render."
    (interactive)
    ;; build the R render command
    (setq rcmd (concat "rmarkdown::render('" buffer-file-name "')"))
    ;; pipe the r command to r from the terminal
    (setq command (concat "echo \"" rcmd "\" | R --vanilla"))
    ;; i have no idea why compile is used here but it works
    (compile command))

  ;; markdown mode keybindings
  (add-hook 'markdown-mode-hook
    (lambda ()
      (local-set-key (kbd "C-c f") 'open-html-firefox)
      (local-set-key (kbd "C-c s") 'add-src-elements-md)
      (local-set-key (kbd "C-c r") 'rmd-render)))


  ; used to kill the compiler buffer if everything goes ok
  (add-hook 'compilation-finish-functions (lambda (buf strg) (kill-buffer buf)))

  ; start text modes (which includes markdown) with autofill mode enabled
  (add-hook 'text-mode-hook 'turn-on-auto-fill)

  ; change mode of .Rmd files to markdown
  (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))

  ; disable linum-mode in pdf-tools; it's unusable otherwise
  (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

  ; modify default tramp method
  (setq tramp-default-method "ssh")

  ; change org bullets
  (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))

  ; use US English dictionary
  (setq ispell-local-dictionary "en_US")

  ; use transparency
  (spacemacs/toggle-transparency)

  ; disable smart-parens everywhere
  (remove-hook 'prog-mode-hook #'smartparens-mode)

  ; set a liberal scroll margin
  (setq scroll-margin 20)

  ; but not in shells, of course
  (with-eval-after-load 'ess
    (add-hook 'ess-mode-hook (lambda () (setq scroll-margin 1))))

  (with-eval-after-load 'eshell
    (add-hook 'eshell-mode-hook (lambda () (setq scroll-margin 1))))

  ; Define custom functions
  (defun add-src-elements ()
    "Add #+BEGIN/END _SRC elements easier"
    (interactive)
    (insert "#+BEGIN_SRC\n#+END_SRC")
    (forward-line -1)
    (evil-append-line 1)
    (insert " "))

  (defun add-src-elements-md ()
    "Make adding r source code blocks easier"
    (interactive)
    (insert "```{r echo = FALSE, eval = FALSE, message = FALSE, warning = FALSE}\n\n```")
    (forward-line -1))

  (defun zoom-frm-in-four ()
    "I always find myself zooming in and out on my laptop
    depending upon whether or not I'm using an external screen.
    From what I can tell, zoom-frm-out does not take arguments.
    This function zooms in four times."
    (interactive)
    (dotimes (number 4 "Zoomed in four times")
      (zoom-frm-in)))

  (defun zoom-frm-out-four ()
    "I always find myself zooming in and out on my laptop
    depending upon whether or not I'm using an external screen.
    From what I can tell, zoom-frm-in does not take arguments.
    This function zooms out four times."
    (interactive)
    (dotimes (number 4 "Zoomed out four times")
      (zoom-frm-out)))

  ;; some keybindings
  (setq-default evil-escape-key-sequence "jk") ; set escape keybinding to "jk"

  ; set some variables
  (setq
   spacemacs-useless-buffers-regexp '("\\*helm\.+\\*") ; make only helm buffers useless
   powerline-default-separator 'arrow-fade
   vc-follow-symlinks nil
   org-reveal-root "/home/matt/git-repos/reveal.js")

  ; some other variables
  (set-default 'truncate-lines t)
  (set-fill-column 70)
  (setq bibtex-completion-additional-search-fields '(tags))
  (setq ess-ask-for-ess-directory nil)
  (add-hook 'ess-mode-hook 'linum-mode)
  (add-to-list 'auto-mode-alist '("README" . org-mode))

  ; org settings
  (with-eval-after-load 'org ; must be evaluated after load to prevent version conflicts
    (add-hook 'org-mode-hook 'auto-fill-mode)
    (add-hook 'org-mode-hook 'abbrev-mode)
    (add-hook 'org-mode-hook 'flyspell-mode)
    (add-hook 'org-mode-hook
              (lambda ()
                (local-set-key (kbd "C-c s") 'add-src-elements)))
    ;(add-to-list 'org-export-backends 'org) ; doesn't work
    (setq org-ref-default-bibliography '("~/Sync/references/references.bib")
          org-ref-pdf-directory "~/Sync/references/pdfs"
          org-ref-bibliography-notes "~/Sync/references/notes.org")
                                        ; enables bibliography at end of document
    (setq org-latex-pdf-process '("latexmk -xelatex -quiet -shell-escape -f %f"))
    ;; this below may be needed instead
;    (setq org-latex-pdf-process
;          '("pdflatex -interaction nonstopmode -output-directory %o %f"
;            "bibtex %b"
;            "pdflatex -interaction nonstopmode -output-directory %o %f"
    (add-hook 'org-mode-hook (lambda () (setq fill-column 70)))
    (setq org-agenda-files '("~/MEGA/megasync/agenda"))
    (setq org-startup-indented t)
    (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n,\"")
    (setcar (nthcdr 4 org-emphasis-regexp-components) 100)
    (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
    )

  (with-eval-after-load 'helm
    (define-key helm-map (kbd "C-d") 'helm-next-page)
    (define-key helm-map (kbd "C-u") 'helm-previous-page))

  (with-eval-after-load 'flyspell
    (define-key flyspell-mode-map (kbd "C-SPC") 'flyspell-auto-correct-word))

  ; this needs to be separate from other setq's?
  (setq
   calendar-latitude 44.7967
   calendar-location-name "Eau Claire, WI"
   calendar-longitude -91.5000
   forecast-api-key "e6a50bacd182e9bae30bae1e878d9355"
   forecast-units "si")

;; define some custom layouts
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
        (print word-count))))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
