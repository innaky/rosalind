(defun timine? (character)
  (if (equal #\T character)
      T
      nil))

(defun timine-to-uracil (character)
  (if (timine? character)
      #\U
      character))

(defun adn-to-arn (adn-str)
  (let ((adn-lst (coerce adn-str 'list)))
    (if (equal adn-lst nil)
	nil
	(cons
	 (if (timine? (car adn-lst))
	     (timine-to-uracil (car adn-lst))
	     (timine-to-uracil (car adn-lst)))
	 (adn-to-arn (cdr adn-lst))))))
