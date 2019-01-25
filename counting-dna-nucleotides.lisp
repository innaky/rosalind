(defparameter *aa* 0)
(defparameter *tt* 0)
(defparameter *gg* 0)
(defparameter *cc* 0)

(defun adenine ()
  (setf *aa* (+ *aa* 1)))

(defun thymine ()
  (setf *tt* (+ *tt* 1)))

(defun guanine ()
  (setf *gg* (+ *gg* 1)))

(defun cytosine ()
  (setf *cc* (+ *cc* 1)))

(defun one-nucleotid (nucleotid)
  (cond ((char-equal #\A nucleotid) (adenine))
	((char-equal #\T nucleotid) (thymine))
	((char-equal #\G nucleotid) (guanine))
	((char-equal #\C nucleotid) (cytosine))
	(t (error "You are a nucleotid character?"))))

(defun adn (adn-str)
  (let ((adn-lst (coerce adn-str 'list)))
    (if (equal adn-lst nil)
	nil
	(cons (one-nucleotid (car adn-lst))
	      (adn (cdr adn-lst)))))
  (list *aa* *cc* *gg* *tt*))
