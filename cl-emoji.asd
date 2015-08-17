#|
  This file is a part of cl-emoji project.
  Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
|#

#|
  cl-emoji provides the Unicode emoji characters

  Author: Masaya TANIGUCHI (ta2gch@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-emoji-asd
  (:use :cl :asdf))
(in-package :cl-emoji-asd)

(defsystem cl-emoji
  :version "0.1"
  :author "Masaya TANIGUCHI"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "cl-emoji"))))
  :description "cl-emoji provides the Unicode emoji characters"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-emoji-test))))
