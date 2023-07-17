# Ivy completion for Geiser symbols

This is a simple package that provides [Ivy](https://github.com/abo-abo/swiper) completion for Geiser symbols, providing a definition of the symbol using Geiser.

I have only tested this with Guile, as that is the only Scheme distribution that I use.

I run the completion query using `(apropos ".*")`. If I need to do something else for your Scheme distribution, please submit a pull request.

## Installation

```
(straight-use-package
 '(ivy-geiser
   :type git
   :host github
   :repo "enzuru/ivy-geiser"))
```

## License

Licensed under the GPLv3; copyright is assigned to my eponymous nonprofit [enzu.ru](https://enzu.ru)
