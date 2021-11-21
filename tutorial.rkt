#lang racket

;; Welcome to the interactive Qi tutorial!
;;
;; Qi is a general-purpose functional language, but it isn't a #lang,
;; it's just a library. You can use it in any module just by:

(require qi)

;; The basic way to write a flow is to use the ☯ form. A flow defined
;; this way evaluates to an ordinary function, and you can pass input
;; values to the flow by simply invoking this function with arguments.

;; Ordinary functions are already flows.

((☯ sqr) 3)

;; Ordinary functions can be partially applied using templates.

((☯ (+ 2)) 3)

((☯ (string-append "a" _ "c")) "b")

;; Literals are interpreted as flows generating them.

((☯ "hello") 3)

;; Values can be "threaded" through multiple flows in sequence.

((☯ (~> sqr add1)) 3)

;; More than one value can flow.

((☯ (~> + sqr add1)) 3 5)

;; Since threading values through flows in sequence is so common, you can
;; use a shorthand to immediately invoke such a sequential flow on input
;; values.

(~> (3 5) + sqr add1)

;; Flows may divide values.

((☯ (-< add1 sub1)) 3)

((☯ (-< + -)) 3 5)

;; Flows may channel values through flows in parallel.

((☯ (== add1 sub1)) 3 7)

;; You could also pass all input values independently through a common flow.

((☯ (>< sqr)) 3 4 5)

;; Predicates can be composed by using and, or, and not.

((☯ (and positive? integer? (not odd?))) 2)

;; It is sometimes useful to separate an input list into its component values using a "prism."

((☯ (~> △ +)) (list 1 2 3))

;; ... or constitute a list out of values using an "upside-down prism."

((☯ (~> (>< sqr) ▽)) 1 2 3)

;; And those are the basics. To learn more, continue the tutorial and find complete
;; docs at:
;;
;;    https://docs.racket-lang.org/qi/index.html
;;
;; Discuss and report issues on the source repo:
;; 
;;    https://github.com/countvajhula/qi
;;
;; Just go with the flow! 🤙
