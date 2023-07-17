;;; ivy-geiser.el --- Ivy support for Geiser symbols  -*- lexical-binding:t; coding:utf-8 -*-

;; Copyright (C) enzu.ru

;; Homepage: https://enzu.ru
;; Keywords: lisp matching tools

;; Package-Version: 1.0.0
;; Package-Requires: ((emacs "24.4"))

;; SPDX-License-Identifier: GPL-3.0

;;; Commentary:

;; Ivy provides a list of symbols available in your Geiser session

;;; Code:

(require 'ivy)

(defun ivy-geiser-get-symbol (unparsed-string)
  "Grab symbol from UNPARSED-STRING."
  (string-match "\\(?:^\\|[^:]:\\)[[:space:]]+\\([^[:space:]]+\\)" unparsed-string)
  (match-string 1 unparsed-string))

(defun ivy-geiser-completion ()
  "Send apropos command to Geiser."
  (let* ((response-alist (geiser-eval--send/wait `(apropos ".*")))
         (response-string (cdr (assoc 'output response-alist)))
         (response-list (butlast (split-string response-string "\n")))
         (response-list-parsed (mapcar #'ivy-geiser-get-symbol response-list)))
    response-list-parsed))

(defun ivy-geiser-describe-symbol ()
  "Describe any Geiser symbol."
  (interactive)
  (ivy-read "Describe Geiser symbol: "
            (ivy-geiser-completion)
            :history 'ivy-describe-geiser-symbol-history
            :require-match t
            :action (lambda (symbol-string)
                      (geiser-doc-symbol (make-symbol symbol-string)))
            :caller 'ivy-describe-common-lisp--spec-symbol))

(provide 'ivy-geiser)

;;; ivy-geiser.el ends here
