#lang racket

(require qi)

;;; Currying and Partial Application

;; You can always use Qi in place of currying. Read below for more on why
;; you should.

;; In the functional style of programming, "currying" is a technique
;; often used to define a new function by partially applying an existing
;; one, to avoid writing the new one in all of its gory detail. For
;; instance, if we wanted to double all the numbers in a list, we could
;; map the list under a lambda:
(map (λ (v) (* v 2)) (range 10))

;; Or we could use currying:
(require racket/function)
(map (curry * 2) (range 10))

;; This way is more elegant, in a way, because it suggests that the
;; operation you are performing is a simple modulation of an existing
;; function. But what is this word, "curry"? Apparently, it's a way to
;; convert a function accepting multiple arguments into a sequence of
;; functions, each accepting just one argument. But what does this have
;; to do with what we are trying to do here? Precisely. This way is
;; elegant, but it introduces concepts into the written representation of
;; the code that are tangential to the intent of the code -- unless, of
;; course, converting a function into a sequence of unary functions
;; happens to be what you are trying to do. But more likely, you're just
;; trying to partially apply a function to arguments.

;; In short, it's more than we need to think about here. It represents
;; visual noise, and is opaque to newcomers. We could use Qi here,
;; instead:
(map (☯ (* 2)) (range 10))

;; Qi can always be used in place of currying in this way, including for
;; named flows as we saw with the implementation of `also-double`. And as
;; it also provides templating via _ and __, it is both a simpler and
;; more flexible alternative.
