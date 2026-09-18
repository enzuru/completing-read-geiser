;;; completing-read-geiser.el --- Search Geiser symbols with completing-read  -*- lexical-binding:t; coding:utf-8 -*-

;; Copyright (C) enzu.ru

;; Homepage: https://github.com/enzuru/completing-read-geiser
;; Keywords: lisp matching tools

;; Package-Version: 1.0.0
;; Package-Requires: ((emacs "24.4") (geiser "0.28"))

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; completing-read-geiser provides a list of symbols available in your Geiser session

;;; Code:

(require 'geiser)

(defun completing-read-geiser--get-symbol (unparsed-string)
  "Grab symbol from UNPARSED-STRING."
  (string-match "\\(?:^\\|[^:]:\\)[[:space:]]+\\([^[:space:]]+\\)" unparsed-string)
  (match-string 1 unparsed-string))

(defun completing-read-geiser-search ()
  "Send apropos command to Geiser."
  (let* ((response-alist (geiser-eval--send/wait `(apropos ".*")))
         (response-string (cdr (assoc 'output response-alist)))
         (response-list (butlast (split-string response-string "\n")))
         (response-list-parsed (mapcar #'completing-read-geiser--get-symbol response-list)))
    response-list-parsed))

(defun completing-read-geiser ()
  "Get list of symbols available in your Geiser session."
  (interactive)
  (geiser-doc-symbol
   (make-symbol (completing-read "Look up symbol in Geiser: "
                                 (completing-read-geiser-search)))))

(provide 'completing-read-geiser)

;;; completing-read-geiser.el ends here
