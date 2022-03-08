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
    "Run #'consult-buffer after splitting windows.

If the user quits the buffer selection, the new windows is closed."
    :after command
    (let ((inhibit-quit t))
      (unless (with-local-quit (consult-buffer) t)
        (+workspace/close-window-or-workspace)))))
