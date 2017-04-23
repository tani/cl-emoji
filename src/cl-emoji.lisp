#|
Copyright (c) 2015 Masaya TANIGUCHI

This software is released under the MIT license:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
|#

(cl:in-package #:cl-user)
(defpackage #:cl-emoji
  (:use #:cl)
  (:nicknames #:emoji)
  (:export code name annot))
(in-package #:cl-emoji)

(defvar *default-emoji-version* "4.0")
(defvar *default-cldr-version* "release-30")

(defun load-emoji (&optional
                     (emoji-version *default-emoji-version*)
                     (cldr-version *default-cldr-version*))
  (let ((emoji-list-path (asdf:system-relative-pathname
                          :cl-emoji (pathname (format nil "data/emoji_~a_~a.lisp"
                                                      emoji-version cldr-version)))))
    (with-open-file (s emoji-list-path)
      (read s))))

(defun code (code)
  (first (find-if (lambda (c) (equalp code (second c)))
                  (load-emoji))))

(defun name (name)
  (first (find-if (lambda (n) (string= name (third n)))
                  (load-emoji))))

(defun annot (annot)
  (loop for a in (load-emoji)
     if (member annot (fourth a) :test #'string=)
     collect a))
