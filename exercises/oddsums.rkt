#lang racket

(require qi)

;; Exercise. Write a flow to sum all the odd elements in a list



























































;; Solution. Here's one way to do it:
(define-flow odd-sum
  (~> △ (pass odd?) +))

(odd-sum (list 1 2 3 4 3 7))
