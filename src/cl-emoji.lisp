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
  (:export emoji))
(in-package #:cl-emoji)

(defun emoji (&key (code nil code-supplied-p)
		(name nil name-supplied-p)
		(annotation nil annotation-supplied-p))
  (with-open-file (s (asdf:system-relative-pathname :cl-emoji #p"data/emoji-list.lisp"))
    (let ((emoji-list (read s)))
      (cond
	(code-supplied-p
	 (first (find-if (lambda (c) (string= code (second c))) emoji-list)))
	(name-supplied-p
	 (first (find-if (lambda (n) (string= name (third n))) emoji-list)))
	(annotation-supplied-p
	 (loop for a in emoji-list
	       if (member annotation (fourth a) :test #'string=)
		 collect a))))))
