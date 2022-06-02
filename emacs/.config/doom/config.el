(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq user-full-name "Matheus Abegg"
      user-mail-address "1006630+mpabegg@users.noreply.github.com"

      doom-font (font-spec :family "SauceCodePro Nerd Font" :size 13 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 13)
      doom-theme 'doom-one
      display-line-numbers-type 'relative

      org-directory "~/.org/"
      org-descriptive-links nil
      doom-localleader-key ","
      doom-leader-alt-key "C-SPC")

(setq projectile-track-known-projects-automatically nil)

(setq rubocop-format-on-save t
      rubocop-autocorrect-on-save t)

(add-hook! 'focus-out-hook (save-some-buffers t))

(after! treemacs
  (treemacs-define-RET-action 'file-node-open #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace))

(map! :mode dired-mode
      :n "h" #'dired-up-directory
      :n "l" #'dired-find-file)

(defun spacemacs/window-split-double-columns ()
  "Set the layout to double columns."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list)))))
    (set-window-buffer (split-window-right)
                       (or (car previous-files) "*scratch*"))
    (balance-windows)))

(defun spacemacs/window-split-double-columns ()
  "Set the layout to double columns."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list)))))
    (set-window-buffer (split-window-right)
                       (or (car previous-files) "*scratch*"))
    (balance-windows)))

(defun spacemacs/window-split-double-rows ()
  "Set the layout to double rows."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list)))))
    (set-window-buffer (split-window)
                       (or (car previous-files) "*scratch*"))
    (balance-windows)))

(defun spacemacs/window-split-in-three ()
  "Set the layout to two columns, and two rows on the first column."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list))))
         (second (split-window-right))
         (third (split-window second nil 'below)))
    (set-window-buffer second (or (car previous-files) "*scratch*"))
    (set-window-buffer third (or (cadr previous-files) "*scratch*"))
    (balance-windows)))

(defun spacemacs/window-split-grid ()
  "Set the layout to a 2x2 grid."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list))))
         (second (split-window-below))
         (third (split-window-right))
         (fourth (split-window second nil 'right)))
    (set-window-buffer third (or (car previous-files) "*scratch*"))
    (set-window-buffer second (or (cadr previous-files) "*scratch*"))
    (set-window-buffer fourth (or (caddr previous-files) "*scratch*"))
    (balance-windows)))

;; Thanks to https://gist.github.com/mads-hartmann/3402786
(defun spacemacs/toggle-maximize-buffer ()
  "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(after! winum
  (map! :leader
        "0" #'treemacs-select-window
        "1" #'winum-select-window-1
        "2" #'winum-select-window-2
        "3" #'winum-select-window-3
        "4" #'winum-select-window-4
        "w m" #'spacemacs/toggle-maximize-buffer
        "w M" #'ace-swap-window
        "w 2" #'spacemacs/window-split-double-columns
        "w @" #'spacemacs/window-split-double-rows
        "w 3" #'spacemacs/window-split-in-three
        "w 4" #'spacemacs/window-split-grid))

(defun spacemacs/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window."
  (interactive)
  (cl-destructuring-bind (buf start pos)
        (or (cl-find (window-buffer window) (window-prev-buffers)
                        :key #'car :test-not #'eq)
                (list (other-buffer) nil nil))
    (if (not buf)
        (message "Last buffer not found.")
      (set-window-buffer-start-and-point window buf start pos))))

(map! :leader
      :desc "Last Buffer" "TAB" #'spacemacs/alternate-buffer
      :desc "Toggle vterm popup" "'" #'+vterm/toggle)

(map! :leader
      :desc "File Manager"
      "f m" #'dired-jump-other-window)

(after! lsp-ui
  (setq! lsp-enable-symbol-highlighting t
         lsp-eldoc-enable-hover t
         lsp-completion-show-detail t
         lsp-completion-show-kind t
         lsp-signature-auto-activate t
         lsp-ui-sideline-enable nil
         lsp-headerline-breadcrumb-enable t))


;; global-map C-@
;; global-map C-SPC
;; view-mode-map .
