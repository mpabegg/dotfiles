(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq user-full-name "Matheus Abegg"
      user-mail-address "1006630+mpabegg@users.noreply.github.com"

      doom-font (font-spec :family "SauceCodePro Nerd Font" :size 13 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 13)
      doom-theme 'base16-eighties
      display-line-numbers-type 'relative

      org-directory "~/.org/"
      org-descriptive-links nil
      doom-localleader-key ","
      doom-leader-alt-key "C-SPC")

(add-hook! 'focus-out-hook (save-some-buffers t))
(remove-hook 'org-load-hook #'+org-init-keybinds-h)

(after! treemacs
  (treemacs-define-RET-action 'file-node-open #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace))

(after! winum
  (map! :leader
        "0" #'treemacs-select-window
        "1" #'winum-select-window-1
        "2" #'winum-select-window-2
        "3" #'winum-select-window-3
        "4" #'winum-select-window-4))

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

(defun spacemacs/window-split-in-three ()
  "Set the layout to two columns, and two rows on the first column."
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list))))
         (second (split-window-right))
         (third (split-window-below second)))
    (set-window-buffer second (or (car previous-files) "*scratch*"))
    (set-window-buffer third (or (cadr previous-files) "*scratch*"))
    (balance-windows)))

(defun spacemacs/window-split-grid ()
  "Set the layout to a 2x2 grid."
  (interactive)
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
  (if (= 1 (length (remove-if #'treemacs-is-treemacs-window? (window-list))))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(after! winum
  (map! :leader
        "w m" #'spacemacs/toggle-maximize-buffer
        "w 2" #'spacemacs/window-split-double-columns
        "w 3" #'spacemacs/window-split-in-three
        "w 4" #'spacemacs/window-split-grid))

(defun spacemacs/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window.

If `spacemacs-layouts-restrict-spc-tab' is `t' then this only switches between
the current layouts buffers."
  (interactive)
  (cl-destructuring-bind (buf start pos)
        (or (cl-find (window-buffer window) (window-prev-buffers)
                     :key #'car :test-not #'eq)
            (list (other-buffer) nil nil))
    (if (not buf)
        (message "Last buffer not found.")
      (set-window-buffer-start-and-point window buf start pos))))

(map! :leader
      "TAB" #'spacemacs/alternate-buffer)
