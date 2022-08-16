;;; init.el  -*- lexical-binding: t; -*-
;; Straight as the package manager
(defvar bootstrap-version)
(setq straight-base-dir (getenv "XDG_DATA_HOME"))
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; Enable Garbage Collection again
(use-package gcmh
  :config
  (add-hook 'window-setup-hook #'gcmh-mode))

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
