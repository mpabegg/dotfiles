(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s."
                     (emac-init-time))))

(setq initial-major-mode 'fundamental-mode)

(use-package better-defaults
  :config
  (setq visible-bell nil) ;; The default
  (setq ring-bell-function 'ignore))

(use-package beacon
  :config (beacon-mode 1))

(set-face-attribute 'default nil :font "SauceCodePro Nerd Font" :height 130)

(setq auto-window-vscroll nil
      fast-but-imprecise-scrolling t
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t)

(use-package base16-theme
  :config
  (load-theme 'base16-eighties t))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :hook (doom-modeline-mode . size-indication-mode) ; filesize in modeline
  :hook (doom-modeline-mode . column-number-mode)   ; cursor column in modeline
  :init
  (unless after-init-time
    ;; prevent flash of unstyled modeline at startup
    (setq-default mode-line-format nil))
  ;; We display project info in the modeline ourselves
  (setq projectile-dynamic-mode-line nil)
  ;; Set these early so they don't trigger variable watchers
  (setq doom-modeline-bar-width 3
        doom-modeline-github nil
        doom-modeline-mu4e nil
        doom-modeline-persp-name nil
        doom-modeline-minor-modes nil
        doom-modeline-major-mode-icon nil
        doom-modeline-buffer-file-name-style 'relative-from-project
        doom-modeline-icon t
        ;; Only show file encoding if it's non-UTF-8 and different line endings
        ;; than the current OSes preference
        doom-modeline-buffer-encoding 'nondefault
        doom-modeline-default-eol-type 2)
        (doom-modeline-mode 1))

(setq frame-resize-pixelwise t
      window-resize-pixelwise t)

(use-package evil-anzu
  :after evil
  :config
  (global-anzu-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package which-key
  :config (which-key-mode 1))

(use-package org-bullets
  :config (add-hook 'org-mode-hook #'org-bullets-mode))
