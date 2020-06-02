(defmacro def (lname lvar)
  "Define a lexical function."
  `(defun ,lname ()
     (incf ,lvar)))

(defmacro do-equal (action (upper lower))
  "Reduce the `or' double equal for the DNA characters in uppercase or lowercase."
  `(or (equal ,action ,upper) (equal ,action ,lower)))

(let ((aa 0) (tt 0) (gg 0) (cc 0))
  (def adenine aa)
  (def thymine tt)
  (def guanine gg)
  (def cytosine cc)
  (defun zero ()
    (setq aa 0) (setq tt 0)
    (setq gg 0) (setq cc 0)))

(defun string-to-charlst (long-str &optional (position 0))
  "The input is a string the output a list of characters, run from character 0
for default or for any other character, minor to length string."
  (if (not (numberp position))
      (format t "~A is not type numb~%" position)
      (if (or (>= position (length long-str)) (< position 0))
	  nil
	  (let ((end (length long-str)))
	    (if (equal position end)
		nil
		(cons (char long-str position)
		      (string-to-charlst long-str (+ 1 position))))))))

(defun count-dna-bases (dna-chars)
  "Take a list of chars and call the closures if the char match."
  (if (equal nil dna-chars)
      nil
      (cond ((do-equal (car dna-chars) (#\A #\a))
	     (progn
	       (adenine)
	       (count-dna-bases (cdr dna-chars))))
	    ((do-equal (car dna-chars) (#\T #\t))
	     (progn
	       (thymine)
	       (count-dna-bases (cdr dna-chars))))
	    ((do-equal (car dna-chars) (#\G #\g))
	     (progn
	       (guanine)
	       (count-dna-bases (cdr dna-chars))))
	    ((do-equal (car dna-chars) (#\C #\c))
	     (progn
	       (cytosine)
	       (count-dna-bases (cdr dna-chars))))
	    (t (error "This is not a valid nucleotide.")))))

(defun dna (dna)
  "Take a DNA string and return a list with the count of (Adenine Cytosine Guanine Thymine)."
  (progn
    (count-dna-bases (string-to-charlst dna))
    (list (- (adenine) 1) (- (cytosine) 1)
	  (- (guanine) 1) (- (thymine) 1))))

