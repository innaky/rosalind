(defparameter *adn* nil)

(defun adenine (str-var)
  (cons #\A str-var))

(defun thymine (str-var)
  (cons #\T str-var))

(defun guanine (str-var)
  (cons #\G str-var))

(defun cytosine (str-var)
  (cons #\C str-var))

(defun one-nucleotid (nucleotid)
  (cond ((char-equal #\A nucleotid) (thymine *adn*))
	((char-equal #\T nucleotid) (adenine *adn*))
	((char-equal #\G nucleotid) (cytosine *adn*))
	((char-equal #\C nucleotid) (guanine *adn*))
	(t (error "Are you a nucleotide?"))))

(defun complement-adn (str-adn)
  (let ((lst-adn (coerce str-adn 'list)))
    (if (equal lst-adn nil)
	nil
	(cons (one-nucleotid (car lst-adn))
	      (complement-adn (cdr lst-adn))))))

(defun flatten (lst)
  (labels ((rflatten (lst1 acc)
             (dolist (el lst1)
               (if (listp el)
                   (setf acc (rflatten el acc))
                   (push el acc)))
             acc))
    (reverse (rflatten lst nil))))

(defun reverse-complement (str-adn)
  (coerce (flatten (reverse (complement-adn str-adn))) 'string))

(reverse-complement "AAAACCCGGT")
