# :smile: Cl-Emoji
cl-emoji provides the Unicode emoji characters

:smile: :heart_eyes: :scream: :alien: :fire: :zzz: :hand:

## :boom: Usage

```lisp
(ql:quicklaod :cl-emoji)
(emoji:code "U+1F600")
=> "😀"
(emoji:name "grinning face")
=> "😀"
(emoji:annot "face")
=> (("😀" "U+1F600" "grinning face" ("face" "grin" "person")) ...)
```

```lisp
(format t "Hello~a!~%" (emoji:name "grinning face"))
=> Hello😀!
```
According to PR #3, we can use following APIs.

If you tell emoji version to cl-emoji API, do like this (and I checked if path generated at API calling):

```lisp
CL-USRE> (trace format)
CL-USER> (cl-emoji:annot "grin")
  0: (FORMAT NIL "file ~A"
             "/home/foo/cl-emoji/data/emoji_4.0_release-30.lisp")
  0: FORMAT returned
       "file /home/foo/cl-emoji/data/emoji_4.0_release-30.lisp"
(("😀" ("U+1F600") "grinning face" ("face" "grin") "Smileys & People"
  "face-positive")
 ...)
CL-USER> (let ((cl-emoji:*current-version* (second cl-emoji:+versions+)))
           (cl-emoji:annot "grin"))
  0: (FORMAT NIL "file ~A"
             "/home/foo/cl-emoji/data/emoji_5.0_release-31.lisp")
  0: FORMAT returned
       "file /home/foo/cl-emoji/data/emoji_5.0_release-31.lisp"
(("😀" ("U+1F600") "grinning face" ("face" "grin") "Smileys & People"
  "face-positive")
 ...)
```

According to **PR #xx**, we can list annotations, groups and subgroups.
Cause of this now we can know what is keyword when searching with `emoji:annot`.

```lisp
CL-USER> (emoji:list-subgroups)
("face-positive" "face-neutral" "face-negative" "face-role" "face-sick"
 "creature-face" "cat-face" "monkey-face" "person" "person-role"
 ...)
CL-USER> (emoji:subgroup (first (emoji:list-subgroups)))
(("😀" ("U+1F600") "grinning face" ("face" "grin") "Smileys & People"
  "face-positive")
 ("😁" ("U+1F601") "grinning face with smiling eyes"
  ("eye" "face" "grin" "smile") "Smileys & People" "face-positive")
 ("😂" ("U+1F602") "face with tears of joy" ("face" "joy" "laugh" "tear")
  "Smileys & People" "face-positive")
 ("🤣" ("U+1F923") "rolling on the floor laughing"
 ...))
```

### :smile: Groups and Subgroups

Those are appears in [Full Emoji Data](http://www.unicode.org/emoji/charts-beta/full-emoji-list.html), for instance `Smileys & People` is a group and `face-positive` is a subgroup.

You can get emoji by group name and subgroup name with API `cl-emoji:group` and `cl-emoji:subgroup`.
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
