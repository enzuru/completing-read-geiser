;;; ivy-geiser.el --- Ivy support for Geiser symbols

;; Copyright (C) enzu.ru
;; SPDX-License-Identifier: GPL-3.0

(defun ivy-geiser-get-symbol (unparsed-string)
  (string-match "\\(?:^\\|[^:]:\\)[[:space:]]+\\([^[:space:]]+\\)" unparsed-string)
  (match-string 1 unparsed-string))

(defun ivy-geiser-completion ()
  (let* ((response-alist (geiser-eval--send/wait `(apropos ".*")))
         (response-string (cdr (assoc 'output response-alist)))
         (response-list (butlast (split-string response-string "\n")))
         (response-list-cleaned (mapcar #'ivy-geiser-get-symbol response-list)))
    response-list-cleaned))

(defun ivy-geiser-describe-symbol ()
  "Describe any Geiser symbol"
  (interactive)
  (ivy-read "Describe Geiser symbol: "
            (ivy-geiser-completion)
            :history 'ivy-describe-geiser-symbol-history
            :require-match t
            :action (lambda (symbol-string)
                      (geiser-doc-symbol (make-symbol symbol-string)))
            :caller 'ivy-describe-common-lisp--spec-symbol))

(provide 'ivy-geiser)
