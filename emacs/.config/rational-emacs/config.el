;;; example-config.el -- Example Rational Emacs user customization file -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Rational Emacs supports user customization through a `config.el' file
;; similar to this one.  You can copy this file as `config.el' to your
;; Rational Emacs configuration directory as an example.
;;
;; In your configuration you can set any Emacs configuration variable, face
;; attributes, themes, etc as you normally would.
;;
;; See the README.org file in this repository for additional information.

;;; Code:
;; At the moment, Rational Emacs offers the following modules.
;; Comment out everything you don't want to use.
;; At the very least, you should decide whether or not you want to use
;; evil-mode, as it will greatly change how you interact with Emacs.
;; So, if you prefer Vim-style keybindings over vanilla Emacs keybindings
;; remove the comment in the line about `rational-evil' below.
(require 'rational-defaults)    ; Sensible default settings for Emacs
(require 'rational-use-package) ; Configuration for `use-package`
(require 'rational-updates)     ; Tools to upgrade Rational Emacs
(require 'rational-completion)  ; selection framework based on `vertico`
(require 'rational-ui)          ; Better UI experience (modeline etc.)
(require 'rational-windows)     ; Window management configuration
(require 'rational-editing)     ; Whitspace trimming, auto parens etc.
(require 'rational-evil)        ; An `evil-mode` configuration
(require 'rational-org)         ; org-appear, clickable hyperlinks etc.
(require 'rational-project)     ; built-in alternative to projectile
(require 'rational-speedbar)    ; built-in file-tree
;(require 'rational-screencast)  ; show current command and binding in modeline
(require 'rational-compile)     ; automatically compile some emacs lisp files

;; Set further font and theme customizations
(custom-set-variables
   '(rational-ui-default-font
     '(:font "SauceCodePro Nerd Font" :weight semi-bold :height 130)))

(rational-package-install-package 'base16-theme)
(load-theme 'base16-eighties t)

;; Visible bell is really bad on Emacs GUI on MacOs
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(rational-package-install-package 'which-key)
(setq which-key-idle-delay 0.2)
(which-key-mode 1)

;; To not load `custom.el' after `config.el', uncomment this line.
;; (setq rational-load-custom-file nil)

;;; example-config.el ends here
