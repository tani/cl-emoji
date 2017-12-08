#|
  This file is a part of cl-emoji project.
  Copyright (c) 2015 Masaya TANIGUCHI (asciian@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-emoji-test-asd
  (:use :cl :asdf))
(in-package :cl-emoji-test-asd)

(defsystem cl-emoji-test
  :author "Masaya TANIGUCHI"
  :license ""
  :depends-on (:cl-emoji
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-emoji"))))
  :description "Test system for cl-emoji"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
