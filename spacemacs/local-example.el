;; -*- mode: emacs-lisp; lexical-binding: t -*-
(defalias '_dotspacemacs/layers (symbol-function 'dotspacemacs/layers))
(defun dotspacemacs/layers ()
  (dotspacemacs|call-func _dotspacemacs/layers)
  ;; REPLACE ME
  )

(defalias '_dotspacemacs/user-config (symbol-function 'dotspacemacs/user-config))
(defun dotspacemacs/user-config ()
  ;; REPLACE ME
  (dotspacemacs|call-func _dotspacemacs/user-config))
