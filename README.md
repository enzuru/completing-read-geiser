# completing-read support for Geiser

This is a simple package that provides compelting-read for Geiser symbols. When a symbol is select, a definition of the symbol using Geiser.

Use the completion framework of your choice, whether (ivy)[https://github.com/abo-abo/swiper], (vertico)[https://github.com/minad/vertico], (mct)[https://git.sr.ht/~protesilaos/mct], or just the standard icomplete.

I have only tested this with Guile, as that is the only Scheme distribution that I use.

I run the completion query using `(apropos ".*")`. If I need to do something else for your Scheme distribution, please submit a pull request.

## Installation

```lisp
(straight-use-package
 '(completing-read-geiser
   :type git
   :host github
   :repo "enzuru/completing-read-geiser"))

(define-key scheme-mode-map (kbd "C-h s") 'completing-read-geiser-describe-symbol)
(define-key geiser-repl-mode-map (kbd "C-h s") 'completing-read-geiser-describe-symbol)
(require 'completing-read-geiser)
```

## Using with Ivy

```lisp
(setf completing-read-function #'ivy-completing-read)
```

## License

Licensed under the GPLv3; copyright is assigned to my eponymous nonprofit [enzu.ru](https://enzu.ru)
