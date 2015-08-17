# :smile: Cl-Emoji
cl-emoji provides the Unicode emoji characters

:smile: :heart_eyes: :scream: :alien: :fire: :zzz: :hand:

## :boom: Usage

```lisp
(ql:quicklaod :cl-emoji)
(emoji:emoji :code "U+1F600")
=> ("😀" "U+1F600" "grinning face" ("face" "grin" "person"))
(emoji:emoji :name "grinning face")
=> ("😀" "U+1F600" "grinning face" ("face" "grin" "person"))
(emoji:annot :annotation "face")
=> (("😀" "U+1F600" "grinning face" ("face" "grin" "person")) ...)
```

```lisp
(format t "Hello~a!~%" (car (emoji:emoji :code "U+1F600")))
=> Hello😀!
```
see also [Full Emoji Data](http://unicode.org/emoji/charts/full-emoji-list.html)

## :fire: Installation

```shell
$ cd ~/common-lisp
$ git clone git://github.com/ta2gch/cl-emoji
```

## :laughing: Author

* Masaya TANIGUCHI (ta2gch@gmail.com)

## :ok_hand: Copyright

Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)

* src/cl-emoji.lisp is licensed under the MIT License
* data/emoji-list.lisp is licensed under the Unicoded License
