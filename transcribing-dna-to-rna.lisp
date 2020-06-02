(defun thymine? (dna-chr)
  (if (or (equal #\t dna-chr) (equal #\T dna-chr))
      t
      nil))

(defun t-u (dna-chr)
  (if (thymine? dna-chr)
      #\U
      (char-upcase dna-chr)))

(defun dna-rna-lst (dna)
  (let ((dna-chars (coerce dna 'list)))
    (if (equal dna-chars nil)
	nil
	(cons
	 (if (thymine? (car dna-chars))
	     (t-u (car dna-chars))
	     (t-u (car dna-chars)))
	 (dna-rna-lst (cdr dna-chars))))))

(defun dna-to-rna (dna)
  (coerce (dna-rna-lst dna) 'string))

(dna-to-rna "GATGGAACTTGACTACGTAAATT")
(dna-to-rna "gatggaacttgactacgtaaatt")
