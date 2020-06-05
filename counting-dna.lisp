(defmacro double-equal (action (upper lower))
  "Reduce the `or' double equal for the DNA characters in uppercase and lowercase."
  `(or (equal ,action ,upper) (equal ,action ,lower)))

(defun dna-internal (dna-chrs)
   "`dna-chrs' is a list of DNA characters, the output is a list with the count respectives
of nitrogenous bases"
  (labels ((internal (idna-chrs adenine thymine guanine cytosine)
	     (cond ((double-equal (car idna-chrs) (#\A #\a)) (incf adenine))
		   ((double-equal (car idna-chrs) (#\T #\t)) (incf thymine))
		   ((double-equal (car idna-chrs) (#\G #\g)) (incf guanine))
		   ((double-equal (car idna-chrs) (#\C #\c)) (incf cytosine)))
	     (cond ((equal nil idna-chrs) (list adenine cytosine guanine thymine))
		   (t (internal (cdr idna-chrs) adenine thymine guanine cytosine)))))
    (internal dna-chrs 0 0 0 0)))

(defun dna (dna)
  "`dna' is a DNA string. The output is a list with the count respectives of nitrogenous bases."
  (dna-internal (coerce dna 'list)))
