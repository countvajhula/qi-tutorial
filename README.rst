qi-tutorial
===========
An interactive tutorial for the `Qi language <https://docs.racket-lang.org/qi/index.html>`_. This can also serve as a starting point for an application using Qi.

Installation
~~~~~~~~~~~~

::

   raco new qi-tutorial

You will need `Racket Templates <https://github.com/racket-templates/racket-templates>`_. To install it:

::

   raco pkg install from-template

Usage
~~~~~

This tutorial is structured as a set of Racket modules. Just open the ``start.rkt`` module in your favorite editor to get started. Go through the tutorial by reading through the comments, and evaluating each expression as you go. If it works and you think you understand it, try variations and experiments at each stage to gain fluency. Don't hesitate to write code and notes right in the module -- these track your learning and can be useful to refer to later. Remember that writing isn't just a way to express your thoughts, it's also a way to learn. So, go wild!

The tutorial is an evolving work, and more exercises and topics will be added over time. Pull requests are welcome.

DrRacket
--------

You can't evaluate individual expressions on demand out of the box with DrRacket, but there's a Quickscript that'll allow you to do that. `Quickscripts <https://docs.racket-lang.org/quickscript/index.html>`_ are the standard means of extending DrRacket functionality, and the package is already included in recent DrRacket distributions. You just need to install the interaction script, for which these are the steps:

1. Install `Quickscript-extra <https://docs.racket-lang.org/quickscript/index.html#%28part._.Installing_scripts__.Quickscript_.Extra%29>`_, which contains useful scripts and tools, one of which we will need.

    ::

      raco pkg install quickscript-extra

2. Use the included url2script tool to install the ``select-send-sexpr`` quickscript. This script allows you to select and evaluate expressions on demand in a context-sensitive way.

   1. First, copy the link to the `select-send-sexpr <https://gist.github.com/Metaxal/9f313c17269f9cbcc95f614385309fb8>`_ script (e.g. by right-clicking on it)

   2. Paste it into this dropdown in DrRacket:

      Scripts → url2script → Fetch script...

   3. You may need to Scripts → Manage → Compile scripts before the script will take effect.

And that's it! You should now be able to use ``Control-Shift-Enter`` to evaluate expressions as you go through the tutorial. The script also provides other features, including ``Control-Enter`` to select the current expression in case you need to copy it. These keybindings are customizable.

Emacs/Vim
---------

Just open the file ``start.rkt``, and read through it! The tutorial takes the form of comments interspersed with runnable examples, and you should evaluate each expression by sending it to the REPL. E.g. in `Racket Mode <https://www.racket-mode.com/>`_, you might use ``C-x C-e`` to do this.

Using Symex.el
``````````````
For Emacs users, I recommend using `Symex <https://github.com/countvajhula/symex.el>`_ (which interfaces with Racket Mode) if you are at all open to using modal editing. Full disclosure: I'm the author. But I originally wrote it precisely because I wanted a more convenient way to evaluate expressions and components of expressions while learning Lisp, making it a great fit to support this interactive style of learning. To give you an idea -- with single keystrokes, you can move back and forth and in and out of expressions and can always evaluate the indicated (sub)expression using ``e``.

Symex isn't in any way necessary to using this tutorial, and if you already have a convenient way to evaluate expressions interactively, then that's all you need!

"License":
==========
This work is "part of the world." You are free to do whatever you like with it and it isn't owned by anybody, not even the creators. Attribution would be appreciated and would help, but it is not strictly necessary nor required. If you'd like to learn more about this way of doing things and how it could lead to a peaceful, efficient, and creative world (and how you can be involved), visit `drym.org <https://drym.org>`_.
