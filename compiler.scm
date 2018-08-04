(load "sexpr-parser.scm")
(load "tag-parser.scm")
(load "semantic-analyzer.scm")

(define library-functions 
'(void? null? integer? boolean? fraction? char? string? symbol? procedure? pair? vector? 
eq? car cdr cons integer->char char->integer 
+ yaniv_plus - * yaniv_mult / yaniv_div > yaniv_greater < yaniv_smaller = yaniv_equivalent remainder
string-length  vector-length 
string-ref
vector-ref
make-string
make-vector
vector
string-set!
vector-set!
symbol->string
string->symbol
apply
))


(define error-label "ERORR_HAPPEND")
(define constants-table 'Yaniv)
(define symbols-table 'Yaniv)
(define global-variables-table 'Yaniv)
(define sobCounter 0)
(define ifCounter 0)
(define orCounter 0)
(define forCounter 0)
(define lambdaBodyCounter 0)
(define lambdaClosureCounter 0)
(define Counter 0)
(define EnviromentCounter 0)
(define CreateListCounter 0)
(define CoptFrameCounter 0)
(define initFuncCounter 0)
(define printCounter 0)
(define fvarCounter 0)
(define symbolCounter 0)


(define get-and-increase-counter 
    (lambda (counter-name)
        (cond
            ((equal? counter-name "if")
                (set! ifCounter (+ 1 ifCounter))
                (number->string ifCounter))
            ((equal? counter-name "or")
                (set! orCounter (+ 1 orCounter))
                (number->string orCounter))
            ((equal? counter-name "lambda-simple")
                (set! lambdaBodyCounter (+ 1 lambdaBodyCounter))
                (number->string lambdaBodyCounter))
            ((equal? counter-name "for")
                (set! forCounter (+ 1 forCounter))
                (number->string forCounter))
            ((equal? counter-name "lambda-closure")
                (set! lambdaClosureCounter (+ 1 lambdaClosureCounter))
                (number->string lambdaClosureCounter))
            ((equal? counter-name "lambda-body")
                (set! lambdaBodyCounter (+ 1 lambdaBodyCounter))
                (number->string lambdaBodyCounter))
            ((equal? counter-name "env")
                (set! EnviromentCounter (+ 1 EnviromentCounter))
                (number->string EnviromentCounter))
            ((equal? counter-name "create-list")
                (set! CreateListCounter (+ 1 CreateListCounter))
                (number->string CreateListCounter))
            ((equal? counter-name "copy-frame")
                (set! CoptFrameCounter (+ 1 CoptFrameCounter))
                (number->string CoptFrameCounter))
            ((equal? counter-name "init-func")
                (set! initFuncCounter (+ 1 initFuncCounter))
                (number->string initFuncCounter))
            ((equal? counter-name "print-counter")
                (set! printCounter (+ 1 printCounter))
                (number->string printCounter))
            ((equal? counter-name "fvar-counter")
                (set! fvarCounter (+ 1 fvarCounter))
                (number->string fvarCounter))
            ((equal? counter-name "symbol-counter")
                (set! symbolCounter (+ 1 symbolCounter))
                (number->string symbolCounter))
            (else
                (display-with-newline 'get-and-increase-counter 'counter-doesnt-exists)))))





;Work
(define create-symbol-table
	(lambda (all-constants)
		(filter (lambda(x)
			(symbol? (car (cdr x))))
		all-constants)
	)
)		

;Work
(define create-constant-table
	(lambda (parsed-scheme)
            
	    (let* ((const-after-remove-brackets (remove-const-nested-brackets (map   
                                                                            (lambda(sexpr)
                                                                                (let ((ans (get-all-consts-from-scheme sexpr '() )))
                                                                                         ;(display-with-newline 'ans______________ ans)                   
                                                                                ans))
                                                                            parsed-scheme) '()))
              (symbols (filter (lambda (y)
                                    (symbol? (car (cdr y))))
                                const-after-remove-brackets))
              (after-adding-string-to-symbols `(,@(map (lambda (x)
                                                                                        `(const ,(symbol->string (car (cdr x)))))
                                                                                    symbols)
                                                                                    ,@const-after-remove-brackets))                                                                   
              (const-after-add-default (add-default-constants after-adding-string-to-symbols))
              (const-after-add-fraction-parts (add-fraction-parts const-after-add-default))
			  (all-constants (remove-duplicate const-after-add-fraction-parts)))
				all-constants
		)
	)
)
				

				
			  
(define add-fraction-parts
    (lambda(lst)
            (if (null? lst)
                lst
                (let ((num (car (cdr (car lst)))))
                            (if (and (not (integer?  num)) (rational? num))
                                (let* ((upper-value (numerator num))
                                     (lower-value (denominator num))
                                     (ans `(,`(const ,upper-value) ,`(const ,lower-value) ,(car lst) ,@(add-fraction-parts (cdr lst)))))
                                        ans)
                        `(,(car lst) ,@(add-fraction-parts (cdr lst))))))))
        

;Work		  
(define create-fvar-table
    (lambda (parsed-scheme)
        (let* (
                (fvar-after-remove-brackets 
                    (remove-fvar-nested-brackets (map   
                                                    (lambda(sexpr)
                                                        (let ((ans (get-all-fvars-from-scheme sexpr '() )))
                                                            ans))
                                                    parsed-scheme) '()))
                (all-fvars (remove-duplicate fvar-after-remove-brackets))
                (fixed-all-fvars (remove-library-fvars all-fvars)))
                    fixed-all-fvars
        )
    )
)







;Work
(define lookup-table 
	(lambda (table exp)
            ;(display-with-newline 'lookup-item-in-table_exp::: exp)
		(if (null? table) 
                    "ERROR in lookup-table"  
                    (if (equal? (car (cdr (car (car table)))) exp)
                            (caar table) 
                            (lookup-table (cdr table) exp)
                    )
                )
        )
)
	
	
	
	
	
;input:table and the value of a const item (for example the char d)
;output:((const d) (T_CHAR 83) (sobChard))
;Work
(define lookup-item-in-table 
	(lambda (table exp)
            ;(display-with-newline 'lookup-item-in-table_exp::: exp)
            ;(display-with-newline 'lookup-item-in-table_TABLE::: table)
		(if (null? table) 
                    "ERROR in lookup-item-in-table"  
                    
                    
;;                     (begin 
;;                         
;;                         (display-with-newline 'val1: (car (cdr (car (car table)))))
;;                         (display-with-newline 'val2: exp)
;;                         (display-with-newline 'val1-is-symbol?: (symbol? (car (cdr (car (car table))))))
;;                         (display-with-newline 'val2-is-symbol?: (symbol? exp))
;;                         (display-with-newline 'is-equal? (equal? (car (cdr (car (car table)))) exp))
;;                         (display-with-newline 'is-eq? (eq? (car (cdr (car (car table)))) exp))
                    
                    
                    (if (equal? (car (cdr (car (car table)))) exp)
                            (car table) 
                            (lookup-item-in-table (cdr table) exp)
                    )
                    
                    ;)
                    
                    
                    
                    
                )
        )
)
	




       
;Work      
(define remove-duplicate 
    (lambda (e)
        (if (null? e) '()
            (cons (car e) (remove-duplicate (filter (lambda (x) (not (equal? x (car e)))) 
                (cdr e)))))))
 
;Work 
(define add-default-constants
    (lambda (lst)
        `(,`(const ,(void)) ,`(const ()) ,`(const #t) ,`(const #f) ,@lst)))
 

;Work	
(define file->string_
    (lambda (in-file)
        (let ((in-port (open-input-file in-file)))
            (letrec ((run
                (lambda ()
                    (let ((ch (read-char in-port)))
                        (if (eof-object? ch)
                            (begin
                                (close-input-port in-port)
                                '())
                        (cons ch (run)))))))
        (run)))))
		
		
		

		
;Work
(define string->file
	(lambda (string file)
		(delete-file file)
		(let ((out-port (open-output-file file)))
			(letrec ((run (lambda (lst)
				(if (null? lst)
					(close-output-port out-port)
					(begin
						(write-char (car lst) out-port)
						(run (cdr lst)))))))
			(run (string->list string))
			))))



                
                
                
 ;Work      
 ;'(1 (2) 3)
(define get-const-sub-pairs 
    (lambda (lst acc)
        (cond 
            ((eq? lst '()) acc)
            ((pair? lst)
                (let (
                (ans `(,@(get-const-sub-pairs (car lst) '()) ,`(const ,(car lst))
                            ,@(get-const-sub-pairs (cdr lst) '())  ,`(const ,(cdr lst)) ,acc)))
                        ans))
            ((vector? lst)
                
                `(,@(map 
                        (lambda (vec-element)
                            (let ((ans (get-const-sub-pairs vec-element `(const ,vec-element))))
                            ans))
                        (vector->list lst))
                ,`(const ,lst)))
            (else
                        acc)
        )
    )
)
               
        
            
            
;Work         
(define get-all-consts-from-scheme
    (lambda(exp acc) 
        (cond
            ((eq? '() exp)
                acc)
            ((is-const? exp)
                (cond 
                    ((pair? (car (cdr exp)))
                        `(,@acc ,@(get-const-sub-pairs (car (cdr exp)) '()) ,exp))
                    ((vector?  (car (cdr exp)))
                        `(,@acc ,@(get-const-sub-pairs (car (cdr exp)) '()) ,exp))
                    (else
                        `(,@acc ,`(const ,(car (cdr exp)))))))
            ((is-var? exp) acc )
            ((is-define? exp) 
                (let ((new-acc `(,@acc ,@(get-all-consts-from-scheme (car(cdr  (cdr exp))) '() ))))
                        new-acc))
                        
            ((is-set? exp) 
                (let ((new-acc `(,@acc ,@(get-all-consts-from-scheme (car(cdr  (cdr exp))) '() ))))
                        new-acc))
            ((is-seq? exp) 
                (let ((new-acc `(,@acc ,@(map (lambda(x) 
                                                (get-all-consts-from-scheme x '()))
                                            (car (cdr exp))))))
                        new-acc))
            ((is-or? exp)
                (let ((or-exp (car (cdr exp))))
                    (let ((new-acc `(,@acc ,@(map (lambda(x) 
                                                (get-all-consts-from-scheme x '()))
                                            or-exp))))
                        new-acc)))       
            ((is-if? exp)
                (let ((test (car (cdr exp)))
                      (ift (car ( cdr (cdr exp))))
                      (iff (car (cdr (cdr  (cdr exp))))))
                        `(,@acc ,@(get-all-consts-from-scheme test '()) ,@(get-all-consts-from-scheme ift '()) ,@(get-all-consts-from-scheme iff '()))))
            ((is-lambda-simple? exp)
                (let ((arguments   (car (cdr exp)))
                      (body (car (cdr (cdr exp)))))
                        `(,@acc  ,@(get-all-consts-from-scheme body '())))) 
            ((is-lambda-opt? exp)
                (let ((arguments   (car (cdr exp)))
                      (last-argument (car (cdr (cdr exp))))
                      (body (car (cdr (cdr (cdr  exp))))))
                        `(,@acc ,@(get-all-consts-from-scheme body '())))) 
            ((is-applic-or-tc-applic? exp)
                `(,@acc ,@(get-all-consts-from-scheme (car (cdr exp)) '())
                                                                            ,@(map 
                                                                            (lambda(x)
                                                                                (let ((curr-ans (get-all-consts-from-scheme x '() )))
                                                                                    curr-ans ))
                                                                            (car (cdr (cdr exp))))))
            ((is-box-get? exp)
                acc)
            ((is-box-set? exp)
                `(,@acc ,@(get-all-consts-from-scheme (car(cdr  (cdr exp))) '() )))
            ((is-box? exp)
                acc)
            (else
                (display 'ERROR-get-all-consts-from-scheme-else)
                (newline))
        )
    )
)


;Work
(define remove-const-nested-brackets
    (lambda (lst acc)
        (cond 
            ((eq? '() lst) acc)
            ((is-const? lst)
                `(,@acc ,lst))
            ((pair? lst)
                `(,@acc ,@(remove-const-nested-brackets (car lst) '()) ,@(remove-const-nested-brackets (cdr lst) '())))
            
            (else
                (display-with-newline 'ERORR!-remove-nested-brackets-in-else_lst lst)
                (display-with-newline 'ERORR!-remove-nested-brackets-in-else_lst acc)))))
 				
				
				
;Work?
(define get-all-fvars-from-scheme
    (lambda(exp acc) 
        ;(display-with-newline 'exp exp)
        (cond
            ((eq? '() exp) acc)
            ((is-const? exp) acc)
            ((is-fvar? exp) `(,@acc ,`(fvar ,(car (cdr exp)))))
            ((is-var? exp) acc )
            ((is-define? exp) 
                (let ((new-acc `(,@acc ,@(get-all-fvars-from-scheme (car (cdr exp)) '()),@(get-all-fvars-from-scheme (car(cdr  (cdr exp))) '() ))))
                        new-acc))
                        
            ((is-set? exp) 
                (let ((new-acc `(,@acc ,@(get-all-fvars-from-scheme (car(cdr exp)) '()) ,@(get-all-fvars-from-scheme (car(cdr  (cdr exp))) '() ))))
                        new-acc))
            ((is-seq? exp) 
                (let ((new-acc `(,@acc ,@(map (lambda(x) 
                                                (get-all-fvars-from-scheme x '()))
                                            (car (cdr exp))))))
                        new-acc))
            ((is-or? exp)
                (let ((or-exp (car (cdr exp))))
                    (let ((new-acc `(,@acc ,@(map (lambda(x) 
                                                (get-all-fvars-from-scheme x '()))
                                            or-exp))))
                        new-acc)))       
            ((is-if? exp)
                (let ((test (car (cdr exp)))
                      (ift (car ( cdr (cdr exp))))
                      (iff (car (cdr (cdr  (cdr exp))))))
                        `(,@acc ,@(get-all-fvars-from-scheme test '()) ,@(get-all-fvars-from-scheme ift '()) ,@(get-all-fvars-from-scheme iff '()))))
            ((is-lambda-simple? exp)
                (let ((arguments   (car (cdr exp)))
                      (body (car (cdr (cdr exp)))))
                        `(,@acc  ,@(get-all-fvars-from-scheme body '())))) 
            ((is-lambda-opt? exp)
                (let ((arguments   (car (cdr exp)))
                      (last-argument (car (cdr (cdr exp))))
                      (body (car (cdr (cdr (cdr  exp))))))
                        `(,@acc ,@(get-all-fvars-from-scheme body '())))) 
            ((is-applic-or-tc-applic? exp)
                `(,@acc ,@(get-all-fvars-from-scheme (car (cdr exp)) '())
                                                                            ,@(map 
                                                                            (lambda(x)
                                                                                (let ((curr-ans (get-all-fvars-from-scheme x '() )))
                                                                                    curr-ans ))
                                                                            (car (cdr (cdr exp))))))
            ((is-box-get? exp)
                acc)
            ((is-box-set? exp)
                `(,@acc ,@(get-all-fvars-from-scheme (car(cdr  (cdr exp))) '() )))
            ((is-box? exp)
                acc)
            (else
                (display 'ERROR-get-all-fvars-from-scheme-else)
                (newline))
        )
    )
)



          
;Work?            
(define remove-fvar-nested-brackets
    (lambda (lst acc)
        (cond 
            ((eq? '() lst) acc)
            ((is-fvar? lst)
                `(,@acc ,lst))
            ((pair? lst)
                `(,@acc ,@(remove-fvar-nested-brackets (car lst) '()) ,@(remove-fvar-nested-brackets (cdr lst) '())))
            
            (else
                (display-with-newline 'ERORR!-remove-fvar-nested-brackets-in-else_lst lst)
                (display-with-newline 'ERORR!-remove-fvar-nested-brackets-in-else_lst acc)))))    

		

		



;input: (fvar a)
;output: ((fvar a) (Free_variable_a))
(define add-fvar-address
    (lambda(fvar-exp)
        (let* ((fvar-name (get-and-increase-counter "fvar-counter"))
               (ans `(,fvar-exp ,(list (apply string-append `("Free_variable_" ,fvar-name))))))
               ans)))
               

;; ;input: ((const a) (T_SYMBOL 0))
;; ;output : (symbol_address string_address)
;; (define add-address-to-symbol
;;     (lambda (sym symbol-address)
;;         (let* (
;;                 (sym-name (car (cdr (car sym))))
;;                 (found-item (lookup-item-in-table constants-table (symbol->string sym-name)))
;;                 (string-address (string->symbol (car (cdr (cdr found-item))))))
;;                 ;(symbol-address  (string->symbol (apply string-append `("sobSymbol_" ,counter))))
;;                 (ans `(,symbol-address ,string-address)))
;;                 ans)
;;     )
;; )


(define add-symbol-to-link-asm
    (lambda(x)
         (let* (
             (symbol-address (car (cdr (cdr x))))
             (string-address (car (cdr x)))
             (add-symbol-to-link 
                 (apply string-append `(
                     "\t" "xor r8, r8" "\n"
                     "\t" "mov r8,[" ,symbol-address "]\n"      
                     "\t" "push r8" "\n"
                     "\t" "call MY_ADD_NODE" "\n"
                     "\t" "pop r8" "\n"
                     "\t" "" "\n"))))
                     add-symbol-to-link
)))
 


 
 (define print-rax
    (lambda()
        (let ((print-counter (get-and-increase-counter "print-counter")))
            (apply string-append `(
                "\t" "PUSH_R8_R15" "\n"
                "\t" "push rax" "\n"
                "\t" "cmp rax,[sobVoid]" "\n"
                "\t" "je DONT_PRINT" ,print-counter "\n"
                "\t" "call write_sob" "\n"
                "\t" "mov rax, 0" "\n"
                "\t" "mov rdi, my_newline" "\n"
                "\t" "call printf" "\n"
                "\t" "DONT_PRINT" ,print-counter ":\n"
                "\t" "pop rax" "\n"
                "\t" "POP_R8_R15" "\n"

        )))))
				
(define get-address-from-constants-table
    (lambda (exp table)
        (let* ((item-from-table (lookup-item-in-table table exp))
               (ans (car (cdr (cdr item-from-table)))))
               ans)
    )
)



;Doesn't Work
(define code-gen
	(lambda (exp major)
            (cond  
                ((is-const? exp) 
                    (apply string-append `("\tmov rax ,[" ,(get-address-from-constants-table (car (cdr exp)) constants-table) "]\n")))
                ((is-fvar? exp) 
                    (let* 
                        ((fvar-name-as-symbol (car (cdr exp)))
                         (item-in-fvar-table (lookup-item-in-table fvars-table fvar-name-as-symbol))
                         (fvar-address (car (car (cdr item-in-fvar-table)))))
                            (apply string-append `("\tmov rax ,[" ,fvar-address "]\n"))))
                ((is-bvar? exp) (let (
                                        (bvar-minor (number->string (car (cdr (cdr (cdr exp))))))
                                        (bvar-major (number->string (car (cdr (cdr exp))))))
                                            (apply string-append `(
                                                "\t" "mov rax,qword[rbp + 8 * 2]" "\n"
                                                "\t" "mov rax,qword[rax + 8 * " ,bvar-major "]\n"  ;;;;; What the shit? need to add 1 to major
                                                "\t" "mov rax,qword[rax + 8 * " ,bvar-minor "]\n"))))
                ((is-pvar? exp) (let (
                                    (pvar-minor (number->string  (car (cdr (cdr exp))))))
                                    (apply string-append `("\t" "mov rax, [rbp +(4+ " ,pvar-minor ") * 8]\n" ; Jump over old rbp,return add,env,num of arguments
                                                        ))))
                ((is-define? exp) 
                    ;(display-with-newline 'define-exp exp)
                                (let* ((fvar-name-as-symbol (car (cdr (car (cdr exp)))))
                                       (value (car (cdr (cdr exp))))
                                       (asm-value (code-gen value major))
                                       (item-in-fvar-table (lookup-item-in-table fvars-table fvar-name-as-symbol))
                                       (fvar-address (car (car (cdr item-in-fvar-table)))))
                                                (apply string-append
                                                    `(,asm-value
                                                    "\t" "mov [" ,fvar-address "],rax" "\n"
                                                    "\t" "mov rax, [sobVoid]" "\n" 
                                                    ))
                                                   
                                                   ))
                ((is-set? exp)  
                    (cond 
                        ((is-pvar? (car (cdr exp)))
                        ;(set! (pvar pvar-name index) pvar-new-value)
                            (let* 
                                ((pvar-name (car (cdr (car (cdr exp)))))
                                 (pvar-index (number->string (car (cdr (cdr (car (cdr exp)))))))
                                 (asm-value (code-gen (car (cdr (cdr exp))) major)))
                                    (apply string-append
                                        `(,asm-value
                                        "\t" "mov qword[rbp + (4+" ,pvar-index ") * 8],rax" "\n"
                                        "\t" "mov rax, [sobVoid]" "\n" 
                                        ))))
                        ((is-bvar? (car (cdr exp)))
                        ;(set! (bvar bvar-name major-index minor-index) bvar-new-value)
                            (let* 
                                ((bvar-name (car (cdr (car (cdr exp)))))
                                 (major-index (number->string (car (cdr (cdr (car (cdr exp)))))))
                                 (minor-index (number->string (car (cdr (cdr (cdr (car (cdr exp))))))))
                                 (asm-value (code-gen (car (cdr (cdr exp))) major)))
                                    (apply string-append
                                        `(,asm-value 
                                        "\t" "mov rbx, [rbp + 2 * 8]\n"
                                        "\t" "mov rbx, qword[rbx + " ,major-index " * 8]\n"
                                        "\t" "mov qword[rbx + " ,minor-index " * 8], rax\n"
                                        "\t" "mov rax, [sobVoid]" "\n" 
                                        ))))
                        ((is-fvar? (car (cdr exp)))
                        ;(set! (fvar fvar-name) fvar-new-value)
                            (let* 
                                ((fvar-name (car (cdr (car (cdr exp)))))
                                 (asm-value (code-gen (car (cdr (cdr exp))) major))
                                 (item-in-fvar-table (lookup-item-in-table fvars-table fvar-name))
                                 (fvar-address (car (car (cdr item-in-fvar-table)))))
                                    (apply string-append
                                        `(,asm-value
                                        "\t" "mov qword[" ,fvar-address "],rax" "\n"
                                        "\t" "mov rax, [sobVoid]" "\n" 
                                        ))))
                                            ))
                ((is-seq? exp) (let* ((seq-exps (car (cdr exp)))
                                     (asm-seq-exps (apply string-append 
                                                        (map 
                                                            (lambda (e) 
                                                                (code-gen e major))
                                                            seq-exps))))
                                        asm-seq-exps))
                ((is-or? exp) (let* ((current-counter (get-and-increase-counter "or"))
                                     (all-but-last (reverse (cdr (reverse (car (cdr exp))))))
                                     (asm-all-but-last (map (lambda (e) `(,(code-gen e major)
                                                                "\t" "cmp rax, [sobFalse]" "\n"
                                                                "\t" "jne L_or_exit_" ,current-counter "\n"))
                                                            all-but-last))
                                     (asm-last (code-gen (car (reverse (car (cdr exp)))) major))) 
                                        (apply string-append 
                                            `(,@(flatten asm-all-but-last)
                                            ,asm-last
                                            "\t" "L_or_exit_" ,current-counter ":\n")))
                                        )
                ((is-if? exp)   
                    (let* ((test (car (cdr exp)))
                          (dit (car (cdr (cdr exp))))
                          (dif (car (cdr (cdr (cdr exp)))))
                          (asm-test (code-gen test major))
                          (asm-dit (code-gen dit major))
                          (asm-dif (code-gen dif major))
                          (current-counter (get-and-increase-counter "if")))
                                (apply string-append 
                                    `(,asm-test
                                    "\t" "cmp rax, [sobFalse]" "\n"
                                    "\t" "je L_if3_else_" ,current-counter "\n"
                                    ,asm-dit "\n"
                                    "\t" "jmp L_if3_exit_" ,current-counter "\n"
                                    "L_if3_else_" ,current-counter ":\n"
                                    ,asm-dif "\n"
                                    "L_if3_exit_" ,current-counter ":\n"))
							))
                ((or (is-lambda-simple? exp) (is-lambda-opt? exp))
					(let* (
                            (lambda-number (get-and-increase-counter "lambda-simple"))
							(start_body_label (apply string-append `("Lambda_Body_Start" ,lambda-number)))
                            (end_body_label (apply string-append `("Lambda_Body_End" ,lambda-number)))
							(asm-build-closure (build-lambda-closure exp major start_body_label end_body_label ))
							(asm-build-body (build-lambda-body exp major start_body_label end_body_label))
                            (ans (apply string-append 
                                        `(
										,asm-build-closure
										,asm-build-body))))
                                        ans))
                ;((is-applic (car exp))
                ((is-applic-or-tc-applic? exp)
                ;(applic proc (b0 b1 b2 b3))
                        (let* (
                            (proc (car (cdr exp)))
                            (arguments (car (cdr (cdr exp))))
                            (asm-arguments-push
                                (apply string-append 
                                    (map (lambda (arg)
                                        (apply string-append 
                                            `(
                                            ,(code-gen arg major) 
                                            "\t" "push rax" "\n")
                                        ))
                                        (reverse arguments))))
                            (asm-proc (code-gen proc major))
                            (ans (apply string-append 
                                        `(
                                            "\t" ";Start applic" "\n"
                                            "\t" "push qword[sobNil]" "\n"
                                            ,asm-arguments-push
                                            "\t" "push ",(number->string  (length arguments)) "\n"
                                            ,asm-proc
                                            "\t" "mov rbx,rax" "\n"
                                            "\t" "CLOSURE_ENV rbx" "\n"
                                            "\t" "push rbx" "\n"
                                            "\t" "CLOSURE_CODE rax" "\n"
                                            "\t" "call rax" "\n"
;;     					"\t"  "mov rbx, " ,(number->string (length arguments)) "\n"
                                            "\t"  "mov rbx, [rsp+1*8]" "\t;num of arguments\n"
                                            "\t" "shl rbx,3" "\n"
                                            "\t" "add rsp, rbx " "\n" ;pop args
                                            "\t" "pop rbx " "\n" ;nil
                                            "\t" "pop rbx " "\n" ;pop env
                                            "\t" "pop rbx " "\n" ;pop num of args
                                            "\t" ";End applic" "\n"
                                                    ))))
                                                    ans))


                
                
                 ((is-tc-applic? (car exp))
                 ;;OUR TC_APPLIC!!!!!!!
                     (display-with-newline 'I-am-tc-applic-------- exp)
                     (newline)
                     ;(applic proc (b0 b1 b2 b3))
                     (let* (
                         (proc (car (cdr exp)))
                         (arguments (car (cdr (cdr exp))))
                         (asm-arguments-push
                             (apply string-append 
                                 (map (lambda (arg)
                                     (apply string-append 
                                         `(
                                         ,(code-gen arg major) 
                                         "\t" "push rax" "\t;push argument to stack before\n")
                                     ))
                                     (reverse arguments))))
                         (asm-proc (code-gen proc major))
                         (counter (get-and-increase-counter "copy-frame"))
                         (ans (apply string-append 
                                 `(
                                 "\t" ";Start tc-applic" "\n"
                                 ;"\t" "PUSH_R8_R15" "\n"
                                 ;"\t" "push qword[sobNil]" "\n"
                                 ,asm-arguments-push
                                 "\t" "push ",(number->string  (length arguments)) "\t;push number of arguments\n"
                                 ,asm-proc
                                 "\t" "mov rbx,rax" "\n"
                                 "\t" "CLOSURE_ENV rbx" "\n"
                                 "\t" "push rbx" "\n"
                                 "\t" "CLOSURE_CODE rax" "\n"
                                 "\t" "mov r10,qword[rbp+8*1]" "\t;r10 saves old return value\n" 
                                 ;"\t" "lea r10, [rbp+8]" "\n"
                                 "\t" "push r10" "\t;push the return address for later\n"
                                 ;"\t" "push rax" "\t;push rax in order to save the CODE pointer\n"
                                 "\t" "mov r8, rbp" "\t;r8 Savs the rbp\n" 
                                 "\t" "sub r8, 8" "\n"
                                 "\t" "mov r11, qword[rbp + 3*8]" "\t;n -> r11 Saves the number of arguments in the current stack\n" 
                                 ;"\t" "add r11,8" "\n"
                                 "\t" "lea r9, [rbp + 8 * ( r11 + 4)]" "\t; r9 = pointer to start the copy\n" 
                                 "\t" "mov rbp, qword[rbp]" "\t; update the rbp to the old rbp\n" 
                                 "\t" "xor r13,r13" "\n"
                                 "\t" "lea r13, [" ,(number->string  (length arguments)) "+4]" "\t;i -> r13 = m+3\n" 
                                         
                                 "Start_Loop_Copy_Frame" ,counter ":\n"
                                 "\t" "cmp r13,0" "\t;if(r13 < 0) finish\n"
                                 "\t" "jbe End_Loop_Copy_Frame" ,counter "\n"
                                 "\t" "mov r15, qword[r8]" "\t;r15 = r8[r13]\n" 
                                 ;"\t" "push rax" "\n" "\t" "mov rax, r9" "\n" ,(print-rax) "\n" "\t" "pop rax" "\n"
                                 "\t" "mov qword[r9],r15" "\n"
                                 "\t" "sub r8,8" "\n"
                                 "\t" "sub r9,8" "\n"
                                 "\t" "dec r13" "\n"
                                                          
                                 "\t" "jmp Start_Loop_Copy_Frame" ,counter "\n"
                                 "End_Loop_Copy_Frame" ,counter ":\n"
                                 "\t" "add r9,8" "\n"
                                 "\t" "mov rsp, r9" "\t;update the rsp before we jmp to the closure code\n" 
                                 ;"\t" "pop rax" "\n"
                                 ;"\t" "POP_R8_R15" "\n"
                                 "\t" "jmp rax" "\n"
                                 "\t" ";End tc-applic" "\n"
                                 ))))
                                     ans))

                ;Not tested
                ((is-box-get? exp) 
                ; (box-get (bvar x major minor))
                ; (box-get (pvar x  minor))
                        (apply string-append `( 
                                ,(code-gen (car (cdr exp)) major)
                                "\t" "mov rax, [rax]"" \t;unbox variable\n"  
                                )))
                ;Not tested
                ((is-box-set? exp) 
                ;(box-set (bvar a major minor) value)
                ;(box-set (pvar a minor) value)
                    (let* (
                            (asm-value (code-gen (car (cdr (cdr exp))) major))
                            (asm-get-var (code-gen (car (cdr exp)) major)))
                                (apply string-append `(
                                    ,asm-value
                                    "\t" "push r8" "\n"
                                    "\t" "mov r8,rax" "\n"
                                    ,asm-get-var
                                    "\t" "mov [rax], r8 " "\n" 
                                    "\t" "pop r8" "\n"
                                    "\t" "mov rax, sobVoid " "\n" 
                                    ))))
                ;Not tested
                ((is-box? exp) 
                    (let*(
                           (asm-value (code-gen (car (cdr exp)) major))) 
                                (apply string-append `(
                                            "\t" "push r8" "\n"
                                            "\t" "push rdi" "\n"
                                            ,asm-value
                                            "\t" "mov r8 , rax" "\n"
                                            "\t" "mov rdi, 8" "\n"
                                            "\t" "MY_MALLOC rax" "\n"
                                            "\t" "mov qword[rax], r8" "\n"
                                            "\t" "pop rdi" "\n"
                                            "\t" "pop r8" "\n"))))
                        
                (else
                    (display 'ERROR-code-gen-else)
                    (newline))
            )
	)
)
;Work
(define build-lambda-closure
	(lambda (exp major start_body_label end_body_label)
		(let*
			((arguments (car (cdr exp)))
                        (num-arguments (length arguments))
                        (asm-copy-pvars-to-r14 (copy-pvars-to-r14-with-r15 arguments))
                        (asm-copy-bvars-to-r13 (copy-bvars-to-r13-with-r15 major))
			 (ans (apply string-append 
				`(
                "\t" ";Start Closure" "\n"
                "\t" "PUSH_R8_R15" "\n"
                "\t" "push rdi" "\n"
                "\t" "mov rdi, 8 " "\t;size\n"  
                "\t" "MY_MALLOC r12" "\t;malloc for rax(save the closure)\n" 
                "\t" "mov rdi, 8 * " ,(number->string (+ 1 major)) "\n" ;size
                "\t" "push r12" "\n"
                "\t" "MY_MALLOC r13" "\t;malloc for rbx(save the env)\n" 
                "\t" "pop r12" "\n"
;; 		"\t" "mov rdi, 8 * ",(number->string  num-arguments) "\n" ;size
 		"\t" "mov rdi, [rbp + 3*8]" "\n" ;size
 		"\t" "shl rdi, 3" "\n" ;size
		"\t" "push r12" "\n"
		"\t" "push r13" "\n"
                "\t" "MY_MALLOC r14" "\t;malloc for rcx(save the pvars)\n" 
		"\t" "pop r13" "\n"
		"\t" "pop r12" "\n"
                "\t" ";building pvars" "\n"
                ,asm-copy-pvars-to-r14
                "\n" 
                 ,(if (not (eq? major 0))
 					(apply string-append `(
								"\t" ";Building bvars" "\n"
								"\t" "mov r13,qword[rbp +2*8]" "\n"
								,asm-copy-bvars-to-r13 
								"\n"))
 					"")
                "\t" "mov [r13 + 0], r14" "\t;move the pvars to the env\n" 
                "\t" "MAKE_LITERAL_CLOSURE r12, r13, " ,start_body_label "\t;target,env,code\n" 
                "\t" "mov rax,qword[r12]" "\n"
                "\t" "pop rdi" "\n"
                "\t" "POP_R8_R15" "\n"
                "\t" "jmp " ,end_body_label "\n"
                "\t" ";End Closure" "\n"))))
			ans)))
		

;Doesn't work for lambda opt	
;(lambda-simple (a b c) body)
;(lambda-opt (a b c) rest body)
(define build-lambda-body
	(lambda (exp major start_body_label end_body_label)
		(let*
                    ((body (if (is-lambda-simple? exp)
							(car (cdr (cdr exp)))
							(car (cdr (cdr (cdr exp))))))
                    (num-of-args (length (car (cdr exp))))
                    (asm-body (code-gen body (+ 1 major)))
			 (ans (apply string-append 
				`(
				
                                        "\t" ";Start lambda body" "\n"
					,start_body_label ":\n" 
					"\t" "START_FUNC" "\n"
					,(code-gen-fix-for-lambda-opt exp num-of-args)
					,asm-body
					"\t" "END_FUNC" "\n"
					,end_body_label ":\n" 
                                        "\t" ";End lambda body" "\n"
	))))
					ans)))
			
			
			
			 
			 
			 
;might be a problem because we didnt update rsp after cutting the argument list
;Doesn't Work, need to complete the TODOs
(define code-gen-fix-for-lambda-opt	
	(lambda (exp num-of-args)
		(if (is-lambda-simple? exp)
			""
			(let ((createListCounter (get-and-increase-counter "create-list")))
				(apply string-append 
					`(
					"\t" "FIX_FOR_OPT",createListCounter ":\n" 
 					"\t" "PUSH_R8_R15" "\n"
 					"\t" "push rdi" "\n"
                                        "\t" "mov rdi, 8" "\n" ; size for malloc
					"\t" "MY_MALLOC r15" "\n" ;r13 hold the current pair
					"\t" "mov rdi, qword[sobNil]" "\n"
					"\t" "mov qword[r15], rdi" "\n" ;r15 will hold the new list
					"\t" "mov r14, qword[rbp+ 3*8]" "\n" ; Save the Number of arguments
					"\t" "mov r10, r14" "\n" ; Save the number of arguments from applic
					"Start_Create_List" ,createListCounter ":\n"
					"\t" "cmp r14," ,(number->string num-of-args) "\n"
					"\t" "jle End_Create_List" ,createListCounter "\n"
					"\t" "mov rdi, 8" "\n" ; size for malloc
                                        "\t" "MY_MALLOC r13" "\n" ;r13 hold the current pair
                                        "\t" "mov rdi, qword[rbp+ 8 * (3 + r14)]" "\n" ; r13 = argument[r14]
                                        "\t" "mov qword[r13] , rdi" "\n"
                                        "\t" "mov rdi, 8" "\n" ; size for malloc
                                        "\t" "MY_MALLOC r12" "\n" ;r12 hold the current pair
                                        "\t" "MAKE_MALLOC_LITERAL_PAIR r12, r13, r15" "\n"                                                                                                                 
                                         "\t" "mov r15, r12" "\n"
					"\t" "dec r14" "\n"
					"\t" "jmp Start_Create_List" ,createListCounter "\n"
                                        "End_Create_List" ,createListCounter ":\n" 
                                        "\t" "mov qword[rbp + 3 * 8]," ,(number->string (+ 1 num-of-args)) "\n" ;fixed the correct num of args
                                        "\t" "mov rdi, qword[r15]" "\n" ;added the list as the last argument
 					"\t" "mov qword[rbp + 8 * (3 +" ,(number->string (+ 1 num-of-args)) ")], rdi" "\n" ;added the list as the last argument
  	                                
  	                                "\t" "cmp r10, ",(number->string num-of-args) "\t; if number of arguments for lambda = number of arguments from applic\n"
  	                                "\t" "je NO_NEED_TO_MOVE_STACK",createListCounter "\n"
  	                                "\t" "mov r9, r10 " "\n"
                                        "\t" "sub r9 ," ,(number->string num-of-args) "\n"
                                        "\t" "cmp r9, 0 " "\t; if number of arguments from applic - arguments from lambda = 0\n"
  	                                "\t" "je NO_NEED_TO_MOVE_STACK",createListCounter "\n"
                                        "\t" "mov r9, ",(number->string num-of-args) "\n"
                                        "\t" "add r10, 3" "\n"
                                        "\t" "add r9, 4" "\n"
                                        "START_LOOP_MOVE_STACK_UP",createListCounter ":\n"
                                        "\t" "cmp r10, 0" "\n"
                                        "\t" "jl END_LOOP_MOVE_STACK_UP",createListCounter "\n"
                                        "\t" "mov rdi, qword[rbp + 8* r9]" "\n"
                                        "\t" "mov qword[rbp + 8 * r10], rdi" "\n"
                                        "\t" "dec r10" "\n"
                                        "\t" "dec r9" "\n"
                                        "\t" "jmp START_LOOP_MOVE_STACK_UP",createListCounter "\n"
                                        "END_LOOP_MOVE_STACK_UP",createListCounter ":\n" 
                                        "\t" "inc r9" "\n"
                                        "\t" "neg r9" "\n"
                                        "\t" "shl r9,3" "\n"
                                        "\t" "add rbp,r9" "\n"
                                        "\t" "add rsp,r9" "\n"
                                        "NO_NEED_TO_MOVE_STACK",createListCounter ":\n"
					"\t" "pop rdi" "\n"
 					"\t" "POP_R8_R15" "\n"
	
					)
				)
			)
		)
	)
)
			
			 
			 
			 


(define copy-pvars-to-r14-with-r15
    (lambda (args)
		(let ((paramLoop (get-and-increase-counter "for")))
            (apply string-append `(
            
                            "\t" "PUSH_R8_R15" "\n"
                            "\t" "push rdx" "\n"
                            "\t" "mov r12 , qword[rbp + 3 * 8]" "\n"
                            "\t" "xor rdx, rdx" "\n"
                            
                            
                            
                            "paramLoop",paramLoop ":\n"
                            "\t" "cmp rdx , r12" "\n"
                            "\t" "jge endParamLoop",paramLoop "\n"
                            "\t" "xor r15,r15" "\n"
                            "\t" "mov r15, qword[rbp + (rdx + 4) *8]" "\n"
                            
                            
;;                             "\t" "push rax" "\n"
;;                             "\t" "mov rax,r15" "\n"
;;                               ,(print-rax)
;;                               "\t" "pop rax" "\n"
                            
                            
                            "\t" "mov [r14 + 8*rdx], r15" "\n"
                            "\t" "inc rdx" "\n"
                            "\t" "jmp paramLoop",paramLoop "\n"
                            "endParamLoop" ,paramLoop ":\n"
                            "\t" "pop rdx" "\n"
                            "\t" "POP_R8_R15" "\n"
                            
                            
                                    )
			)
        )
    )
)






(define copy-bvars-to-r13-with-r15
    (lambda (major)
        (let ((envCounter (get-and-increase-counter "env")))
            (apply string-append `(
                                "\t" "PUSH_R8_R15" "\n"
                                "\t" "push rdi" "\n"
                                "\t" "mov r15," ,(number->string major) "\n\n"
                                "startEnvLoop" ,envCounter ":\n"
                                "\t" "cmp r15, 0" "\n"
                                "\t" "jl endEnvLoop" ,envCounter "\n"
                                "\t" "mov rdi, qword [r13 + 8 * r15]" "\n"    ;x=r13[i]
                                "\t" "mov [r13 + 8 * (r15 + 1)] , rdi" "\n"   ;r13[i+1] = x
                                "\t" "dec r15" "\n"
                                "\t" "jmp startEnvLoop" ,envCounter "\n"
                                "endEnvLoop" ,envCounter ":\n\n"
                                "\t" "pop rdi" "\n"
                                "\t" "POP_R8_R15" "\n"
                                )))))



(define add-address-to-constant-table
    (lambda (const-exp+type new-label table)
        (cond
            ((eq? table '()) '())
            ((eq? (car const-exp+type) (car (car table)))
               `(,`(,@const-exp+type ,new-label) ,@(add-address-to-constant-table const-exp+type new-label (cdr table))))
            (else
                `(,(car table) ,@(add-address-to-constant-table const-exp+type new-label (cdr table))))
        )
    )
)
;input:((const a) (T_SYMBOL 0))
(define add-address-to-constant-table-by-type
    (lambda (type const-exp+type new-label table)
;         (display-with-newline 'const-exp+type_____ const-exp+type)
        (cond
            ((eq? table '()) '())
            ((and (eq? (car const-exp+type) (car (car table))) (equal? type (car (car (cdr  const-exp+type)))))
               `(,`(,@const-exp+type ,new-label) ,@(add-address-to-constant-table-by-type type const-exp+type new-label (cdr table))))
            (else
                `(,(car table) ,@(add-address-to-constant-table-by-type type const-exp+type new-label (cdr table))))
        )
    )
)
                
          
          
;input : ((fvar a) (Free_variable_a))
;outpu: Free_variable_a: 
;                       dq SOB_UNDEFINED
(define convert-fvar-to-asm
    (lambda (fvar-element) 
        (let* (
                (label-name (car (car (cdr fvar-element))))
                (ans (apply string-append 
                        `(,label-name ":\n" 
                        "\t" "dq SOB_UNDEFINED" "\n"))))
                        ans
        )
    )
)


;Doesn't Work
(define convert-const-to-asm 
	(lambda (acc x)
            ;(display-with-newline 'convert-const-to-asm_X: x)
            ;(display-with-newline 'car_car_cdr_x (car (car (cdr x))))
            (cond 
                ((equal? (car (car (cdr x))) "T_VOID")
                    (let* (
                            (new-label "sobVoid")
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL(T_VOID, 0)\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
                                
                            
               ((equal? (car (car (cdr x))) "T_NIL")   
                    (let* (
                            (new-label "sobNil")

                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL(T_NIL, 0)\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               ((equal? (car (car  (cdr x))) "T_BOOL")  
                    (let* (
                            (value (car (cdr (car  (cdr x)))))
                            (new-label (if (= value 0) "sobFalse" "sobTrue"))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL(T_BOOL," ,(number->string value) ")\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               ((equal? (car (car  (cdr x))) "T_INTEGER") 
                    (let* (
                            (value (number->string (car (cdr (car  (cdr x))))))
                            (new-label 
                                (apply string-append 
                                                    `("sobInteger" 
                                                    ,(if (negative? (car (cdr (car  (cdr x))))) 
                                                        (apply string-append `("Neg" ,(number->string (* -1 (car (cdr (car  (cdr x))))))))
                                                        value))))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL(T_INTEGER," ,value ")\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))

               ((equal? (car (car  (cdr x))) "T_CHAR")    
                    (let* (
                            (value (number->string (car (cdr (car  (cdr x))))))
                            (new-label (apply string-append `("sobChar" ,value)))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL(T_CHAR," ,value ")\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               ((equal? (car (car  (cdr x))) "T_PAIR")
                    (let* (
                            (car-element  (car (cdr (car  (cdr x)))))
                            (cdr-element (car (cdr (cdr (car  (cdr x))))))
                            (car-element-item-from-table (lookup-item-in-table constants-table (car (cdr car-element))))
                            (cdr-element-item-from-table (lookup-item-in-table constants-table (car (cdr cdr-element))))
                            (car-element-name (car (cdr (cdr car-element-item-from-table))))
                            (cdr-element-name (car (cdr (cdr cdr-element-item-from-table))))
                            (value (apply string-append `("_" ,car-element-name "_" ,cdr-element-name)))
                            (new-label (apply string-append `("sobPair" ,(number->string sobCounter))))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL_PAIR(" ,car-element-name "," ,cdr-element-name ")\n"))))
                                (set! sobCounter (+ 1 sobCounter))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
                ((equal? (car (car  (cdr x))) "T_STRING")
                    (let* (
                            (value (fix-special-char-in-string (list->string (map  
                                                    (lambda(num)
                                                        (integer->char num))
                                                    (car (cdr (cdr (car (cdr x)))))))))
                            (new-label (apply string-append `("sobString" ,(number->string sobCounter))))
                            (create-label (apply string-append `(,new-label ":\n\t" "MAKE_LITERAL_STRING \"" ,value "\"\n"))))
                                (set! sobCounter (+ 1 sobCounter))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               ((equal? (car (car  (cdr x))) "T_VECTOR")
                    (let* (
                            (vec-elements (car (cdr (cdr (car (cdr x))))))
                            (value (apply string-append (map 
                                    (lambda(vec-single-element) 
                                        (string-append 
                                            (car (cdr (cdr(lookup-item-in-table constants-table (car (cdr vec-single-element)))))) " ,"))
                                    vec-elements)))
                            (new-label (apply string-append `("sobVector" ,(number->string sobCounter))))
                            (create-label (apply string-append 
                                                `(,new-label ":\n\t" "MAKE_LITERAL_VECTOR " 
                                                    ,(if (eq? vec-elements '()) "" (substring value 0 (- (string-length value) 1 )))
                                                         "\n"))))
                                (set! sobCounter (+ 1 sobCounter))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               ((equal? (car (car  (cdr x))) "T_SYMBOL") 
                    (let* (
                            (sym-name (car (cdr (car x))))
                            (address (car (cdr (cdr (lookup-item-in-table constants-table (symbol->string sym-name))))))
                            (new-label (apply string-append `("sobSymbol_" ,(get-and-increase-counter "symbol-counter"))))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL_SYMBOL(" ,address ")\n"))))
                            
                                
                                ;(display-with-newline 'create-label: (string->list create-label))
                                (set! symbols-table (add-address-to-constant-table-by-type "T_SYMBOL" x new-label symbols-table))
                                (set! constants-table (add-address-to-constant-table-by-type "T_SYMBOL" x new-label constants-table))
                                `(,@acc ,create-label)))
                                
                                
                                
                                
                                
                                
               ;(string-append "PUSH(" (number->string(cadddr x)) ");\n" "CALL(MAKE_SOB_SYMBOL);\n" "DROP(1);\n"))
                ;((const 1/5) (T_FRACTION 1 5))
                  ((equal? (car (car  (cdr x))) "T_FRACTION")  
                         (let* (
                            (upper-element  (car (cdr (car  (cdr x)))))
                            (lower-element (car (cdr (cdr (car  (cdr x))))))
                            (upper-element-item-from-table (lookup-item-in-table constants-table upper-element))
                            (lower-element-item-from-table (lookup-item-in-table constants-table lower-element))
                            (upper-element-name (car (cdr (cdr upper-element-item-from-table))))
                            (lower-element-name (car (cdr (cdr lower-element-item-from-table))))
                           ; (value (apply string-append `("_" ,upper-element-name "_" ,lower-element-name)))
                            (new-label (apply string-append 
                                            `("sobFraction_" 
                                            ,(if (negative? upper-element)
                                                (apply string-append `(
                                                                        "Neg"
                                                                        ,(number->string (* -1 upper-element))))
                                                (number->string upper-element))
                                            "_" 
                                            ,(number->string lower-element))))
                            (create-label (apply string-append `(,new-label ":\n\tdq MAKE_LITERAL_FRACTION(" ,upper-element-name "," ,lower-element-name ")\n"))))
                                (set! constants-table (add-address-to-constant-table x new-label constants-table))
                                `(,@acc ,create-label)))
               (else 
                    (display-with-newline 'Error-In-convert-const-to-asm-x:: x))
            )
         )
)

(define fix-special-char-in-string
	(lambda (str)
		(if (equal? str "")
			""
			(let ((ch (string-ref str 0))
				  (current-string-length (string-length str)))
				(cond 
					((equal? ch #\newline)
						(string-append "\\n" (fix-special-char-in-string (substring str 1 current-string-length))))
					((equal? ch #\return)
						(string-append "\\r" (fix-special-char-in-string (substring str 1 current-string-length))))
					((equal? ch #\tab)
						(string-append "\\t" (fix-special-char-in-string (substring str 1 current-string-length))))
					((equal? ch #\page)
						(string-append "\\f" (fix-special-char-in-string (substring str 1 current-string-length))))
				(else
					(string-append (string ch) (fix-special-char-in-string (substring str 1 current-string-length)))))))))
        
	
;Work
(define add-constant-type
    (lambda (lst value)
		(let ((evaluated-value 
                            (cond 
                                ((is-void? value) `(,value ,`("T_VOID")))
                                ((is-null? value)         `(,value ,`("T_NIL")))
                                ((is-true? value)     `(,value ,`("T_BOOL" 1)))
                                ((is-false? value)     `(,value ,`("T_BOOL" 0)))
                                ((integer? (car (cdr value)))      `(,value ,`("T_INTEGER" ,(cadr value))))
                                ((pair? (car (cdr value)))
                                    (let ((first-element (car (car (cdr value))))
                                          (rest-element (cdr (car (cdr value)))))
                                                `(,value ,`("T_PAIR" 
                                                ,(lookup-table lst first-element) 
                                                ,(lookup-table lst rest-element)))))
                                ((vector? (cadr value))       
                                        `(,value ,`("T_VECTOR" ,(vector-length (cadr value))
                                            ,(map
                                                (lambda(x) 
                                                    (lookup-table lst x)) 
                                            (vector->list (cadr value)))))) ; TO-DO: FIX
                                ((string? (cadr value))       
                                        `(,value ,`("T_STRING" ,(string-length (cadr value)) 
                                            ,(map 
                                                char->integer 
                                            (string->list (cadr value))))))
                                ((char? (cadr value))         `(,value ,`("T_CHAR" ,(char->integer (cadr value)))))
                                ((symbol? (cadr value))       `(,value ,`("T_SYMBOL" 0)))
                                ((rational? (cadr value))     `(,value ,`("T_FRACTION" ,(numerator (cadr value)) ,(denominator (cadr value)))))
                                (else "Error-In-convert-const-to-asm\n")
                                    
                        )
                    ))
            `(,@lst ,evaluated-value)
        )
    )
)

                                            
                                            

											
;Doesn't Work?										
(define remove-null-from-lst
    (lambda (lst)
        (remove '() lst)))
     
    

            
;Don't know if it works
(define subsets-for-symbols 
	(lambda (lst)
		(if (null? lst) 
			'() 
			(if (not (list? lst)) 
				(if (vector? lst) 
					`( ,@(flatten (map subsets-for-symbols (vector->list lst))) ,lst)
					(if (pair? lst)  
						(append (subsets-for-symbols (car lst))(subsets-for-symbols (cdr lst)) (list lst))
						(list lst)  )) 
				(append (fold-left (lambda(xs x) (if (not (list? x)) (append xs (list x)) (append xs (subsets-for-symbols x)))) '() lst)
					(subsets-for-symbols (cdr lst)) (list lst)))
			)))
			
			
			
(define display-table
    (lambda(table-name table)
        ;(display-with-newline 'table-name: table-name)
        (map
            (lambda(x)
                (display-with-newline ': x))
            table
        )
    )
)



(define is-bvar?
    (lambda (bvar-element)
        (eq? 'bvar (car bvar-element))))
        
(define is-pvar?
    (lambda (pvar-element)
        (eq? 'pvar (car pvar-element))))
        
        
        
     
;Work
(define is-void?
    (lambda(x)
        (eq? (car (cdr x)) (void))))
        
;Work
(define is-null?
    (lambda(x)
        (eq? (car (cdr x)) '())))
        
;Work
(define is-true?
    (lambda(x)
        (eq? (car (cdr x)) #t)))
        

;Work
(define is-false?
    (lambda(x)
        (eq? (car (cdr x)) #f)))
;Work
(define is-applic-or-tc-applic?
    (lambda (x)
        (if (or (equal? (car x) 'tc-applic) (is-applic (car x)))
			#t
			#f
        )
    )
)

(define is-tc-applic?
	(lambda (x)
		(equal? x 'tc-applic)))		
	

;Work
(define is-fvar?
    (lambda (x)
        (equal? (car x) 'fvar)))


;Work
(define flatten
    (lambda (x)
        (cond ((null? x) '())
            ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
            (else (list x)))))


;Work
(define test0
    (lambda (x)
        (get-all-consts-from-scheme 
            (annotate-tc
                (pe->lex-pe
                    (box-set
                        (remove-applic-lambda-nil
                            (parse x))))) 
                '()
                
                
        )))
            
;Work
(define test1
    (lambda (x)
        (remove-const-nested-brackets (get-all-consts-from-scheme 
            (annotate-tc
                (pe->lex-pe
                    (box-set
                        (remove-applic-lambda-nil
                            (parse x))))) 
                '()
                
                
        )'())))
            
    
            
;Work
(define test2
    (lambda (x)
        (remove-duplicate (add-default-constants (remove-const-nested-brackets (get-all-consts-from-scheme 
            (annotate-tc
                (pe->lex-pe
                    (box-set
                        (remove-applic-lambda-nil
                            (parse x))))) 
                '()
                
                
        )'())))))
        
        
;Work
(define test3
    (lambda(x)
        (all-constants 
            (remove-duplicate 
                (add-default-constants 
                    (remove-const-nested-brackets 
                        (map   
                            (lambda(sexpr)
                                get-all-consts-from-scheme sexpr '() )
                            (pipeline (initiate-basic-scheme-functions x))) '()))))))
                            
		
;Work
(define display-with-newline
    (lambda (str val)
        (display str)
        (display ':)
        (display val)
        (newline)
    )
)
;Work
(define pipeline
    (lambda (s)
        ((star <sexpr>) s
         (lambda (m r)
            (map (lambda (e)
                    (annotate-tc
                        (pe->lex-pe
                            (box-set
                                (remove-applic-lambda-nil
                                    (parse e))))))
            m))
        (lambda (f) 'fail))))
        
        
        
;Work
(define my_pipeline
    (lambda (s)
        (annotate-tc
            (pe->lex-pe
                (box-set
                    (remove-applic-lambda-nil
                        (parse s)))))))
        
        
        
        
		
;Doesn't Work
;Need to add implementations		
(define compile-scheme-file
    (lambda (file output-name)
        (let* ((stringed-file (file->string_ file))
                (parsed-only-scheme (pipeline stringed-file))
                (parsed-scheme (initiate-basic-scheme-functions  parsed-only-scheme))
                (parsed-library (initiate-basic-scheme-functions-no-args))
               ;(parsed-scheme (pipeline stringed-file))
                (all-constants (create-constant-table parsed-scheme))
                (all-symbols (create-symbol-table all-constants))          
                (all-fvars (create-fvar-table parsed-scheme)))
                    (set! constants-table  (fold-left add-constant-type '() all-constants))
                    (set! symbols-table  (fold-left add-constant-type '() all-symbols))
                    (set! fvars-table (map add-fvar-address all-fvars))
                    (set! fvars-table (add-default-fvar fvars-table))
                    
                    (let* ((asm-constants-table (fold-left convert-const-to-asm '() constants-table))
                           (asm-fvar-table (map convert-fvar-to-asm fvars-table)))
;;                            (set! symbols-table (map add-address-to-symbol symbols-table))
                                (let* (
                                    (asm-symbol-table (map add-symbol-to-link-asm symbols-table))
                                    (generated-code 
                                                    (map 
                                                        (lambda(exp)
                                                            (apply string-append `(
                                                                                ,(code-gen exp 0)
                                                                                ,(print-rax)
																				)))
                                                    parsed-only-scheme))
                                     (library-code 
                                                     (map 
                                                         (lambda(exp)
                                                             (apply string-append `(
                                                                                 ,(code-gen exp 0))))
                                                         parsed-library))
                                    (to-write 
                                        (apply string-append `(	
                                                
                                                "%include \"Meir_Lib.lib\"\n"
                                                "extern malloc\n"
                                                "extern exit\n"
                                                "section .data\n"
                                               "my_newline: db CHAR_NEWLINE, 0\n"
                                                ,@asm-fvar-table "\n"
                                                "start_of_data:\n"
                                                ,@asm-constants-table
                                               "my_symbols_link: dq sobNil\n"
                                                "section .text\n"
                                                "main:\n"
                                                ;"\t" "mov rax, malloc_pointer" "\n"
                                                ;"\t" "mov qword[rax], start_of_malloc" "\n"
                                                
                                                
                                                
                                                
                                                ";START Create symbol table" "\n"
                                                ,@asm-symbol-table
                                                
                                                ";END Create symbol table" "\n"
                                                "\t" "push 0" "\n"
                                                "\t" "push 0" "\n"
                                                "\t" "push 0" "\n"
                                                "\t" "push EXIT_COMPILER_SUCCESS" "\n"
                                                "\t" "START_FUNC" "\n"
                                                
                                                
                                                "\t" ";adding initial asm functions" "\n"
                                                "\t" ,(add-library-asm) "\n"
                                                ,@library-code
                                                ,@generated-code
;;                                                  "\t" "pop rbp" "\n"
;;                                                  "\t" "add rsp , 4*8" "\n" 
;;                                                  "\t" "ret" "\n\n\n"
                                                 "EXIT_COMPILER_SUCCESS:" "\n"
                                                 "\t" "pop rbx" "\n"
                                                 "\t" "mov rax, 0" "\n"
                                                 "\t" "call exit" "\n"
                                                ,error-label ":\n"
                                                "\t" "push 0" "\t;TODO: how to exit normally\n"
                                                "\t" "ret" "\n"
												)
                                )
                            )
                        )
                    (string->file to-write output-name))
                    )
        )
    )
)

            
(define build-lambda-closure-for-asm-func
	(lambda (function-name)
		(let*
			 ((ans (apply string-append 
				`(
                ";Start Init Func Closure " ,function-name "\n"
                "\t" "PUSH_R8_R15" "\n"
                "\t" "push rdi" "\n"
                "\t" "mov rdi, 8 " "\n"  ;size
                "\t" "MY_MALLOC r12" "\n" ;malloc for rax(save the closure)
                "\t" "mov r13, 0" "\t;library function don't have env\n"
                "\t" "MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_",function-name  "\n" ;target,env,code
                "\t" "mov rax,qword[r12]" "\n"
                "\t" "pop rdi" "\n"
                "\t" "POP_R8_R15" "\n"
                "\t" "jmp Lambda_Body_End_",function-name "\n"
                "\t" ";End Init Func Closure " ,function-name "\n"))))
			ans)))

(define asm-type?
    (lambda (function-name type)
        (let* (
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rax, qword[rbp + 4 * 8]" "\n"
                        "\t" "TYPE rax" "\n"
                        "\t" "cmp rax," ,type "\n"
                        "\t" "jne Type_not_equal",counter "\n"
                        "\t" "mov rax, [sobTrue]" "\n"
                        "\t" "jmp end_CMP_TYPE",counter "\n"
                        "Type_not_equal",counter ":\n"
                        "\t" "mov rax, [sobFalse]" "\n"
                        "end_CMP_TYPE",counter ":\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))

;Doesn't Work
;Need to Add implementation 
;input :(((fvar a) (Free_variable_a)))
(define add-default-fvar
    (lambda (tbl)
    `(
    ,@tbl 
    ,`((fvar void?) ("is_void"))
    ,`((fvar null?) ("is_null"))
    ,`((fvar integer?) ("is_integer"))
    ,`((fvar fraction?) ("is_fraction"))
    ,`((fvar boolean?) ("is_boolean"))
    ,`((fvar char?) ("is_char"))
    ,`((fvar string?) ("is_string"))
    ,`((fvar symbol?) ("is_symbol"))
    ,`((fvar procedure?) ("is_closure"))
    ,`((fvar pair?) ("is_pair"))
    ,`((fvar vector?) ("is_vector"))
    ,`((fvar eq?) ("is_eq"))
    ,`((fvar car) ("car"))
    ,`((fvar cdr) ("cdr"))
    ,`((fvar cons) ("cons"))
    ,`((fvar integer->char) ("integer_to_char"))
    ,`((fvar char->integer) ("char_to_integer"))
    ,`((fvar yaniv_plus) ("yaniv_plus"))
    ,`((fvar +) ("variadic_plus"))
    ,`((fvar -) ("variadic_minus"))
    ,`((fvar yaniv_mult) ("yaniv_mult"))
    ,`((fvar *) ("variadic_mult"))
    ,`((fvar yaniv_div) ("yaniv_div"))
    ,`((fvar /) ("variadic_div"))
    ,`((fvar yaniv_greater) ("yaniv_greater"))
    ,`((fvar >) ("variadic_greater"))
    ,`((fvar yaniv_smaller) ("yaniv_smaller"))
    ,`((fvar <) ("variadic_smaller"))
    ,`((fvar yaniv_equivalent) ("yaniv_equivalent"))
    ,`((fvar =) ("variadic_equivalent"))
    ,`((fvar remainder) ("yaniv_remainder"))
    ,`((fvar string-length) ("yaniv_string_length"))
    ,`((fvar string-ref) ("yaniv_string_ref"))
    ,`((fvar vector-length) ("yaniv_vector_length"))
    ,`((fvar vector-ref) ("yaniv_vector_ref"))
    ,`((fvar make-string) ("yaniv_make_string"))
    ,`((fvar make-vector) ("yaniv_make_vector"))
    ,`((fvar vector) ("yaniv_convert_list_to_vector"))
    ,`((fvar string-set!) ("yaniv_string_set"))
    ,`((fvar vector-set!) ("yaniv_vector_set"))
    ,`((fvar symbol->string) ("yaniv_symbol_to_string"))
    ,`((fvar string->symbol) ("yaniv_string_to_symbol"))
    ,`((fvar apply) ("yaniv_apply"))
    
    

    )))   
(define add-library-asm
    (lambda()
        (apply string-append
            `(
;; ;;                      #| 
                        ,(asm-all-types)
                       ,(asm-eq?)
                       ,(asm-car-cdr "CAR" "car")
                       ,(asm-car-cdr "CDR" "cdr")
                       ,(asm-cons)
                       ,(asm-integer-to-char)
                       ,(asm-char-to-integer)
                      
                       ,(asm-yaniv-plus)
                       
                       ,(asm-yaniv-mult)
                       ,(asm-yaniv-div)
                       ,(asm-greater)
                       ,(asm-smaller)
                       ,(asm-equivalent)
                       ,(asm-remainder)
                       ,(asm-string-length)
                       ,(asm-string-ref)                
                       ,(asm-vector-length)
                       ,(asm-vector-ref)
                       ,(asm-make-string)
                       ,(asm-make-vector)
                       ,(asm-vector)
                       ,(asm-set-string)
                       ,(asm-set-vector)
                       ,(asm-convert-symbol-to-string)
                      ,(asm-convert-string-to-symbol)
                      ,(asm-apply)
;;                       |#
                 
                ))))
            
    
    
(define asm-all-types
    (lambda()
        (apply string-append
            `(
                ,(asm-type? "is_void" "T_VOID")
                ,(asm-type? "is_null" "T_NIL")
                ,(asm-type? "is_integer" "T_INTEGER")
                ,(asm-type? "is_fraction" "T_FRACTION")
                ,(asm-type? "is_boolean" "T_BOOL")
                ,(asm-type? "is_char" "T_CHAR")
                ,(asm-type? "is_string" "T_STRING")
                ,(asm-type? "is_symbol" "T_SYMBOL")
                ,(asm-type? "is_closure" "T_CLOSURE")
                ,(asm-type? "is_pair" "T_PAIR")
                ,(asm-type? "is_vector" "T_VECTOR")
              
               
               ))))

            
                        
(define remove-library-fvars
    (lambda (lst)
        (filter 
            (lambda (item)
                (let* (
                        (fvar-name (car (cdr item))))
                            (not (member fvar-name library-functions))))
            lst)))
            
            
(define asm-eq? 
    (lambda ()
        (let* (
            (function-name "is_eq")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov r11, qword[rbp + 4 * 8]" "\n"
                        "\t" "mov r12, qword[rbp + 5 * 8]" "\n"
						
						
						
						"\t" "mov r13, r11" "\n"
						"\t" "mov r14, r12" "\n"
						"\t" "TYPE r13" "\n"
						"\t" "TYPE r14" "\n"
						"\t" "cmp r13, T_SYMBOL" "\n"
						"\t" "jne REGULAR_COMPARE" ,counter "\n"
						"\t" "cmp r14, T_SYMBOL" "\n"
						"\t" "jne REGULAR_COMPARE" ,counter "\n"
						"\t" "DATA r11" "\n"
						"\t" "DATA r12" "\n"
						"REGULAR_COMPARE" ,counter ":\n"
						
						
                        "\t" "cmp r11, r12" "\n"
                        "\t" "jne Not_equal",counter "\n"
                        "\t" "mov rax, [sobTrue]" "\n"
                        "\t" "jmp end_CMP",counter "\n"
                        "Not_equal",counter ":\n"
                        "\t" "mov rax, [sobFalse]" "\n"
                        "end_CMP",counter ":\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
(define asm-car-cdr
    (lambda (function-name-upper function-name-lower )
        (let* (
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name-upper))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name-upper "\n"
                        "Lambda_Body_Start_",function-name-upper ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov r11, qword[rbp + 4 * 8]" "\n"
                        "\t" ,function-name-upper " r11" "\n"
                        "\t" "mov rax, r11" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name-upper ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name-lower "],rax" "\n"))))
                    ans)))

(define asm-cons
    (lambda ()
        (let* (
            (function-name "cons")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"

                        "\t" "mov rdi,8" "\n"
                        "\t" "MY_MALLOC r11" "\n"
                        "\t" "mov rdi, qword[rbp + (4 * 8)]" "\n"
                        "\t" "mov [r11], rdi" "\n"
                        "\t" "push r11" "\n"
                        "\t" "mov rdi,8" "\n"
                        "\t" "MY_MALLOC r12" "\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\n"
                        "\t" "mov [r12], rdi" "\n"
                        "\t" "push r12" "\n"
                        "\t" "mov rdi, 8" "\n" ; size for malloc
                        "\t" "MY_MALLOC r15" "\n" ;r15 hold the pair
                        "\t" "pop r12" "\n"
                        "\t" "pop r11" "\n"
                        "\t" "MAKE_MALLOC_LITERAL_PAIR r15, r11, r12" "\t;target-address,car-address,cdr-address \n"
                        "\t" "mov rax, [r15]" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
                    
                    
(define asm-integer-to-char
    (lambda ()
        (let* (
            (function-name "integer_to_char")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rdi, qword[rbp + (4 * 8)]" "\n"
                        "\t" "mov rbx, rdi" "\n"
                        "\t" "TYPE rbx" "\n"
                        "\t" "cmp rbx, T_INTEGER" "\n"
                        "\t" "jne " ,error-label "\n"
                        "\t" "MY_MAKE_LITERAL rax ,T_CHAR ,rdi" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
(define asm-char-to-integer
    (lambda ()
        (let* (
            (function-name "char_to_integer")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rdi, qword[rbp + (4 * 8)]" "\n"
                        "\t" "mov rbx, rdi" "\n"
                        "\t" "TYPE rbx" "\n"
                        "\t" "cmp rbx, T_CHAR" "\n"
                        "\t" "jne " ,error-label "\n"
                        "\t" "MY_MAKE_LITERAL rax ,T_INTEGER ,rdi" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))

                    
                    
(define asm-yaniv-plus
    (lambda ()
        (let* (
            (function-name "yaniv_plus")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name " x+y\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
						
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        
                        "\t" "MY_PLUS_FRACTION rdi, rcx" "\n"
                        "\t" "TRY_INTEGER_CONVERTION rax" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
					
(define asm-yaniv-mult
    (lambda ()
        (let* (
            (function-name "yaniv_mult")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name " x+y\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
                                             
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        "\t" "MY_MULT_FRACTION rdi, rcx" "\n"
                        "\t" "TRY_INTEGER_CONVERTION rax" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
                    
(define asm-yaniv-div
    (lambda ()
        (let* (
            (function-name "yaniv_div")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name " x+y\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        "TEST1:\n"
                        "\t" "MY_DIV_FRACTION rcx, rdi" "\n"
                        "\t" "TRY_INTEGER_CONVERTION rax" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
                    
                    
(define asm-greater
    (lambda ()
        (let* (
            (function-name "yaniv_greater")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
						
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        
                        "\t" "GREATER_THAN_FRACTION rcx, rdi" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
                    
(define asm-smaller
    (lambda ()
        (let* (
            (function-name "yaniv_smaller")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
						
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        
                        "\t" "SMALLER_THAN_FRACTION rcx, rdi" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))

                    
(define asm-equivalent
    (lambda ()
        (let* (
            (function-name "yaniv_equivalent")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
						
                        "\t" "FRAC_CONVERTER rcx" "\n"
                        
                        "\t" "mov rcx,rax" "\n"
                        "\t" "push rcx" "\n"
                        
                        "\t" "FRAC_CONVERTER rdi" "\n"
                        "\t" "mov rdi,rax" "\n"
                        "\t" "pop rcx" "\n"
                        
                        "\t" "EQUIVALENT_FRACTION rcx, rdi" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
(define asm-remainder
    (lambda ()
        (let* (
            (function-name "yaniv_remainder")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "mov rcx, qword[rbp + (4 * 8)]" "\t;rcx =x\n"
                        "\t" "mov rdi, qword[rbp + (5 * 8)]" "\t;rdi =y\n"
						
                        "\t" "DATA rcx" "\n"
                        
                        "\t" "DATA rdi" "\n"

                        "\t" "mov rax,rcx" "\n"
                        "\t" "cqo" "\n"
                        "\t" "idiv rdi" "\t; rax- result , rdx - reminder\n"
                        "\t" "ADD_LITERAL_TYPE T_INTEGER, rdx" "\n"
                        "\t" "mov rax,rdx" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    
                    

(define asm-string-length
    (lambda ()
        (let* (
            (function-name "yaniv_string_length")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "push r8" "\n"
                        "\t" "mov r8, qword[rbp + (4 * 8)]" "\n"
                        "\t" "STRING_LENGTH r8" "\n"
                        "\t" "ADD_LITERAL_TYPE T_INTEGER, r8" "\n"
                        "\t" "mov rax, r8" "\n"
                        "\t" "pop r8" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))
                    

;Work
 (define asm-string-ref
     (lambda ()
         (let* (
             (function-name "yaniv_string_ref")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov rbx, qword[rbp + (4 * 8)]" "\t;hold the string\n"
                         "\t" "mov rcx, qword[rbp + (5 * 8)]" "\t;hold the index\n"
                         "\t" "DATA rcx" "\n"
                         "\t" "xor rdx,rdx" "\n"
                         "\t" "STRING_REF dl,rbx,rcx" "\n"
                         "\t" "ADD_LITERAL_TYPE T_CHAR, rdx" "\n"
                         "\t" "mov rax,rdx" "\n" 
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                    
                    
                    
                    
                    
                    
(define asm-vector-length
    (lambda ()
        (let* (
            (function-name "yaniv_vector_length")
            (counter (get-and-increase-counter "init-func"))
            (asm-closure (build-lambda-closure-for-asm-func  function-name))
            (asm-body (apply string-append
                    `(                   
                        "\t" ";Body Function: ",function-name "\n"
                        "Lambda_Body_Start_",function-name ":\n"
                        "\t" "START_FUNC" "\n"
                        "\t" "push r8" "\n"
                        "\t" "mov r8, qword[rbp + (4 * 8)]" "\n"
                        "\t" "VECTOR_LENGTH r8" "\n"
                        "\t" "ADD_LITERAL_TYPE T_INTEGER, r8" "\n"
                        "\t" "mov rax, r8" "\n"
                        "\t" "pop r8" "\n"
                        "\t" "END_FUNC" "\n"
                        "Lambda_Body_End_",function-name ":\n"
                        )))
            (ans 
                (apply string-append
                    `( 
                    ,asm-closure
                    ,asm-body
                    "\t" "mov [",function-name "],rax" "\n"))))
                    ans)))

                    

;Work
 (define asm-vector-ref
     (lambda ()
         (let* (
             (function-name "yaniv_vector_ref")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov rbx, qword[rbp + (4 * 8)]" "\t;hold the vector\n"
                         "\t" "mov rcx, qword[rbp + (5 * 8)]" "\t;hold the index\n"
                         "\t" "DATA rcx" "\n"
                         "\t" "VECTOR_REF rdx,rbx,rcx" "\n"
                         "\t" "mov rax,rdx" "\n" 
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                    
                    

                    
;Work
(define asm-make-string
     (lambda ()
         (let* (
             (function-name "yaniv_make_string")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + (3 * 8)]" "\t;hold number of arguments\n"
                         "\t" "mov r9, qword[rbp + (4 * 8)]" "\t;hold the length as sobInteger\n"
                         "\t" "mov r8, qword[rbp + (5 * 8)]" "\t;hold the SobChar\n"
                         "\t" "cmp r14,1" "\n"
                         "\t" "jne REGULAR_MAKE_STRING",counter "\t; check if num of arguments in 1, need to return chars of 0\n"
                         "\t" "mov r8, 0" "\n"
                         "\t" "ADD_LITERAL_TYPE T_CHAR ,r8" "\n"
                         "REGULAR_MAKE_STRING",counter ":\n"
                         "\t" "DATA r8" "\t;Save the char\n"
                         "\t" "DATA r9" "\t;Save the number\n"
                         "\t" "lea rdi, [r9*8]" "\t;mul 8 for each char\n"
                         "\t" "MY_MALLOC r11" "\t;r11 saves the chars\n"
                         "\t" "xor r15,r15" "\n"
                         "START_LOOP_CREATE_STRING",counter ":\n"
                         "\t" "cmp r15,r9" "\n"
                         "\t" "jge END_LOOP_CREATE_STRING",counter "\n"
                         "\t" "mov [r11+r15], r8b" "\t;insert a char to his position in the new string\n"                           
                         "\t" "inc r15" "\n"
                         "\t jmp START_LOOP_CREATE_STRING",counter "\n"
                         "END_LOOP_CREATE_STRING" ,counter ":\n"
                         "\t" "sub r11, start_of_data" "\t;fix the pointer position accourding to malloc\n"
                         "\t" "xor r12,r12" "\n"
                         "\t" "mov r12,r9" "\n"
                         "\t" "shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)" "\n"
                         "\t" "or r12, r11" "\n"
                         "\t" "shl r12, TYPE_BITS" "\n"
                         "\t" "or r12 , T_STRING" "\n"
                         "\t" "push r12" "\n" 
                         "\n" "mov rdi,8" "\n"
                         "\t" "MY_MALLOC rax" "\t;rax saves a pointer to the new sobString\n"
                         "\t" "pop r12" "\n"
                         "\t" "mov rax,r12 " "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))                
                    
                    
                    
                    
                    
                    
                    
                    
;Work
(define asm-set-string
     (lambda ()
         (let* (
             (function-name "yaniv_string_set")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + (4 * 8)]" "\t;hold the string\n"
                         "\t" "mov r9, qword[rbp + (5 * 8)]" "\t;hold the SobInteger that represent the index to set\n"
                         "\t" "mov r8, qword[rbp + (6 * 8)]" "\t;hold the SobChar\n"
                         "\t" "DATA r8" "\t;r8 hold now the char itself\n"
                         "\t" "DATA r9" "\t;r9 hold now the index itself\n"
                         "\t" "STRING_ELEMENTS r14" "\n"
                         "\t" "mov [r14+ r9], r8b" "\n"
                         "\t" "mov rax, [sobVoid] " "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                    
                    
                    
                    
;Work
 (define asm-make-vector
     (lambda ()
         (let* (
             (function-name "yaniv_make_vector")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + (3 * 8)]" "\t;hold number of arguments\n"
                         "\t" "mov r9, qword[rbp + (4 * 8)]" "\t;hold the length as sobInteger\n"
                         "\t" "mov r8, qword[rbp + (5 * 8)]" "\t;hold the Sob to add\n"
                         "\t" "cmp r14,1" "\n"
                         "\t" "jne REGULAR_MAKE_VECTOR",counter "\t; check if num of arguments in 1, need to return integers of 0\n"
                         "\t" "mov r8, 0" "\n"
                         "\t" "ADD_LITERAL_TYPE T_INTEGER ,r8" "\n"
                         "REGULAR_MAKE_VECTOR",counter ":\n"
                         "\t" "DATA r9" "\t;Save the number\n"
                         "\t" "shl r9,3" "\n"
                         "\t" "mov rdi, r9" "\n"
                         "\t" "MY_MALLOC r11" "\t;r11 saves the SOBs in the vector \n"
                         "\t" "xor r15,r15" "\n"
                         "START_LOOP_CREATE_VECTOR",counter ":\n"
                         "\t" "cmp r15,r9" "\n"
                         "\t" "jge END_LOOP_CREATE_VECTOR",counter "\n"
                         
                           "\t" "mov rdi, 8" "\n"
                           "\t" "MY_MALLOC rax" "\n"
                           "\t" "mov [rax], r8" "\n"
                           "\t" "mov [r11+ r15], rax" "\t;insert a sob to his position in the new vector\n"                     
                         "\t" "add r15, 8" "\n"
                         "\t jmp START_LOOP_CREATE_VECTOR",counter "\n"
                         "END_LOOP_CREATE_VECTOR" ,counter ":\n"
                         "\t" "sub r11, start_of_data" "\t;fix the pointer position accourding to malloc\n"                        
                         "\t" "xor r12,r12" "\n"
                         "\t" "shr r9,3" "\n" 
                         "\t" "mov r12,r9" "\n"
                         "\t" "shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)" "\n"
                         "\t" "or r12, r11" "\n"
                         "\t" "shl r12, TYPE_BITS" "\n"
                         "\t" "or r12 , T_VECTOR" "\n"
                         "\t" "push r12" "\n" 
                         "\n" "mov rdi,8" "\n"
                         "\t" "MY_MALLOC rax" "\t;rax saves a pointer to the new Vector\n"
                         "\t" "pop r12" "\n"
                         "\t" "mov rax,r12 " "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                     
                     
                     
;Work
(define asm-set-vector
     (lambda ()
         (let* (
             (function-name "yaniv_vector_set")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + (4 * 8)]" "\t;hold the vector\n"
                         "\t" "mov r9, qword[rbp + (5 * 8)]" "\t;hold the SobInteger that represent the index to set\n"
                         "\t" "mov r8, qword[rbp + (6 * 8)]" "\t;hold the Sob to put\n"
                         "\t" "DATA r9" "\t;r9 hold now the index itself\n"
                         "\t" "VECTOR_ELEMENTS r14" "\n"
                         "\t" "lea r9,[r9*8]" "\t;r9 hold the position(index*bytes) in the vector\n"
                         
                         "\t" "push r9" "\t;save the index\n"
                         "\t" "mov rdi, 8" "\n"
                         "\t" "MY_MALLOC rax" "\n"
                         "\t" "mov [rax], r8" "\n"
                         "\t" "pop r9" "\t;pop the index\n"
                         "\t" "mov [r14+ r9], rax" "\t;insert a sob to his position in the new vector\n"      
                         "\t" "mov rax, [sobVoid] " "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                     
                     
;Work
 (define asm-vector
     (lambda ()
         (let* (
             (function-name "yaniv_convert_list_to_vector")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + (3 * 8)]" "\t;hold number of arguments\n"
                         "\t" "shl r14,3" "\n"
                         "\t" "mov rdi, r14" "\n"
                         "\t" "MY_MALLOC r11" "\t;r11 saves the SOBs in the vector \n"
                         "\t" "xor r15,r15" "\n"
                         "START_LOOP_CREATE_VECTOR",counter ":\n"
                         "\t" "cmp r15, r14 " "\n"
                         "\t" "jge END_LOOP_CREATE_VECTOR",counter "\n"
                         "\t" "mov rdi, 8" "\n"
                         "\t" "MY_MALLOC rax" "\n"
                         "\t" "mov rdi,  qword[rbp +  4*8 + r15]" "\n"
                         "\t" "mov [rax],    rdi" "\n"
                         "\t" "mov [r11+ r15], rax" "\t;insert a sob to his position in the new vector\n" 
                         "\t" "add r15, 8" "\n"
                         "\t jmp START_LOOP_CREATE_VECTOR",counter "\n"
                         "END_LOOP_CREATE_VECTOR" ,counter ":\n"
                         "\t" "sub r11, start_of_data" "\t;fix the pointer position accourding to malloc\n"                        
                         "\t" "xor r12,r12" "\n"
                         "\t" "shr r14,3" "\t;save the number of elements in the vector\n" 
                         "\t" "mov r12,r14" "\n"
                         "\t" "shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)" "\n"
                         "\t" "or r12, r11" "\n"
                         "\t" "shl r12, TYPE_BITS" "\n"
                         "\t" "or r12 , T_VECTOR" "\n"
                         "\t" "push r12" "\n" 
                         "\n" "mov rdi,8" "\n"
                         "\t" "MY_MALLOC rax" "\t;rax saves a pointer to the new Vector\n"
                         "\t" "pop r12" "\n"
                         "\t" "mov rax,r12 " "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))

;Work
 (define asm-convert-symbol-to-string
     (lambda ()
         (let* (
             (function-name "yaniv_symbol_to_string")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + 4 * 8]" "\t;hold the sobSymbol\n"
                         "\t" "DATA r14" "\n"
                         "\t" "add r14,start_of_data" "\n"
                         "\t" "mov rax, [r14]" "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                     
                     
                     
;Work
 (define asm-convert-string-to-symbol
     (lambda ()
         (let* (
             (function-name "yaniv_string_to_symbol")
             (counter (get-and-increase-counter "init-func"))
             (asm-closure (build-lambda-closure-for-asm-func  function-name))
             (asm-body (apply string-append
                     `(                   
                         "\t" ";Body Function: ",function-name "\n"
                         "Lambda_Body_Start_",function-name ":\n"
                         "\t" "START_FUNC" "\n"
                         "\t" "mov r14, qword[rbp + 4 * 8]" "\t;hold the sobString\n"
                         "\t" "mov rax, [my_symbols_link]" "\t;hold the current symbol\n"
                         "START_LOOP" ,counter ":\n"
                         "\t" "cmp rax,sobNil" "\n"
                         "\t" "je END_OF_LIST",counter "\n"
                         "\t" "push rax" "\t;push the symbol\n"
                         "\t" "mov rdi,[rax]" "\n"
                         "\t" "mov rax, rdi" "\n"
                         "\t" "DATA rax" "\n"
                         "\t" "add rax,start_of_data" "\n"
                         "\t" "mov rdi, [rax]" "\n"
                         "\t" "mov rax, rdi" "\n"
                         "\t" "cmp rax, r14" "\n"
                         "\t" "je SYMBOL_FOUND" ,counter "\n"
                         "\t" "pop rax" "\t;pop the current symbol\n"
                         "\t" "add rax,8" "\t;get the pointer to the next symbol\n"
                         "\t" "mov rax, [rax]" "\t;get the symbol inside the pointer link\n"
                         "\t" "jmp START_LOOP",counter "\n"
                         "END_OF_LIST",counter ":\n"
                         "\t" "push r14" "\t;push string for create a symbol\n"
                         "\t" "call CREATE_SYMBOL" "\t;symbol will be in rax\n"
                         "\t" "pop r14" "\n"
                         "\t" "END_FUNC" "\n"
                         "SYMBOL_FOUND" ,counter ":\n"
                         "\t" "pop rax" "\t;pop the current symbol\n"
                         "\t" "mov rdi, [rax]" "\n"
                         "\t" "mov rax,rdi" "\n"
                         "\t" "END_FUNC" "\n"
                         "Lambda_Body_End_",function-name ":\n"
                         )))
             (ans 
                 (apply string-append
                     `( 
                     ,asm-closure
                     ,asm-body
                     "\t" "mov [",function-name "],rax" "\n"))))
                     ans)))
                     
 ;Work
 (define asm-apply
      (lambda ()
          (let* (
              (function-name "yaniv_apply")
              (counter (get-and-increase-counter "init-func"))
              (asm-closure (build-lambda-closure-for-asm-func  function-name))
              (asm-body (apply string-append
                      `(                   
                          "\t" ";Body Function: ",function-name "\n"
                          "Lambda_Body_Start_",function-name ":\n"
                          "\t" "START_FUNC" "\n"
                          "\t" "mov r15, [rbp] " "\n"
                          "\t" "mov r8, qword[rbp + 1 * 8]" "\t;save the return address\n"
                          "\t" "mov r9, qword[rbp + 4 * 8]" "\t;hold the function\n"
                          "\t" "mov r10, qword[rbp + 5 * 8]" "\t;hold the list\n"
                          "\t" "push r10" "\n"
                          "\t" "call list_length_asm" "\t;length will be in rax\n"
                          "\t" "pop r10" "\n"
                          "\t" "mov r11, rax" "\t;rax will hold the list length\n"
                          "\t" "lea rsp, [rsp+ 6*8]" "\t;skip over s,f,arg count,env\n"
                          ;"\t" "inc r11" "\n"
                          "\t" "mov r12, r11" "\t;r12 args count\n"
                          ;"\t" "push qword[sobNil]" "\t;push sobNil same as applic\n" 
                          "LOOP_PUSH_ARGS",counter ":\n"
                          "\t" "cmp r12,0" "\n"
                          "\t" "je END_LOOP_PUSH_ARGS" ,counter "\n"
                          "\t" "mov r13, r10" "\n"
                          "\t" "CAR r13" "\n"
                          "\t" "push r13" "\n"
                          "\t" "CDR r10" "\n"
                          "\t" "dec r12" "\n"
                          "\t" "jmp LOOP_PUSH_ARGS",counter "\n"
                          "END_LOOP_PUSH_ARGS",counter ":\n"
						  
						  
                           "\t" "mov r13, rsp" "\n"
                           "\t" "lea r14, [r13+ r11*8 -8]" "\n"
                          
                           "START_FLIP_STACK" ,counter ":\n"
                           "\t" "cmp r14, r13" "\n"
                           "\t" "jle END_FLIP_STACK",counter "\n"
                           "\t" "mov rcx , qword[r13] " "\n"
                           "\t" "mov rsi, qword[r14]" "\n"
                           "\t" "mov qword[r13], rsi" "\n"
                           "\t" "mov qword[r14], rcx" "\n"
                           "\t" "add r13, 8" "\n"
                           "\t" "sub r14,8" "\n"
                           "\t" "jmp START_FLIP_STACK" ,counter "\n"
                           "END_FLIP_STACK",counter ":\n"
                          
                          
                          "\t" "push r11" "\t;push number of arguments in list\n" 
                          "\t" "mov r10, r9" "\n"
                          "\t" "CLOSURE_ENV r9" "\n"
                          "\t" "push r9" "\t;push the CLOSURE_ENV of f\n"
                          "\t" "push r8" "\t;save the return address\n"
                          "\t" "CLOSURE_CODE r10" "\n"
                          "\t" "mov rax, r10" "\n"
                          "\t" "mov rbp, r15" "\n" 
                          "\t" "jmp rax" "\n"
                          "Lambda_Body_End_",function-name ":\n"
                          )))
              (ans 
                  (apply string-append
                      `( 
                      ,asm-closure
                      ,asm-body
                      "\t" "mov [",function-name "],rax" "\n"))))
                      ans)))
                        
                        
;Not working
;Need to add all basic function.
(define initiate-basic-scheme-functions
    (lambda (stringed-file)
        `(
            ,@(map my_pipeline 
                library-function-impementation
            )
            ,@stringed-file)))

;Not working
;Need to add all basic function.
(define initiate-basic-scheme-functions-no-args
    (lambda ()
            (map my_pipeline 
                library-function-impementation
            )
            ))
            
            
(define library-function-impementation
`(
;; #|
                        (define zero? (lambda(x) (eq? x 0)))
                           (define not (lambda(x) 
                                           (if (eq? x #f)
                                               #t
                                               #f)))
       
                           (define number? (lambda(x) (or (integer? x) (fraction? x))))
                           (define rational? (lambda(x) (number? x))) ;TODO: what is the difference number vs rational?
                           (define denominator (lambda(x) 
                                                   (if (integer? x)
                                                       1
                                                       (if (fraction? x)
                                                           (cdr x)
                                                           "error"))))
                           (define numerator (lambda(x) 
                                                   (if (integer? x)
                                                       x
                                                       (if (fraction? x)
                                                           (car x)
                                                           "error"))))
                           (define list (lambda lst
                                               lst))
                                               
                                              
                           (define foldl (lambda (func accum lst)
                                               (if (null? lst)
                                                   accum
                                                   (foldl func
                                                       (func accum (car lst)) 
                                                       (cdr lst)))))
                                                       
                           (define list_length
                               (lambda (lst)
                                   (if (null? lst)
                                       0
                                       (+ 1 (list_length (cdr lst))))))
                                   
                                                       
                           (define map_yaniv 
                               (lambda (func lst)
                                   (if (null? lst)
                                       '()
                                       (cons (func (car lst)) (map_yaniv func (cdr lst))))))
                                   
                           (define append_yaniv
                               (lambda (lst1 lst2)
                                   (if (null? lst1)
                                       lst2
                                       (cons (car lst1) (append_yaniv (cdr lst1) lst2)))))
                                       
                           (define append 
                               (lambda lst 
                                   (if (= (list_length lst) 1) 
                                       (car lst) 
                                       (if (= (list_length lst) 0) 
                                           '() 
                                           (foldl (lambda (xs x)  (append_yaniv xs x) ) '() lst)))))
                                      
                           (define map
                               (lambda (f . s)
                                   (maplist f s)))
                               
                           (define maplist
                               (lambda (f  s)
                                   (if (null? (car s))
                                       '()
                                       (cons (apply f (map1 car s))
                                             (maplist f (map1 cdr s))))))
                                             
                           (define map1
                               (lambda (f  s)
                                   (if (null? s)
                                       '()
                                       (cons (f (car s))
       (map1 f (cdr s))))))
                           
                           (define + (lambda lst
                                           (foldl yaniv_plus 0 lst)))
                                           
                           (define - 
                               (lambda (x . lst)
                                   (if (null? lst)
                                       (* -1 x)
                                       (foldl + x (map_yaniv (lambda (y) (* -1 y)) lst)))))
                                       
                           (define * (lambda lst
                                           (foldl yaniv_mult 1 lst)))
                                           
                           (define / (lambda (x . lst)
                                           (if (null? lst)
                                               (yaniv_div 1 x)
                                               (* 1 (yaniv_div x (foldl * 1 lst))))))
                                               
                           (define > (lambda (x . lst)
                                           (if (null? lst)
                                               #t
                                               (greaterHalper123 x lst))))
       					
                                               
                           (define greaterHalper123 (lambda (x lst)
                                                       (if (null? lst)
                                                           #t
                                                           (if (yaniv_greater x (car lst))
                                                               (greaterHalper123 (car lst) (cdr lst))
                                                               #f))))
                                                               
                           (define < (lambda (x . lst)
                                           (if (null? lst)
                                               #t
                                               (smallerHalper123 x lst))))
       					
                                               
                           (define smallerHalper123 (lambda (x lst)
                                                       (if (null? lst)
                                                           #t
                                                           (if (yaniv_smaller x (car lst))
                                                               (smallerHalper123 (car lst) (cdr lst))
                                                               #f))))
                                                               
                           (define = (lambda (x . lst)
                                           (if (null? lst)
                                               #t
                                               (equivalentHalper123 x lst))))
       					
                                               
                           (define equivalentHalper123 (lambda (x lst)
                                                       (if (null? lst)
                                                           #t
                                                           (if (yaniv_equivalent x (car lst))
                                                               (equivalentHalper123 (car lst) (cdr lst))
                                                               #f))))
;;                                                                |#
                           
                    
                ))
