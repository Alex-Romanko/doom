;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Alex Romanko"
      user-mail-address "alex@romankot.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

(setq doom-theme 'doom-gruvbox)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Add support of Russian keybord keys for evil/emacs commands
(use-package! reverse-im
  :config
  (reverse-im-activate "russian-computer"))

;; set font
(setq doom-font (font-spec :family "Droid Sans Mono" :size 14 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 16))

;; rainbow parentheses everywhere
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package rainbow-mode
  :ensure t
  :config
  (rainbow-mode t))

(global-visual-line-mode 1)
(global-hl-line-mode 1)
(global-prettify-symbols-mode 1)

(global-set-key (kbd "<f9>") 'tabbar-mode)
(global-set-key (kbd "<f10>") 'menu-bar-mode)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)
(global-set-key (kbd "<f12>") 'tool-bar-mode)

;;;; csv-mode
(use-package csv-mode
  :mode ("\\.[Cc][Ss][Vv]\\'" . csv-mode))

;; map keys for autocompleat in company plugin
;; unbind <return> and bind complete to <C-SPC> and <C-return>
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "C-SPC") #'company-complete-selection)
  (define-key company-active-map (kbd "<C-return>") #'company-complete-selection))

;; map key for eval multiple lines in ess in visual mode
(define-key evil-visual-state-map (kbd "C-<return>") #'ess-eval-region-or-line-visibly-and-step)

;; add tree sitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; togle highlight mode
(global-set-key (kbd "C-c t") 'tree-sitter-hl-mode)

;; add Quarto support
;; load the library
(require 'quarto-mode)

;; Note that the following is not necessary to run quarto-mode in .qmd files! It's merely illustrating
;; how to associate different extensions to the mode.
;; (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-quarto-mode))
;;
;; Or, with use-package:
;; (use-package quarto-mode
;;   :mode (("\\.Rmd" . poly-quarto-mode)))

;; add rmarkdown support
(use-package poly-markdown)
(use-package poly-R	    ;; FIXME tree-sitter doesn't work in .md mode
  :config                   ;;       should be disabled
  (add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
  (add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
  (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
  (add-to-list 'auto-mode-alist '("\\.Rmarkdown" . poly-markdown+r-mode)))

;; enable autosave
;; (setq auto-save-default t)
;; (setq auto-save-visited-mode t)


(global-undo-tree-mode)

;; tab bar mode
(setq tab-bar-new-tab-choice "*doom*")
(setq tab-bar-close-button-show nil)
(setq tab-bar-tab-hints t)
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))


(global-set-key (kbd "s-{") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "s-}") 'tab-bar-switch-to-next-tab)
;; (global-set-key (kbd "s-t") 'tab-bar-new-tab)
(global-set-key (kbd "s-t") 'tab-new)
(global-set-key (kbd "s-w") 'tab-bar-close-tab)


