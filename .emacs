(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))

(setq read-file-name-completion-ignore-case  t)
(setq read-buffer-completion-ignore-case  t)
(setq completion-ignore-case  t)


;;not sure why cuda-mode doesn't work but c++ mode is ok

;;(add-to-list 'load-path "~/Library/emacs")
;;(autoload 'cuda-mode "cuda-mode.el")
;;(add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))
    (add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
