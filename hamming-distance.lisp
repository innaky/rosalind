(defun hamming-internal (dna1-chrs dna2-chrs)
  (labels ((internal (idna1-chrs idna2-chrs distance)
	     (if (not (equal (car idna1-chrs) (car idna2-chrs))) (incf distance))
	     (cond ((equal nil idna1-chrs) distance)
		   (t (internal (cdr idna1-chrs) (cdr idna2-chrs) distance)))))
    (internal dna1-chrs dna2-chrs 0)))

(defun hamming-distance (dna1 dna2)
  (hamming-internal (coerce dna1 'list) (coerce dna2 'list)))
