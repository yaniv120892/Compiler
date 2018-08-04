(load "qq.scm")


(define parse
    (lambda (sexpr)
	
        (cond
            
			((or
                (const? sexpr)
                (null? sexpr)
                (vector? sexpr)
                (eq? (void) sexpr))
                    (constants sexpr))
            ((symbol? sexpr)
                (variables sexpr))
            ((is-if3? sexpr)
                (if3-tag-parser sexpr))
            ((is-if4? sexpr)
                (if4-tag-parser sexpr))
			((is-quasi? sexpr)
				(quasi-parser sexpr))
            ((is-or-disjunction? sexpr)
                (disjunction-or-tag-parser sexpr))
            ((is-and-disjunction? sexpr)
                (disjunction-and-tag-parser sexpr))
			((is-lambda-forms? sexpr)
                (lambda-forms-tag-parser sexpr))
			((is-begin? sexpr)
                (begin-tag-parser sexpr))			
			((is-define? sexpr)
                (define-tag-parser sexpr))
			((is-set!? sexpr)
                (set!-tag-parser sexpr))
			((is-applic? sexpr)
                (applic-tag-parser sexpr))			
			((is-let? sexpr)
                (let-tag-parser sexpr))
			((is-let*? sexpr)
                (let*-tag-parser sexpr))
			((is-letrec? sexpr)
                (letrec-tag-parser sexpr))
			((is-cond-disjunction? sexpr)
				(disjunction-cond-tag-parser sexpr))

        )
    )
)
;Work
(define constants
    (lambda(const)
        (cond 
            ((and (pair? const) (eq? (car const) 'quote))
                    `(,'const ,@(cdr const)))
        (else
        
            (list 'const const))))
)
;Work
(define variables
    (lambda(var)
        (if (not (reserved-words var))
            (list 'var var)))
)
;Work
(define reserved-words
    (lambda (word)
        (or
            (eq? 'and word)
            (eq? 'begin word)
            (eq? 'cond word)
            (eq? 'define word)
            (eq? 'do word)
            (eq? 'else word)
            (eq? 'if word)
            (eq? 'lambda word)
            (eq? 'let word)
            (eq? 'let* word)
            (eq? 'letrec word)
            (eq? 'or word)
            (eq? 'quasiquote word)
            (eq? 'unquote word)
            (eq? 'unquote-splicing word)
            (eq? 'quote word)
            (eq? 'set! word)
        )
    )
)
;Work
(define if3-tag-parser
    (lambda(condition)
            (let 
                ((<test> (car (cdr condition)))
                (<dit> (car (cddr condition)))
                )
                `(if3 ,(parse <test>) ,(parse <dit>) ,(parse (void)))
            )
    )
)



;Work
(define if4-tag-parser
    (lambda(condition)
            (let 
                ((<test> (car (cdr condition)))
                (<dit> (car (cddr condition)))
                (<dif> (car (cdddr condition)))
                )
                `(if3 ,(parse <test>) ,(parse <dit>) ,(parse <dif>))
            )
    )
)


;Work
(define is-if3?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'if)
            (eq? (length sexpr) 3))
    )
)

;Work
(define is-if4?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'if)
            (eq? (length sexpr) 4))
    )
)

;Work
(define is-or-disjunction?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'or)
        )
    )
)

;Work
(define is-and-disjunction?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'and)
        )
    )
)


;Work
(define disjunction-or-tag-parser
    (lambda(or-sexpr)
        (cond
			(( eq? (cdr or-sexpr) '()) 
				(parse #f))
			(( eq? (cdr (cdr or-sexpr)) '()) 
				(parse (car(cdr or-sexpr))))
			(else
				(let 
					((peExprs 
						(map 
							(lambda(x)		
								(if pair? x)
									(parse `(' ,x))
									(parse x)
							)
							(cdr or-sexpr)
						)
					))
					`(or ,peExprs)
				)
			)
		)
	)		
)

;Work
(define disjunction-and-tag-parser
    (lambda(and-sexpr)
        (cond 
			((> (length (cdr and-sexpr)) 2) 
				(let 
					((test (parse (car (cdr and-sexpr))))
					(dit (parse `(and ,@(cdr (cdr and-sexpr)))))
					(dif (parse '#f))
					)
					`(if3 ,test ,dit ,dif)
				)
			)
			((eq? (length (cdr and-sexpr)) 2) 
				(let 
					((test (parse (car (cdr and-sexpr))))
					(dit (parse (car (cdr (cdr and-sexpr)))))
					(dif (parse '#f))
					)
					`(if3 ,test ,dit ,dif)
				)
			)
			((eq? (length (cdr and-sexpr)) 1) 
				 (parse (car (cdr and-sexpr)))
			)
			(else  (parse '#t))
		)
	)
)


;Work
(define is-lambda-forms?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'lambda)
        )
    )
)


