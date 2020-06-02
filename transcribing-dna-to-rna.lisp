(defun thymine? (dna-chr)
  "Check if the character is a tymine"
  (if (or (equal #\t dna-chr) (equal #\T dna-chr))
      t
      nil))

(defun match? (elem lst)
  "General predicate eager False, check if `elem' exists in `lst'."
  (if (equal nil lst)
      nil
      (or (equal elem (car lst))
	  (match? elem (cdr lst)))))

(defun match-dna? (dna-chr)
  "Check if the `dna-chr' is a valid DNA character, else return Error"
  (if (match? dna-chr '(#\a #\A #\t #\T #\g #\G #\c #\C))
      (char-upcase dna-chr)
      (error "~A this is not a valid nucleotide." dna-chr)))

(defun t-u (dna-chr)
  "Transform the thymine to Uracil, match if the another characters are valid and upcase this
else return a error."
  (if (thymine? dna-chr)
      #\U
      (match-dna? dna-chr)))

(defun dna-rna-lst (dna)
  "Transform DNA string to RNA but return a list of RNA characters."
  (let ((dna-chars (coerce dna 'list)))
    (if (equal dna-chars nil)
	nil
	(cons
	 (if (thymine? (car dna-chars))
	     (t-u (car dna-chars))
	     (t-u (car dna-chars)))
	 (dna-rna-lst (cdr dna-chars))))))

(defun dna-to-rna (dna)
  "Take a DNA string and returng a RNA string."
  (coerce (dna-rna-lst dna) 'string))

;; test

;;good
(dna-to-rna "GATGGAACTTGACTACGTAAATT")
(dna-to-rna "gatggaacttgactacgtaaatt")

;; bad
(dna-to-rna "TATAX")
