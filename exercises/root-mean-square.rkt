#lang racket

(require qi)

;; Exercise. Root Mean Square
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
