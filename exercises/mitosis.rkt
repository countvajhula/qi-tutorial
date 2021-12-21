#lang racket

(require qi)

;; One of the main ways in which living cells reproduce is _mitosis_,
;; where the cell simply divides into two copies of itself. In a way, this
;; simplest form of cell division is a simulacrum of the eternal flow of life
;; itself.
;; Let's see if we can mimic this process with the elements of a simple list!

;; Exercise. Given a list, write a flow to construct a new list with each of the original
;; elements duplicated in place.
;; Example:
;; (1 2 3) -> (1 1 2 2 3 3)

;; Try your hand at it here, and then scroll down for a solution.



























































;; Solution. Here's one way:
(define-flow mitosis
  (~> △ (>< (-< _ _)) ▽))
(mitosis (list 1 2 3))

;; If you tried:
;; (map (☯ (-< _ _)) (list 1 2 3))

;; ... that's not wrong. It just isn't supported by Racket's core values
;; implementation. Maybe that'll change someday!


;; Part 2.

;; With living cells, cell division doesn't stop after one generation. It can happen
;; over and over. Indeed, in a sense, it must happen continuously for billions of years
;; and perhaps trillions of generations, in order for us to be pondering it
;; now. Let's make mitosis "iterate" up to a number of generations we specify.
;; That is, write a function `reproduce` that accepts a list and a number of
;; generations, and produce the resulting list after that many generations of
;; "mitosis."
;; E.g.
;; (reproduce 0 '(1 2)) -> '()
;; (reproduce 1 '(1 2)) -> '(1 1 2 2)
;; (reproduce 3 '(1 2)) -> '(1 1 1 1 2 2 2 2)
























































;; Solution:
(define (reproduce n vs)
  ((☯ (feedback n mitosis)) vs))

(reproduce 3 (list 1 2 3))

;; Well that's great, but there's no "genetic variation" here across multiple
;; generations. Let's mix things up a bit!

;; "Meiosis"

;; TODO: this exercise is in development and will be expanded over time.
;; Check back again soon :)
