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

(defun reverse-lst (lst)
  (reverse lst))

(defun reverse-adn (str-adn)
  (let ((lst-adn (reverse (coerce str-adn 'list))))
    (if (equal lst-adn nil)
	nil
	(cons (one-nucleotid (car lst-adn))
	      (reverse-adn (cdr lst-adn))))))
