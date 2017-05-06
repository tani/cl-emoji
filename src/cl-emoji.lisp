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
  (:export
   codepoint
   name
   annotation
   group
   subgroup
   group-apropos
   subgroup-apropos
   annotation-apropos
   with-emoji-list
   +versions+
   *current-version*))
(in-package #:cl-emoji)

(defvar +versions+ '("4.0_release-30"
                     "5.0_release-31"))
(defvar *current-version* "4.0_release-30")

(defun load-emoji ()
  (let ((emoji-list-path (asdf:system-relative-pathname
			  :cl-emoji (pathname (format nil "data/emoji_~a.lisp"
						      *current-version*)))))
    (with-open-file (s emoji-list-path)
      (read s))))

(defun bind1 (function &rest args1)
  (lambda (&rest args2)
    (apply function (append args1 args2))))

(defun bind2 (function &rest args2)
  (lambda (&rest args1)
    (apply function (append args1 args2))))

(defun emoji-apropos (key value &key test)
  (find-if (lambda (r) (funcall test value (getf r key))) (load-emoji)))

(defun emoji-apropos-list (key value &key test)
  (remove-if-not (lambda (r) (funcall test value (getf r key))) (load-emoji)))

(defun codepoint (code)
  (getf (emoji-apropos :codepoint code :test #'equalp) :characters))

(defun name (name)
  (getf (emoji-apropos :name name :test #'string=) :characters))

(defun annotation (annot)
  (emoji-apropos-list
   :annotation annot
   :test (bind2 #'member :test #'string=)))

(defun group (group)
  (emoji-apropos-list
   :group group
   :test #'string=))

(defun subgroup (subgroup)
  (emoji-apropos-list
   :subgroup subgroup
   :test #'string=))

(defun group-apropos (keyword)
  (let ((filter (bind2 #'getf :group))
	(result (emoji-apropos-list :group keyword :test #'search)))
    (format t "~{~a~%~}"
	    (remove-duplicates
	     (mapcar filter result)
	     :test #'string=))))

(defun subgroup-apropos (keyword)
  (let ((filter (bind2 #'getf :subgroup))
	(result (emoji-apropos-list :subgroup keyword :test #'search)))
    (format t "~{~a~%~}"
	    (remove-duplicates
	     (mapcar filter result)
	     :test #'string=))))

(defun annotation-apropos (keyword)
  (let* ((filter (bind2 #'getf :annotation))
	 (test   (bind1 #'search keyword))
	 (result (apply #'append (mapcar filter (load-emoji)))))
    (format t "~{~a~%~}"
	    (remove-duplicates
	     (remove-if-not test result)
	     :test #'string=))))

(defmacro with-emoji-list ((emoji-list-var) &body body)
  `(let ((,emoji-list-var (load-emoji)))
     ,@body))
