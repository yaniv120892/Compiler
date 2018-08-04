 ((lambda (x)
   (lambda (y)
     x))
  (lambda (x)
    ((x #t) #f)))

; (((((lambda (x) (x (x x)))
    ; (lambda (x)
      ; (lambda (y)
; (x (x y)))))
   ; (lambda (p)
     ; (p (lambda (x)
 ; (lambda (y)
   ; (lambda (z)
     ; ((z y) x)))))))




;; (((lambda x (lambda y y)) 1 2 3)  8)
;; (((lambda x (lambda y x)) 1 2 3)  8)
;; 
;;  (((lambda x (lambda y y)) 1)  8)
;;   (((lambda x (lambda y x)) 1)  8)
;;   ((lambda (x . y) y) 1 2 3 4 5)
;;      (((lambda (x) (lambda (y) x))1 )6)
;; ;;   
;; ;;   
;;       ((lambda (x) x) '(1))
;;     (((lambda (x y) (lambda (a) y)) 1 2) 6)
;; ;;  
;; ;;  
;;    (((lambda x (lambda (a b) x)) 1 ) 6 7 )
;; ;;  
;; ;;  
;;    (((lambda(a) (lambda (b) a)) '(1 2 3)) '(4 5 6))
;; ;;   
;; ;;   
;; ;;   
;;    ((lambda (x.y) y) 1 2 3 4 5 6 7)
;;   (- 1 2)
;;   (- 1/2 -1/3 1/4 -1/5)
;;   (/ 1 2 3)
;;   #(1 2 3)
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;;    (list)
;; ;; 
;; ;; 
;; ;; 
;; ;;  
;;   (list 1 2 3 4 5 6 7)
;; ;;  
;; ;; (- 1 2)
;; ;; ;;  (- 1)
;; ;; 
;; ;;  (* 1 7 2)
;; ;;  (zero? 0)
;; ;; 
;; ;; 
;; ;; 
;; ;;  (- 1 7)
;;  
;;  
;;   (- 5 (+ 1 2 2))
;;   (zero? (- 5 (+ 1 2 2)))
;;  
;;  
;;  
;;  
;;        (((lambda(a b)
;;           (lambda(w m n) n )) 1 2) 5 6 7)
;;          
;;      (((lambda(a b c d)
;;          (lambda(w m n) n )) 1 2 3 4) 5 6 7)
;; ;;        
;;        
;;    
;;     (((lambda(a b c d e)
;;        (lambda(w m n) n )) 1 2 3 4 5) 5 6 7)
;;       
;;   
;;       
;;    (((lambda (p1 p2)
;;                (lambda(func)
;;                        (func p2))) 1 2)(lambda(x) x))
;;       
;;       
;;       
;;     (((lambda (  x y z w m f )
;;                  (lambda(func)
;;                          func))
;;                  1 2 3 4 5 6)
;;                  (lambda(x) x))  
;;                 
;;   (((lambda(a b c d)
;;       (lambda(y)
;;           (b y))) 1 (lambda(z) z) 3 4) 2)
;;   
;;   
;;   
;;   
;;   (let ((y 1) (x 2))
;;   	 (let ((x 3))
;;   		 (let ((x 4) (w 5) (z 6))
;;  			 y)))
;;                 
;;                 
;;    (let ((x 1) (y 2))
;;   	 (let ((x 3))
;;   		 (let ((x 4) (w 5) (z 7))
;;   			 (let ((x 8) (z 9))
;;   				 y))))
;;                  
;;    (apply list '(1 2 3 4 5))
;;    
;;    
;;       (((lambda ( x y z w m f )
;;                  (lambda(func)
;;                          (func x y z w m f)))
;;                  1 2 3 4 5 6)
;;                  list) 
;;    
;;      ((apply (lambda (  x y z w m f )
;;                  (lambda(func)
;;                          (func x y z w m f)))
;;                  '(1 2 3 4 5 6))
;;                  list)
;;                  
;;    (define test
;;      (let ((p1 (lambda (x1 x2 x3 x4 x5 x6 x7 x8 x9 x10)
;;         (lambda (z)
;;    (z x2 x3 x4 x5 x6 x7 x8 x9 x10 x1))))
;;    (s '(a b c d e f g h i j)))
;;        (lambda ()
;;          (((((((((((apply p1 s) p1) p1) p1) p1) p1) p1) p1) p1) p1)
;;          list))))
;;    
;;    (test)
;; 
;; 
;; 
;; 
;; 
;; ;; ;word
;; ;;  ((apply (lambda (p1)
;; ;;              (lambda(func)
;; ;;                      (func p1)))
;; ;;              '(1))
;; ;;              list)
;; ;; 
;; ;; 					
;; ;;  (apply / '(1 2 3 4 5 6))
;; ;; 					
;; ;; 			
;; ;; 				
;; ;;  (((lambda(f1)
;; ;; 	 (f1 1)) (lambda(f2) (f2 7))) (lambda(x) x))
;; ;;    
;; ;;    
;; ;; ; ;Work   
;; ;;  ((apply (lambda (  x )
;; ;;              (lambda(func)
;; ;;                      func))
;; ;;              '(1 ))
;; ;;              (lambda(x) x))
;; ; ;Work
;; ; (apply (lambda (  x y )
;;             ; (lambda(func)
;;                     ; func))
;;             ; '(1 2))
;; 			
;; 			
;; 			
;; ;; ;Work
;; ;; ((apply (lambda (  x y z )
;; ;;             (lambda(func)
;; ;;                     func))
;; ;;             '(1 2 3 ))
;; ;;             (lambda(x) x))
;; ;;             
;; ;; ;Work
;; ;; ((lambda x x) 1 2 3 4)
;; ;; 
;; ;;             
;; ;;             
;; ;; (((lambda (  x y z w m f )
;; ;;             (lambda(func)
;; ;;                     func))
;; ;;             1 2 3 4 5 6)
;; ;;             (lambda(x) x))
;; ;;             
;; ;;             
;; ;;             
;; ;; ((apply (lambda (  x y z w m f )
;; ;;             (lambda(func)
;; ;;                     func))
;; ;;             '(1 2 3 4 5 6))
;; ;;             (lambda(x) x))
;; 
;; 
;; 
;; 
;; ;; ;;;;file 01
;; ;; 
;; ;; (letrec ((fact-1
;; ;;  (lambda (n)
;; ;;    (if (zero? n)
;; ;; 1
;; ;; (* n (fact-2 (- n 1))))))
;; ;; (fact-2
;; ;;  (lambda (n)
;; ;;    (if (zero? n)
;; ;; 1
;; ;; (* n (fact-3 (- n 1))))))
;; ;; (fact-3
;; ;;  (lambda (n)
;; ;;    (if (zero? n)
;; ;; 1
;; ;; (* n (fact-4 (- n 1))))))
;; ;; (fact-4
;; ;;  (lambda (n)
;; ;;    (if (zero? n)
;; ;; 1
;; ;; 
;; ;; (* n (fact-1 (- n 1)))))))
;; ;;   (fact-1 10))
;; ;; 
;; ;; 
;; ;; 
;; ;; ;; (/ 1 -12)
;; ;; (eq? (string->symbol (make-string 1 #\a)) 'a)        ; strings should be comparisoned deeply when examining the symbol's string representation
;; 
;; ;; (vector-length '#())                        ; 0
;; ;; (number? #t)   
;; ;; (make-vector 0)
;; ;; 
;; ;; 
;; ;; 
;; ;; (make-string 3)                             ; "\000;\000;\000;"
;; ;; (/ 1 -2)
;; 
;; 
;; 
;; ;; #t
;; ;; #f
;; ;; '()
;; ;; 
;; ;; 'a
;; ;; "aaaa"
;; ;; (symbol->string 'abcd)
;; ;; (symbol->string 'abc)
;; ;; (string->symbol "adddd")
;; ;; 
;; ;; 
;; ;; (apply + '(1 2 3 4 5 6 7))
;; ;; 
;; ;; 
;; ;; "\t"
;; ;; #\x666
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;; ;; 
;; ;;  (map (lambda(x) (+ 1 x)) '(1))
;; ;; 
;; ;;  ((((lambda(a b)(lambda(c)(lambda(d e) b))) 1 2 ) 3) 4 5)
;; ;;  -1
;; ;; "abcvbdfgdf"
;; ;;  (string->symbol "abcd")
;; ;;  (string-set! "abcd" 3 #\Y)
;; ;;  (symbol->string 'abcd)
;; ;;  (string->symbol "ccccc")
;; ;;  (string->symbol (make-string 5 #\c))
;; ;;  (define id 
;; ;;       (lambda (x)
;; ;;           (if x
;; ;;               1 
;; ;;               (id #t))))
;; ;;  (id #f)
;; ;; (id 10)
;; ;;  
;; ;; 'abcd
;; ;; 
;; ;;  (define id (lambda(x y)
;; ;;              (if x  y (id #t 2))))
;; ;;      
;; ;;      
;; ;;  (id #f 1)
;; ;;  
;; ;;  (+ 1 2 3 4)
;; ;;  
;; ;;  (apply / '(1 2 3 4))
;; ;;           
;; ;;           
;; ;;           
;; ;; (if #t 1 2)
;; ;;  (string-ref "abc" 2)
;; ;;  (eq? #t ((lambda() (number? 5))))
;; ;; id			 
;; ;;   ((lambda(a)
;; ;;      	(lambda(x)
;; ;;                a) 100) 15)
;; ;; 
;; ;;    (((lambda(x)
;; ;;        (lambda (y)
;; ;;            x)) 10)
;; ;;            5)
;; ;; 
;; ;; 
;; ;; (((lambda (a) 
;; ;; (lambda (b)
;; ;;               (set! a 10)
;; ;;             a)) 22) 55)
;; ;; (list_length '(1 2))
;; ;; (list_length '(1 2))
;; ;;             
;; ;;  (define a 
;; ;;     (lambda (a b) (begin a (set! a b) (lambda () a) (lambda (a b) (+ a b)))))
;; ;; ; ((a 1 2) 3 4)
;;   ;(id 7)
;; ;;
;;    (map + '(1 2 3) '(1 2 3))


    
  









