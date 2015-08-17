(in-package :cl-user)
(defpackage cl-emoji-test
  (:use :cl
        :cl-emoji
        :prove))
(in-package :cl-emoji-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-emoji)' in your Lisp.

(with-open-file (s (asdf:system-relative-pathname 
		    :cl-emoji #p"data/emoji-list.lisp"))
  (let ((emoji-list (read s)))
    (plan (+ 3 (length emoji-list)))
    (dolist (u emoji-list)
      (is (length u) 4))
    (is "😀" (first (emoji :code "U+1F600")))
    (is "😁" (first (emoji :name "grinning face with smiling eyes")))
    (ok (< 0 (length (emoji :annotation "blue"))))))

(finalize)
