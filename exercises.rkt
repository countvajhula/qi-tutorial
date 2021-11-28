#lang racket

(require qi)

;; If you've gone through tutorial.rkt, then you're ready to try your hand
;; at a few exercises.

;; Exercise 1.
;; Given a list, write a flow to construct a new list with each of the original
;; elements doubled.
;; Example:
;; (1 2 3) -> (1 1 2 2 3 3)

;; Try your hand at it here, and then scroll down for a solution.
;; 


























































;; Solution. Here's one way:
(define-flow double-items
  (~> △ (>< (-< _ _)) ▽))
(double-items (list 1 2 3))

;; If you tried:
;; (map (☯ (-< _ _)) (list 1 2 3))

;; ... that's not wrong. It just isn't supported by Racket's core values
;; implementation. Maybe that'll change someday!

;; Exercise 2.
;; Write a flow to sum all the odd elements in a list



























































;; Solution. Here's one way to do it:
(define-flow odd-sum
  (~> △ (pass odd?) +))

(odd-sum (list 1 2 3 4 3 7))


;;
;; Exercise 3. Root Mean Square
;; The "root mean square" is a measure often used in statistics to
;; estimate the magnitude of some quantity for which there are many
;; independent measurements. For instance, given a set of values
;; representing the "deviation" of the result from the predictions of a
;; model, we can use the square root of the mean of the squares of these
;; values as an estimate of "error" in the model, i.e. inversely, an
;; estimate of the accuracy of the model. The RMS also comes up in other
;; branches of engineering and mathematics.
;;
;; Implement this function, i.e. a function to compute the square root
;; of the mean of the squares of the input values provided in a list.

(define-flow rms
  (~> (-< (~> △ (>< sqr) +)
          length) / sqrt))

;; 👉️ A nested application of a function can always be turned into a sequential
;; flow.
