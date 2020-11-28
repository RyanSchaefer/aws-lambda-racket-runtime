#!/usr/bin/env racket
#lang racket
(require aws)
(credentials-from-environment!)

(define module (make-parameter ""))
(define function (make-parameter ""))
(define event (make-parameter "{}"))


(define parser
  (command-line
   #:usage-help
   "takes in another module and wraps that module in a command line interface"
   "so it can be used with lambda"

   #:once-each
   [("-m" "--module") MODULE
    "the module to require in order to allow the calling of the function"
    (module MODULE)]
   [("-f" "--function") FUNCTION
    "the function to call to handle event, context pair"
    (function (string->symbol FUNCTION))]
   [("-e" "--event") EVENT
    "the event to call the function with"
     (event EVENT)]

   #:args () (void)))


(writeln ((dynamic-require (module) (function)) (event)))