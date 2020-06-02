(defun thymine? (dna-chr)
  (if (or (equal #\t dna-chr) (equal #\T dna-chr))
      t
      nil))

(defun match? (elem lst)
  (if (equal nil lst)
      nil
      (or (equal elem (car lst))
	  (match? elem (cdr lst)))))

(defun match-dna? (dna-chr)
  (if (match? dna-chr '(#\a #\A #\t #\T #\g #\G #\c #\C))
      (char-upcase dna-chr)
      (error "~A this is not a valid nucleotide." dna-chr)))

(defun t-u (dna-chr)
  (if (thymine? dna-chr)
      #\U
      (match-dna? dna-chr)))

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
(dna-to-rna "TATAX")
