# Racket Runtime

---

A runtime environment enabling racket code to be run through AWS lambda. This version supports
multiple versions of racket as well as errors. This is accomplished with a program which handles
the dynamic import of a function from a module in racket. This implementation has been tested with
aws SAM and racket version  7.9.

## Requirements

---
1. Docker
2. AWS SAM CLI

## Tutorial

---

1. A simple program requires the follow files in the base directory: 
   1. `Makefile` aws uses this to define how custom runtimes are built
   2. `Dockerfile` defines the executable build container, you can change racket version here
   3. `wrapper.rkt` handles importing the correct function and calling it with the event 
   4. Optional:
      1. An `info.rkt` is encouraged  to ensure all dependencies are correctly installed
2. Write a sam template defining your function (an example is provided)
3. Call `sam build [function name]` or `sam build` to build all defined functions
4. (Optional) To test call `echo "{event here}" | sam local invoke -e-`
5. When ready to deploy call `sam deploy`

## Caveats

---

1. Performance is currently ~800ms for the example cat program
2. This has only been tested with racket 7.9 