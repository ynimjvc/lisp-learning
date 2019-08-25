(defvar *db* nil)

(defun make-cd (title artist rating ripped)
    (
        list
            :title title
            :artist artist
            :rating rating
            :ripped ripped
    ))

(defun add-record (cd)
    (
        push cd *db*
    ))

(defun dump-db ()
    (format t "dump~%~{~{~10t~a: ~a~%~}~%~}" *db*))

(add-record (make-cd "first" "prince" 0 0))
(add-record (make-cd "second" "prince" 0 0))

(defun prompt-read (prompt)
    (format *query-io* "~a: " prompt)
    (force-output *query-io*)
    (read-line *query-io*))

(defun prompt-for-cd ()
    (make-cd
        (prompt-read "Title")
        (prompt-read "Artist")
        (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
        (y-or-n-p "Ripped[y/n]")
    ))

(defun add-cds()
    (loop (add-record (prompt-for-cd))
        (if (not (y-or-n-p "Another CD? [y/n]: ")) (return))
    ))


;; -------------

(add-cds)
(dump-db)
