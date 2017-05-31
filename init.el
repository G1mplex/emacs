;;(package-refresh-contents)
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; === CUSTOM CHECK FUNCTION ===
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-install package)))
     packages)
)

;; === List my packages ===
;; simply add package names to the list
(ensure-package-installed
 'paganini-theme
 'better-defaults
 'auctex
 'yasnippet
 'neotree
 'minimap
 'company-auctex
 'company
 'helm
 'use-package
 'projectile
 'helm-projectile
 'volatile-highlights
 'flycheck
 'dashboard
)

(load-theme 'paganini t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))

(electric-pair-mode 1)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)


;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together

;;(global-auto-complete-mode f)


;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will

(require 'company-auctex)
(company-auctex-init)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;;(minimap-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-minimum-width 0)
 '(minimap-window-location (quote right)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "royal blue"))))
 '(web-mode-html-attr-name-face ((t (:foreground "dark orange"))))
 '(web-mode-html-tag-face ((t (:foreground "lime green")))))



;; duplicate line set to C-c C-l
(global-set-key "\C-c\l" "\C-a\C- \C-n\M-w\C-y")


(defun move-line-up ()
  (interactive)

  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))


(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)


(global-company-mode)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-helm)

(global-flycheck-mode)

(elpy-enable)

(require 'dashboard)
(dashboard-setup-startup-hook)
;; Or if you use use-package
(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(global-anzu-mode 1)
