(in-package :cl-user)
(defpackage cl-emoji-test
  (:use :cl
        :cl-emoji
        :prove))
(in-package :cl-emoji-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-emoji)' in your Lisp.

(with-open-file (s (asdf:system-relative-pathname 
		    :cl-emoji (pathname (format nil "data/emoji_~a.lisp"
                                        cl-emoji::*current-version*))))
  (let ((emoji-list (read s)))
    (plan (+ 8 (length emoji-list)))
    (dolist (u emoji-list)
      (is (length u) 6))
    (is "😀" (emoji:code '("U+1F600")))
    (is "😁" (emoji:name "grinning face with smiling eyes"))
    (ok (< 0 (length (emoji:annot "blue"))))
    (ok (< 0 (length (emoji:group "Smileys & People"))))
    (ok (< 0 (length (emoji:subgroup "clothing"))))
    (ok (< 0 (length (emoji:list-annots))))
    (ok (< 0 (length (emoji:list-groups))))
    (ok (< 0 (length (emoji:list-subgroups))))))

(finalize)