;Work
(define lambda-forms-tag-parser
    (lambda(sexpr)
		(cond 
			((is-lambda-variadic? (cdr sexpr))
				(lambda-variadic-tag-parser sexpr))
			((is-lambda-optional? (car (cdr sexpr)))
				(lambda-opt-tag-parser sexpr))
			(else (lambda-simple-tag-parser sexpr))
		)
	)		
)

;Work
(define lambda-simple-tag-parser
	(lambda(sexpr)
	    (let 
            (
				(variables (car (cdr sexpr)))
				(body (parse `(begin ,@(cdr (cdr sexpr)))))
			)
			`(lambda-simple ,variables ,body)
		)
	)
)

;Work
(define is-lambda-optional?
    (lambda(variables)
            (not (list? variables))
    )
)

;Work
(define remove-rest
	(lambda (lst acc)
		(cond 
			((and (pair? lst) (not (eq? (cdr lst) '())))
				(remove-rest (cdr lst) (append acc (list (car lst))))
				)
			(else
				acc)
		)
	)
)

;Work
(define get-rest
	(lambda (lst)
		(cond 
			((and (pair? lst) (not (eq? (cdr lst) '())))
				(get-rest (cdr lst))
			)
			(else
				lst)
		)
	)
)
			
			

;Work
(define lambda-opt-tag-parser
	(lambda(sexpr)
		(let 
            (
				(variables (remove-rest (car (cdr sexpr)) '()))
				(rest (get-rest(car (cdr sexpr))))
				(body (parse `(begin ,@(cdr (cdr sexpr)))))
			)
			`(lambda-opt ,variables ,rest ,body)
		)
	)
)

;Work
(define is-lambda-variadic?
    (lambda(variables)
			(and (not (pair? (car variables))) (not (list? (car variables))))
    )
)

;Work
(define lambda-variadic-tag-parser
	(lambda(sexpr)		
		(let 
			(
				(body (parse `(begin ,@(cdr (cdr sexpr)))))
			)
			`(lambda-opt ,'() ,(car (cdr sexpr)) ,body)
		)
	)
)


;Work
(define is-begin?
    (lambda(sexpr)
			(and (pair? sexpr ) (eq? (car sexpr) 'begin))
    )
)


;Work
(define remove-inner-begin
    (lambda(sexpr acc)
		(cond 
			((eq? sexpr '()) 
				acc)
			((list? (car sexpr))
				(if (is-begin? (car sexpr)) 
					(remove-inner-begin (cdr sexpr) (remove-inner-begin (cdr (car sexpr)) acc))
					(remove-inner-begin (cdr sexpr) (append acc (list (car sexpr))))))
			(else
				(remove-inner-begin (cdr sexpr) `(,@acc ,(car sexpr))))
		)
    )
)

;Not sure
(define begin-tag-parser
	(lambda(begin-sexpr)
		(cond 
			((eq? (cdr begin-sexpr) '()) 
				(parse (void)))
			(else
				(let
					((converted-begin-sexpr `(begin ,@(remove-inner-begin (cdr begin-sexpr) '() ))))
					(cond 
						((> (length (cdr converted-begin-sexpr)) 1)
							(let (
								(body 
									(map 
										(lambda(x)
											(parse x)	
										)
									(cdr converted-begin-sexpr)
									)
								))
								`(seq ,body)
							)
						)
						(else
                                                        (if (eq? (cdr converted-begin-sexpr) '())
                                                            (parse (car converted-begin-sexpr))
                                                            (parse (car (cdr converted-begin-sexpr))))
						)
					)
				)
			)
		)
	)
)
						
		
			
			
			
;Work
(define is-define?
    (lambda(sexpr)
			(eq? (car sexpr) 'define)
    )
)

;Work
(define define-tag-parser
	(lambda(define-sexpr)
		(cond 
			((pair? (car (cdr define-sexpr)))
				(let 
					(
					(varName (car (car (cdr define-sexpr))))
					(varsForLambda (cdr (car (cdr define-sexpr))))
					(exprForLambda (cdr (cdr define-sexpr)))
					)
				(parse `(define ,varName ,`(lambda  ,varsForLambda ,@exprForLambda)))
				)
			)
			(else
				(let 
					(
					(varName (parse 
							(car (cdr define-sexpr)))
							)
					(peExpr (parse 
								`(begin ,@(cdr (cdr define-sexpr))))
								)
					)
				`(define ,varName ,peExpr)
				)
			)
		)
	)
)		
;Work
(define is-set!?
    (lambda(sexpr)
			(eq? (car sexpr) 'set!)
    )
)

;Work
(define set!-tag-parser
	(lambda(set!-sexpr)
		
		(let 
			(
			(varName (parse 
					(car (cdr set!-sexpr)))
					)
			(peExpr (parse 
						(car (cdr (cdr set!-sexpr))))
						)
			)
		`(set ,varName ,peExpr)
		)
	)
)
			
			
			
			
			

			
			
			
			
			
;Work
(define is-applic?
    (lambda(sexpr)
			(not (reserved-words (car sexpr)))
    )
)
;Work
(define applic-tag-parser
	(lambda(applic-sexpr)		
		(let 
			((functionName (parse (car applic-sexpr)))
			(arguments 
				(map
					(lambda(x) 
						(if pair? x)
						(parse `(' ,x))
						(parse x)							
					)
					(cdr applic-sexpr)
				)
			))
		`(applic ,functionName ,arguments)
		)
	)
)
			
			
			
			
			
			
;Work
(define is-let?
    (lambda(sexpr)
			(eq? (car sexpr) 'let)
    )
)


;Work
(define check-duplicate-vars
	(lambda (vars lst)
		(if (eq? vars '())  
				#f
				(if (member (car vars) lst)
				#t
				(check-duplicate-vars (cdr vars ) (cons (car vars) lst)))
		)
	)
)
;Work
(define let-tag-parser
	(lambda(let-sexpr)
		(let 
			((vars (map 
						(lambda(x)
							(car x)
						)
						(car (cdr let-sexpr))
					)
			)
			(parsed-vals (map 
							(lambda(x)
								(parse (car (cdr x)))						
							)
							(car (cdr let-sexpr))
						)
			)
			(expr (cdr (cdr let-sexpr)))
			)
			(if (check-duplicate-vars vars '())
				(raise(make-message-condition 'let-has-duplicate-vars))
				(let ((ans `(applic ,(parse `(lambda ,vars ,@expr )) ,parsed-vals)))
                                    ans)
				
			)

		)
	)
)
;Work
(define is-let*?
    (lambda(sexpr)
			(eq? (car sexpr) 'let*)
    )
)
;Work
(define let*-sexpr->multiple-let-sexpr
	(lambda(let*-sexpr)
		(cond 
			((< (length (car (cdr let*-sexpr))) 2)
						`(let ,@(cdr let*-sexpr)))
			(else 
				(let 
					((first-var-val (list (car (car (cdr let*-sexpr)))))
					(rest-var-val (cdr (car (cdr let*-sexpr))))
					(exprs (cdr (cdr let*-sexpr))))				
					`(let ,first-var-val ,(let*-sexpr->multiple-let-sexpr `(let* ,rest-var-val ,@exprs)))
				)
			)
		)
	)
)

;Work
(define let*-tag-parser

	(lambda(let*-sexpr)
		(cond 
			((< (length (car (cdr let*-sexpr))) 2)
						(parse `(let ,@(cdr let*-sexpr))))
			(else
				(let
					((converted-let* (let*-sexpr->multiple-let-sexpr let*-sexpr)))
						(parse converted-let*)
				)
			)
		)
	)
)





;Work
(define is-letrec?
    (lambda(sexpr)
			(eq? (car sexpr) 'letrec)
    )
)





;Work
(define letrec-sexpr->let-sexpr
	(lambda(letrec-sexpr)
		(let 
			((vars (map 
						(lambda(x)
							(car x)
						)
						(car (cdr letrec-sexpr))
					)
			)
			(vals (map 
						(lambda(x)
							(car (cdr x))					
						)
						(car (cdr letrec-sexpr))
					)
			)
			(expr (cdr (cdr letrec-sexpr)))
			)

			(if (check-duplicate-vars vars '())
				(raise(make-message-condition 'letrec-has-duplicate-vars))
				(let 
					((vars-with-garbage 
						(map 
							(lambda(x)
								`(,x #f)
							)
							vars					
						))
					(vals-with-set (map 
											(lambda(x)
												`(set! ,@x)
											)
										(car (cdr letrec-sexpr))					
										))
					)
					`(let ,vars-with-garbage ,@vals-with-set ,(list `(lambda () ,@expr)))
				)
			)
		)
	)
)

;Work
(define letrec-tag-parser

	(lambda(letrec-sexpr)
		(let
			((converted-letrec (letrec-sexpr->let-sexpr letrec-sexpr)))
				(parse converted-letrec)
		)
	)
)








(define is-cond-disjunction?
    (lambda(sexpr)
        (and 
            (pair? sexpr) 
            (eq? (car sexpr) 'cond)
        )
    )
)



				










(define disjunction-cond-tag-parser
    (lambda(cond-sexpr)
		(cond 
			((eq? (cdr cond-sexpr) '())
				(parse (void)))
			(else
				(cond 
					((eq? (car (car (cdr cond-sexpr))) 'else)
						(parse `(begin ,@(cdr (car (cdr cond-sexpr))))))
					(else
						(let
							((parsed-first-condition (parse (car (car (cdr cond-sexpr)))))
							(parsed-first-exprs (parse `(begin ,@(cdr (car (cdr cond-sexpr))))))
							(rest-conditions (cdr (cdr cond-sexpr))))
						`(if3 ,parsed-first-condition ,parsed-first-exprs  ,(parse `(cond ,@rest-conditions))))
					)
				)
			)
		)
	)
)
						
					
			
(define quasi-parser
 (lambda(quasi-exp)
  (parse (expand-qq (car (cdr quasi-exp))))))
  
;Work
(define is-quasi?
    (lambda(sexpr)
        (and 
            (pair? sexpr)
            (eq? (car sexpr) 'quasiquote)
		)
	)
)







