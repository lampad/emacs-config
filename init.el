;; emacs config
;; debugging
(setq debug-on-error t)
(setq stack-trace-on-error 1)

;; add to load paths
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
			 ("gnu" . "http://elpa.gnu.org/packages/")))

(global-set-key [f1] 'goto-line)

(global-set-key "\C-z" 'undo)
(global-set-key "\C-x\C-b" 'buffer-menu) ;; so the buffer list appears in the current window
(global-set-key [(ctrl /)] 'comment-or-uncomment-region)
;;Chris's custom functions
(global-set-key (kbd "C-M-<up>") 'duplicate-line-up)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;;Global Settings
(setq inhibit-startup-message t)

;;Add Autopair
(require 'autopair)
;; (autopair-global-mode) ;; enable autopair in all buffers
(add-hook 'ruby-mode-hook (lambda () (autopair-mode t)))

;;Pretty ruby formatting
(setq ruby-deep-indent-paren nil)
(setq ruby-deep-indent-paren-style nil)
(setq ruby-deep-arglist nil)

;;CMake mode
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))
;;Dart mode
(require 'dart-mode)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))

;; better mouse scrolling
(require 'smooth-scrolling)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)
(setq scroll-step 1)

;; overwrite highlighted selections
(delete-selection-mode 1)

(line-number-mode 1)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Taken from http://www.emacswiki.org/emacs/AutoIndentation#SmartPaste

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))
