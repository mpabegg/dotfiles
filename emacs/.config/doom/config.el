(setq user-full-name "Matheus Abegg"
      user-mail-address "1006630+mpabegg@users.noreply.github.com")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 13))

(setq doom-theme 'base16-eighties)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(add-hook! 'focus-out-hook (save-some-buffers t))

(dolist (command '(evil-window-split
                   evil-window-vsplit))
  (defadvice! choose-buffer-on-split (&rest _)
    :after command (consult-buffer)))

;; (dolist (command '(evil-window-split
;;                    evil-window-vsplit))
;;   (defadvice! choose-buffer-on-split-with-quit (&rest _)
;;     "Run #'consult-buffer after splitting windows.

;; If the user quits the buffer selection, the new windows is closed."
;;     :after command
;;     (let ((inhibit-quit t))
;;       (unless (with-local-quit (consult-buffer) t)
;;         (+workspace/close-window-or-workspace)))))

(setq org-descriptive-links nil)

(setq doom-leader-alt-key "C-SPC")

(dolist (mode '(vterm term))
  (add-to-list '+evil-collection-disabled-list mode)
  (add-to-list 'evil-emacs-state-modes (intern (concat (symbol-name mode) "-mode"))))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(after! treemacs
  (treemacs-follow-mode 1)
  (treemacs-define-RET-action 'file-node-open #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace))

(map! :leader "w 0" #'treemacs-select-window)

(map! :leader
      "0" #'treemacs-select-window
      "1" #'winum-select-window-1
      "2" #'winum-select-window-2
      "3" #'winum-select-window-3
      "4" #'winum-select-window-4)
