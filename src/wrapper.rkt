#!/usr/bin/env racket
#lang racket
(require aws)
(require net/head)
(require net/http-client)

(define module (make-parameter ""))
(define function (make-parameter ""))
(define event (make-parameter "\r\n\r\n"))


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


(define request-id (extract-field "Lambda-Runtime-Aws-Request-Id" (event)))
(define timeout-epoch (extract-field "Lambda-Runtime-Deadline-Ms" (event)))

(define (wrap-handler)
  (with-handlers ([exn:fail? (lambda (exn)
                               (displayln (exn-message exn))
                               #f)])
    (define response ((dynamic-require (module) (function)) (event)))
    (define host-port (string-split (getenv "AWS_LAMBDA_RUNTIME_API") ":"))
    (writeln response)
    (http-sendrecv
     (first host-port)
     (string-append "/2018-06-01/runtime/invocation/" request-id "/response")
     #:method 'POST
     #:data "SUCCESS"
     #:port (string->number (second host-port)))))

(define (main)
  (wrap-handler)
  (void))
(main)