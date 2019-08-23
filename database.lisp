(defvar *db* nil)

(defun add-record(cd)
  (push cd *db*)
)

(defun dump-db()
    (format t "~{~{~a:~10t~a~%~}~%~}" *db*)
)

(defun save-db(filename)
  (with-open-file (out filename
		  :direction :output
		  :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

(defun load-db(filename)
  (with-open-file (in filename)
   (with-standard-io-syntax
     (setf *db* (read in)))))

