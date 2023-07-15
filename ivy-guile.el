;;; ivy-guile.el --- Ivy support for Guile symbols

;; Copyright (C) enzu.ru
;; SPDX-License-Identifier: GPL-3.0

(defun ivy-geiser-get-symbol (unparsed-string)
  (interactive)
  (string-match "\\(?:^\\|[^:]:\\)[[:space:]]+\\([^[:space:]]+\\)" unparsed-string)
  (match-string 1 unparsed-string))

(defun ivy-geiser-completion ()
  (interactive)
  (let* ((response-alist (geiser-eval--send/wait `(apropos ".*")))
         (response-string (cdr (assoc 'output response-alist)))
         (response-list (butlast (split-string response-string "\n")))
         (response-list-cleaned (mapcar #'ivy-geiser-get-symbol response-list)))
    response-list-cleaned))

(defun ivy-guile-describe-symbol ()
  "Describe any Guile symbol"
  (interactive)
  (ivy-read "Describe Guile symbol: "
            (ivy-geiser-completion)
            :history 'ivy-describe-guile-symbol-history
            :require-match t
            :action (lambda (symbol-string)
                      (geiser-doc-symbol (make-symbol symbol-string)))
            :caller 'ivy-describe-common-lisp--spec-symbol))

(provide 'ivy-guile)
