;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; Programmer: Kevin Rosenberg


(in-package #:cl-user)
(defpackage #:b9-puri-system (:use #:cl #:asdf))
(in-package #:b9-puri-system)


(defsystem b9-puri
  :name "cl-b9-puri"
  :maintainer "Kevin M. Rosenberg <kmr@debian.org>"
  :licence "GNU Lesser General Public License"
  :description "Portable Universal Resource Indentifier Library"
  :components
  ((:file "src")))

(defmethod perform ((o test-op) (c (eql (find-system 'b9-puri))))
  (oos 'load-op 'b9-puri-tests)
  (oos 'test-op 'b9-puri-tests))

(defsystem b9-puri-tests
    :depends-on (:b9-puri :ptester) 
    :components
    ((:file "tests")))

(defmethod perform ((o test-op) (c (eql (find-system 'b9-puri-tests))))
  (or (funcall (intern (symbol-name '#:do-tests)
		       (find-package :b9-puri-tests)))
      (error "test-op failed")))

(defmethod operation-done-p ((o test-op) (c (eql (find-system 'b9-puri-tests))))
  (values nil))
