(load "makecd.lisp")
(load "database.lisp")


(defun prompt-read(prompt)
  (format *query-io* "~a:" prompt)
  (force-output *query-io*)
  (read-line *query-io*)
)


(defun prompt-for-cd()
  (makecd 
    (prompt-read "Title")
    (prompt-read "Artist")
    (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
     (y-or-n-p "Ripped")
     )
)

(defun current-status-db()
  (format t "Current status of database: ~%")
  (dump-db)
 )

(defun add-cds()
  (loop (add-record(prompt-for-cd))
  (current-status-db)
  (if (not (y-or-n-p "Another: "))
    (return))))

(load-db "dbstore.db")
(add-cds)
(save-db "dbstore.db")
