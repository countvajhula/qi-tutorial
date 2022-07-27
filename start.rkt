#lang racket

;;;;; Welcome to the interactive Qi tutorial!
;;
;;
;;                        .,ad88888888baa,
;;                    ,d8P"""        ""9888ba.
;;                 .a8"          ,ad88888888888a
;;                aP'          ,88888888888888888a
;;              ,8"           ,88888888888888888888,
;;    .d88     ,8'            (888888888( )888888888,    88b.
;;   d88P"    ,8'             `8888888888888888888888    "Y88b
;;  d88P      8)               `888888888888888888888,     Y88b
;;  888       8                  "8888888888888888888)      888
;;  888       8                   `888888888888888888)      888
;;  Y88b      8)                    "8888888888888888      d88P
;;   Y88b.    (b                     "88888888888888'    .d88P
;;    "Y88    `8,        (8)          8888888888888)     88P"
;;             "8a                   ,888888888888)
;;               V8,                 d88888888888"
;;                `8b,             ,d8888888888P'
;;                  `V8a,       ,ad8888888888P'
;;                     ""88888888888888888P"
;;                          """"""""""""
;;
;;
;;
;;                         (ASCII Art Credit: Normand Veilleux)

;;
;; This is your starting point for all of the tutorial materials in
;; this repo. The tutorial is structured as ordinary Racket modules,
;; with runnable examples interspersed with explanatory comments.

;;;; GUIDE
;;
;;                               .:                                 .:.
;;
;;                    .:........
;;    ..           .:^~!!~~!!!!!!!!!~~~~~!~~~^^^.           ..
;;    ..         :^~!!!!!777777??????JJJYYYYYYYJ:           ..
;;               .^^~!!777777777???JJJ?JJYYYYY5J:
;;                 .:~~!!!!!!7777???77???JJJJJY?.
;;                    .::::::::::::::::::??:::::          .....     .:.
;;                                ....:::77:^^^^^~~~~~~~~~!!!!~^:.   ..
;;                                ~JJJJJJJJJJJ???????7777777777!~~~::
;;                                ^J5YYYYYYYJJJJJ???777777777!!!!!~^:
;;    ::                ::        ^JYYYYJJJJJJJ??????7777!!!~!!~~:.
;;                                .~~~~~~J?^^^^^^^^^^^^^^:::::::
;;                  .....................77 .  .
;;               .:^~!!!!!!!!!77777777???JJ?????!                    .
;;            .:^~!!7777777777?????JJJJJYYYYYY5Y!                   .:.
;;            .^^~!!77777777777???JJJJJJJJYYYYYY7
;;              .:^~!!!!!!!!!!77777777777J?!!!!!~
;;                 .:::::::..........   .7?.         .......::..
;;                                 ~77777JJ77!!!!!!!!!!!!!!!!!!~^:
;;                                 7Y5YYYYYYYJJJ??????7777777777!!~^:
;;                                 7YYYYYYYJJJJJJJ??7!!7777777777!!~~:
;;             .:.                .!?????JJ??????77!!7777!!!!!!!~^:.
;;                                     ..?7....::..:::::::::::^:.
;;                                       !!
;;                                       !7                                   .
;;                                       !7                                  .:.
;;                                       !7
;;                                       !7
;;             ..                ..      !7
;;             ..                ..      !7
;;                                       !7
;;                                       !7
;;    .:                                 !7.               .:.
;;    ..                               .:?J:                .
;;                                .....:^^!~:.....
;;

;; The present module is an introduction to Qi.
;; The exercises/ folder contains exercises to hone your skills
;; after you've gone through the tutorial.

;; General tips worth remembering are highlighted using the 👉 symbol.
;; Just read through the file and evaluate each example, and experiment
;; on your own to confirm your understanding and build fluency. Don't
;; hesitate to make notes right in the file – these notes will be a
;; record of your learning process and can serve as a useful reference
;; for you later.  If you haven't already, make sure you read the tips in
;; the README on optimizing the learning experience for your editor of
;; choice.
;;
;; Have fun!

;;;; INTRODUCTION TO QI

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

;; ... where underscores can be used to indicate argument positions.
((☯ (string-append "a" _ "c")) "b")

;; You can use flows anywhere that you would normally use a function
;; (since flows are just functions). As an example, if you wanted to
;; double every element in a list of numbers, you could use:
(map (☯ (* 2)) (range 10))

;; ... rather than use currying:
(require racket/function)
(map (curry * 2) (range 10))

;; ... or the naive approach using a lambda:
(map (λ (v) (* v 2)) (range 10))

;; 👉 Flows are often more clear than using currying, and can also be
;; preferable to using a lambda in many cases.

;; Literals are interpreted as flows generating them.
((☯ "hello"))

;; More generally, you can generate the result of any Racket expression
;; as a flow by using `gen` (short for generate or "genesis" - to create
;; or produce):
((☯ (gen (+ 3 5))))

;; Flows like these that simply generate values always disregard any
;; inputs you pass in.
((☯ "hello") 3)
((☯ (gen (+ 3 5))) "a" "b" 'hi 1 2 3)

;; 👉 `gen` is a common way to incorporate any Racket expression into a
;; flow.

;; When an underscore is used as a flow (rather than in an argument
;; position, as above), it is the "identity" flow, which simply passes
;; its inputs through, unchanged.
((☯ _) 3 4 5)

;; Sometimes, it's useful to give flows a name, so that we can use them
;; with different inputs in different cases. As flows evaluate to
;; ordinary functions, we can name them the same way as any other
;; function.
(define double (☯ (* 2)))
(double 5)

;; But Qi also provides a dedicated flow definition form so you can be
;; more explicit that you are defining a flow, and then you don't need to
;; use ☯.
(define-flow also-double (* 2))
(also-double 5)

;; Values can be "threaded" through multiple flows in sequence.
((☯ (~> sqr add1)) 3)

;; More than one value can flow.
((☯ (~> + sqr add1)) 3 5)

;; In Racket, if we wanted to evaluate an expression in terms of some
;; inputs, we could wrap the expression in a lambda and immediately apply
;; it to those input arguments:
((λ (x y)
   (add1 (sqr (+ x y))))
 3 5)

;; But usually, we'd just use the more convenient `let` form to do the
;; same thing:
(let ([x 3] [y 5])
  (add1 (sqr (+ x y))))

;; Qi provides an analogous form, `on`, which allows you to apply a flow
;; immediately to inputs.
(on (3 5)
  (~> + sqr add1))

;; Very often, the kind of flow that we want to apply immediately to
;; inputs is a sequential one, i.e. a "threading" flow. So Qi provides an
;; even more convenient shorthand for this common case.
(~> (3 5) + sqr add1)

;; ... which is similar to the widely used "threading macro," but is a
;; more general version as it has access to all of Qi.

;; Flows may divide values.
((☯ (-< add1 sub1)) 3)
((☯ (-< + -)) 3 5)

;; This -< form is called a "tee junction," named after a common pipe
;; fitting used in plumbing to divide a flow down two pipes.
;; It is also, of course, a Unix utility that performs a similar function
;; for the input and output of Operating System processes.

;; Flows may channel values through flows in parallel.
((☯ (== add1 sub1)) 3 7)

;; The `==` form is called a "relay." Think of it as a "relay race" where
;; the values flow along parallel tracks. "Relay" is also a radio device
;; that retransmits an input signal.

;; You could also pass all input values independently through a common
;; flow.
((☯ (>< sqr)) 3 4 5)

;; This `><` form is called an "amp," analogous to "map" for lists, and
;; also as it can be thought of as transforming or "amplifying" the
;; inputs under some flow.

;; 👉 Flows compose naturally, so that the entire Qi language is
;; available to describe each flow when used within another flow.

(☯ (~> (-< sqr (* 2) 1) +))

;; What do you think this flow computes? Take a minute to study it, see
;; if you can work it out.

;; First, we see that the flow divides the input value down three flows
;; that each transform the input in some way. The parallel outputs of
;; these three flows are then fed into the addition flow, so that these
;; results are added together.  Note that the third branch in the tee
;; junction is just the literal value, 1.  Since it is a literal, it is
;; interpreted (as we saw earlier) as a flow that generates that literal
;; value, regardless of any inputs. So, the first two branches of the tee
;; junction square and double the input, respectively, while the third
;; branch simply outputs the constant value, 1.  Putting it all together,
;; this flow computes the formula x² + 2x + 1.  Let's apply it to an
;; input using the threading shorthand:
(~> (3) (-< sqr (* 2) 1) +)

;; The equivalent Racket expression is:
(let ([x 3]) (+ (sqr x) (* x 2) 1))

;; Why would we favor the Qi version here? Well, we wouldn't necessarily,
;; but it has a few advantages: it doesn't mention the input value at
;; all, while the Racket version mentions it 3 times. It's shorter. And
;; most importantly, it encodes more information about the computation
;; syntactically than the Racket version does. In what way? See, with the
;; Racket version, you don't know what the expression is about to do with
;; the input value.  It might transform it, or it might condition on it,
;; or it might disregard it altogether. You need to _read_ the entire
;; expression to determine the type of computation. With the Qi version,
;; you can see that it is a transformation just by looking.

;; Since we often work with lists in Racket, whereas we usually work with
;; values in Qi, it is sometimes useful to separate an input list into
;; its component values using a "prism."
((☯ (~> △ +)) (list 1 2 3))

;; ... or constitute a list out of values using an "upside-down prism."
((☯ (~> (>< sqr) ▽)) 1 2 3)

;; ... in analogy with the effect that prisms have on light -- separating
;; white light into its component colors, and reconstituting them back
;; into white light. Like this:
((☯ (~> △ ▽)) (list 1 2 3))

;; You can also swap the prisms the get an identity transformation on
;; values, instead.
((☯ (~> ▽ △)) 1 2 3)

;; Note that this isn't exactly like the behavior with light, since with
;; light, if you swapped the prisms their effect would be the same as
;; before. There's no such thing as an "upside down" prism in an absolute
;; sense with light -- the second one is "upside down" only in relation
;; to the initial prism, and swapping the order of the prisms doesn't
;; change this aspect. The same prism may separate or combine light, just
;; depending on where it is in the sequence.

;; With Qi prisms, though, △ and ▽ are different forms that do different
;; things.  △ separates, and ▽ collects. Therefore, they have a different
;; effect when swapped, and, for instance, this would be an error:

;; ((☯ (~> △ ▽)) 1 2 3)

;; ... because △ cannot "separate" what is already separated - it expects
;; a single input list.

;; 👉 △ and ▽ often allow you to avoid using `list` and `apply`.

;; For instance:
(~>> ((list 3 4 5)) (map sqr) (apply +))

;; This flow computes the sum of the squares of three values. We use map
;; and apply here because the input happens to be in the form of a list.
;; Instead, we could use a prism to separate the list into its component
;; values, allowing us to use the flows on values directly:
(~> ((list 3 4 5)) △ (>< sqr) +)

;; One way to think about flows is that they are a way to compose
;; functions in complex ways. One type of function that we compose often
;; is a _predicate_, that is, a boolean-valued function that answers a
;; question about its inputs.

;; Predicates can be composed by using and, or, and not.
(on (27)
  (and positive?
       integer?
       (~> (remainder 3) (= 0))))

;; This answers whether the input is a positive integer divisible by 3,
;; which, in this case, it is.

;; 👉 As with any flow, we can give this one a name. In practice, this is
;; an elegant way to define predicates.
(define-flow threeish?
  (and positive?
       integer?
       (~> (remainder 3) (= 0))))

(threeish? 27)
(threeish? 32)

;; We often use predicates in conditional expressions such as `if` or
;; `cond`.  Since this pattern is so common, Qi provides a dedicated
;; conditional form called `switch` which allows you to use flows as your
;; conditions as well as the transformations to perform on the inputs if
;; the conditions hold.  This form is useful in cases where the result of
;; the conditional expression is a function of its inputs.  This is a
;; very common case. Take a moment to scan through a favorite Racket
;; project you worked on. Look for `cond` expressions where every
;; condition answers a question about the same value or same set of
;; values.  Every one of these cases (and more) are cases where you
;; needed switch but didn't have it. Well, now you do!  Let's look at
;; what it does.

;; `switch` looks a lot like `cond`, except that every one of its
;; condition and consequent clauses is a flow. These flows typically all
;; receive the same inputs – the original inputs to the switch
;; expression.
(switch (3)
  [positive? add1]
  [negative? sub1]
  [else _])

;; Let's try this with a few different inputs. Instead of writing it from
;; scratch each time, let's give this flow a name. As we saw earlier, we
;; could do this in the usual way with define:
(define amplify
  (☯ (switch [positive? add1]
             [negative? sub1]
             [else _])))

;; ... which also reveals how the switch form is just like ~> in that it
;; is just a form of the Qi language. Since it represents another common
;; case, Qi provides a shorthand `switch` form that you can use at the
;; Racket level alongside forms like `cond`, without having to enter Qi
;; via ☯.

;; That's one way to give this flow a name. Another way is to use the
;; dedicated define-switch form provided by Qi, which is more explicit:
(define-switch amplify-too
  [positive? add1]
  [negative? sub1]
  [else _])

(amplify 3)
(amplify -3)
(amplify 0)

;; As flows accept any number of input values, the predicates we define
;; and use (for instance with switch) can operate on multiple values as
;; well. The following flow computes the absolute difference between two
;; input values:
(define-values (a b) (values 3 5))

(switch (a b)
  [> -]
  [< (~> X -)])

;; The X or "crossover" form used here reverses the order of the inputs,
;; and ensures that the larger argument is passed to the subtract
;; operation in the first position.

;; Finally, we can end flows by using the `ground` form.
((☯ ⏚) 3 4 5)

;; This produces no values at all, and is useful in complex flows where
;; we may wish to end certain branches of the flow based on predicates
;; or some other criteria. As an example, the following flow sums all
;; input numbers that are greater than 3.
((☯ (~> (>< (if (> 3) _ ⏚))
        +)) 1 3 5 2 7)

;; ... which uses a flow version of `if` where the condition, consequent,
;; and alternative expressions are all flows operating on the inputs. We
;; could use a switch too, of course, but `if` is simpler here. As is the
;; case with any complex language, there are many ways of saying the same
;; thing in Qi. In this particular case, as it happens, Qi has a more
;; convenient shorthand, @racket[pass], which only allows values through
;; that meet some criterion.
((☯ (~> (pass (> 3)) +)) 1 3 5 2 7)

;; We've now learned about the ☯, on, ~>, and switch forms, which are
;; ways to enter the Qi language. We've learned many of the forms of the
;; Qi language and how they allow us to describe computations in terms of
;; complex flows that direct multiple values through bifurcating and
;; recombining sequences of transformations to arrive at the result.

;; We've also learned that we can give names to flows via `define-flow`,
;; and `define-switch`.

;; Qi provides lots of other forms that allow you to express flows
;; conveniently and elegantly in different contexts.

;;;; NEXT STEPS

;; To practice your skills and gain fluency with the language, try your
;; hand at some of the exercises in the exercises/ folder. You can survey
;; the available exercises and topics covered by starting at:
;;
;;    exercises/start.rkt
;;
;; Find complete docs at:
;;
;;    https://docs.racket-lang.org/qi/index.html
;;
;; Participate and contribute at the source repo:
;;
;;    https://github.com/countvajhula/qi
;;
;; And just go with the flow! 🤙
