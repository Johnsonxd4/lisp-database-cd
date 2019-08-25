(defvar *db* nil)
(defvar *dbstorename* "dbstore.db")

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

(defun select (selector)
  (remove-if-not selector *db*))

(defun make-comparation-expr(field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparation-list(fields)
  (loop while fields
	collecting (make-comparation-expr(pop fields)(pop fields))))

(defmacro where(&rest clauses)
  `#'(lambda(cd)(and ,@(make-comparation-list clauses))))
