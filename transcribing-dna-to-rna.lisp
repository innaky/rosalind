(defun timine? (character)
  (if (equal #\T character)
      T
      nil))

(defun timine-to-uracil (character)
  (if (timine? character)
      #\U
      character))

(defun adn-to-arn-lst (adn-str)
  (let ((adn-lst (coerce adn-str 'list)))
    (if (equal adn-lst nil)
	nil
	(cons
	 (if (timine? (car adn-lst))
	     (timine-to-uracil (car adn-lst))
	     (timine-to-uracil (car adn-lst)))
	 (adn-to-arn-lst (cdr adn-lst))))))

(defun adn-to-arn (adn-str)
  (coerce (adn-to-arn-lst adn-str) 'string))

(adn-to-arn "GATGGAACTTGACTACGTAAATT")
