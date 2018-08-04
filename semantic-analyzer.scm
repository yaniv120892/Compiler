(define parse-remove-applic 
	(lambda(exp)
		(remove-applic-lambda-nil (parse exp))
	)
)


(define remove-applic-lambda-nil
	(lambda (exp)
		(cond
			((eq? exp '()) exp)
			((is-const? exp) exp)
			((is-var? exp) exp)
			((is-set? exp)
				`(,(car exp) ,(car (cdr exp)) ,(remove-applic-lambda-nil (car (cdr (cdr exp))) )))
			((is-if? exp)
				`(,(car exp) ,(remove-applic-lambda-nil (car (cdr exp))) 
							,(remove-applic-lambda-nil (car (cdr (cdr exp))) )
							,(remove-applic-lambda-nil (car (cdr (cdr (cdr exp)))))))
                        ((is-or? exp)
                            (let ((or-exp (car (cdr exp))))
                                `(,(car exp) ,(map remove-applic-lambda-nil or-exp))))
                        ((is-define? exp)
                            `(,(car exp) ,(car (cdr exp)) ,(remove-applic-lambda-nil (car (cdr (cdr exp))))))
			((is-seq? exp)
				`(,(car exp) ,(map remove-applic-lambda-nil (car (cdr exp))) ))
			((is-lambda-simple? exp)
				`(,(car exp) ,(car (cdr exp)) ,(remove-applic-lambda-nil (car (cdr (cdr exp))))))
			((is-lambda-opt? exp)
                            (let ((normal-arg (car (cdr exp)))
                                  (optional-arg (car (cdr (cdr exp))))
                                  (body-after-change (remove-applic-lambda-nil (car (cdr (cdr (cdr exp)))))))
                                  `(,(car exp) ,normal-arg ,optional-arg ,body-after-change)))
			((is-applic (car exp))
					(let ((function (car (cdr exp)))
							(parameters (car (cdr (cdr exp)))))
						(if (is-lambda-simple? function)
							(if (eq? (car (cdr function)) '())
                                                            (if (eq? parameters '())
								(car (cdr (cdr (remove-applic-lambda-nil function))))
								`(,(car exp) ,(remove-applic-lambda-nil function) ,( map remove-applic-lambda-nil parameters)))
                                                            `(,(car exp) ,(remove-applic-lambda-nil function) ,( map remove-applic-lambda-nil parameters)))
							`(,(car exp) ,(remove-applic-lambda-nil function) ,(map remove-applic-lambda-nil parameters)))))
			((is-box-get? exp)
				exp)
			((is-box-set? exp)
				`(,(car exp) ,(car (cdr exp)) ,(remove-applic-lambda-nil (car (cdr (cdr exp))))))
			((is-box? exp)
				exp)
		)
	)	 
)







(define box-set
    (lambda (exp)
    
        (cond 
            ((eq? exp '()) exp)
		((is-const? exp) exp)
		((is-var? exp) exp)
 		((is-define? exp)
                    (let ((argument (car (cdr exp)))
                        (body (car (cdr (cdr exp)))))
 
                            (if (and (has-set? argument body) (has-get? argument body))
 				(let ((box-argument `(set ,`(var ,argument) ,`(box ,`(var ,argument))))
                                      (new-body (add-get-set-box body argument)))
                                        `(,(car exp) ,box-argument ,new-body))
 					`(,(car exp) ,(car (cdr exp)) ,(box-set body)))))
                ((is-set? exp)
                    `(,(car exp) ,(car (cdr exp)) ,(box-set (car (cdr (cdr exp))) )))
                ((is-seq? exp)
                    `(,(car exp) ,(map box-set (car (cdr exp))) ))
                
                ((is-or? exp)
                            (let ((or-exp (car (cdr exp))))
                                `(,(car exp) ,(map box-set or-exp))))
                ((is-if? exp)
                    `(,(car exp) ,(box-set (car (cdr exp))) 
                                ,(box-set (car (cdr (cdr exp))) )
                                ,(box-set (car (cdr (cdr (cdr exp)))))))
                
                
                
                
                
                ((is-lambda-simple? exp)
                    (let ((arguments (car (cdr exp)))
                          (body (car (cdr (cdr exp)))))
                        (let ((arguments-to-replace (filter 
                                                        (lambda (argument)
                                                            (let ((bound? (is-bound? argument body))
                                                                 (has-set-in-body? (has-set? argument body))
                                                                 (has-get-in-body? (has-get? argument body)))
                                                                    (if (eq? bound? #t)
                                                                        (if (eq? has-set-in-body? #t)
                                                                            (if (eq? has-get-in-body? #t)
                                                                                #t
                                                                                #f)
                                                                            #f)
                                                                        #f)))
                                                        arguments)))
                                                                                                                                    
                                                        
                                                        
                            (let ((box-arguments (map 
                                                    (lambda(argument)
                                                        `(set ,`(var ,argument) ,`(box ,`(var ,argument))))
                                                    arguments-to-replace))
                                                              
                                                    
                                (new-body (box-set (add-get-set-box body arguments-to-replace))))
                                
                                
                            
                                
                                
                                
                                (if (eq? box-arguments '())
                                    `(,(car exp) ,(car (cdr exp)) ,new-body)
                                    
                                    
                                    (if (is-seq? new-body)
                                        (let ((body+new-set `(,@box-arguments ,@(car (cdr new-body)))))

                                        
                                            `(,(car exp) ,(car (cdr exp)) ,`(seq  ,body+new-set)))
                                        
                                        (let ((body+new-set `(,@box-arguments ,new-body)))
                                            
                                            
                                            `(,(car exp) ,(car (cdr exp)) ,`(seq  ,body+new-set)))))))))
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    ((is-lambda-opt? exp)
                        (let ((arguments `(,@(car (cdr exp)) ,(car (cdr (cdr exp)))))
			      (body (car (cdr (cdr (cdr exp))))))
                        (let ((arguments-to-replace (filter 
                                                        (lambda (argument)
                                                            (let ((bound? (is-bound? argument body))
                                                                 (has-set-in-body? (has-set? argument body))
                                                                 (has-get-in-body? (has-get? argument body)))                                                              
                                                                    (if (eq? bound? #t)
                                                                        (if (eq? has-set-in-body? #t)
                                                                            (if (eq? has-get-in-body? #t)
                                                                                #t
                                                                                #f)
                                                                            #f)
                                                                        #f)))
                                                        arguments)))
                            (let ((box-arguments (map 
                                                    (lambda(argument)
                                                        `(set ,`(var ,argument) ,`(box ,`(var ,argument))))
                                                    arguments-to-replace))
                                (new-body (box-set (add-get-set-box body arguments-to-replace))))
                                (if (eq? box-arguments '())
                                    `(,(car exp) ,(car (cdr exp)) ,(car (cdr (cdr exp))) ,new-body)
                                        (if (is-seq? new-body)
                                                (let ((body+new-set `(,@box-arguments ,@(car (cdr new-body)))))
                                                    `(,(car exp) ,(car (cdr exp)) ,(car (cdr (cdr exp))) ,`(seq  ,body+new-set)))
                                                (let ((body+new-set `(,@box-arguments ,new-body)))
                                                    `(,(car exp) ,(car (cdr exp)) ,(car (cdr (cdr exp))) ,`(seq  ,body+new-set)))))))))
                    ((is-applic (car exp))
                        (let ((function (box-set (car (cdr exp))))
                            (parameters (map 
                                            (lambda(x) 
                                                (box-set x)) 
                                        (car (cdr (cdr exp))))))
                            `(,(car exp) ,function , parameters)))
                    ((is-box-get? exp) exp)
                    ((is-box-set? exp)
                        `(,(car exp) ,(car (cdr exp)) ,(box-set (car (cdr (cdr exp))))))
                    ((is-box? exp) exp)
		)
	)
)


(define is-bound?
    (lambda(argument exp)
        (cond 
            ((eq? exp '()) #f)
            ((is-const? exp) #f)
            ((is-var? exp) #f)
            ((is-set? exp)
                (is-bound? argument (car (cdr (cdr exp))) ))
            ((is-seq? exp)
                (if (eq? #f (member #t (map (lambda(x) 
                                                (is-bound? argument x))
                                                (car (cdr exp)))))
                                            
                    #f
                    #t))
            
            ((is-or? exp)
                (let ((or-exp (car (cdr exp))))
                       (if (member #t (map (lambda (x)
                                                (is-bound? argument x))
                                        or-exp))
                                        #t
                                        #f)))
             ((is-if? exp)
                    (if (is-bound? argument (car (cdr exp)))
                        #t
                        (if (is-bound? argument (car (cdr (cdr exp))) )
                            #t
                            (if (is-bound? argument (car (cdr (cdr (cdr exp)))))
                                #t
                                #f))))
            
            
            
            
            
            ((is-lambda-simple? exp)
                (let ((arguments (car (cdr exp)))
                      (inner-body (car (cdr (cdr exp)))))
                        (if (eq? #f (member argument arguments))
                            (if  (argument-exists-in-body? argument inner-body)
 			          #t
 				  #f)
                            #f)))
            ((is-lambda-opt? exp)
                (let ((arguments `(,@(car (cdr exp)) ,(car (cdr (cdr exp)))))
                      (inner-body (car (cdr (cdr (cdr exp))))))
                        (if (eq? #f (member argument arguments))
                            (if (argument-exists-in-body? argument inner-body)
 			          #t
 				  #f)
                            #f)))
            ((is-applic (car exp))
                (let ((function (car (cdr exp)))
                      (parameters (car (cdr (cdr exp)))))
                        (if (eq? #t (is-bound? argument function))
                            #t
                            (if (member #t (map 
                                                    (lambda (x)
                                                        (is-bound? argument x))
                                                    parameters))
                                #t
                                #f))))
            ((is-box-get? exp) #f)
            ((is-box-set? exp)
		(is-bound? argument (car (cdr (cdr exp)))))
            ((is-box? exp)  #f)
        )
    )
)


(define argument-exists-in-body?
    (lambda (var-name body)
        (cond 
            ((eq? body '()) #f)
            ((is-const? body) #f)
            ((is-var? body) 
                (if (eq? var-name (car (cdr body)))
                    #t
                    #f))
            ((is-set?  body)
                (if (eq? (car (cdr(car (cdr body)))) var-name) 
					#t
					(argument-exists-in-body? var-name (car (cdr (cdr body))))))
					
					
					
            ((is-or? body)
                (let ((or-exp (car (cdr body))))
                       (if (member #t (map (lambda (x)
                                                (argument-exists-in-body? var-name x))
                                        or-exp))
                                        #t
                                        #f)))			
					
					
					
            ((is-if? body)
                (if (eq? #t (argument-exists-in-body? var-name (car (cdr body))))
                        #t
                        (if (eq? #t (argument-exists-in-body? var-name (car ( cdr (cdr body)))))
                            #t
                            (if (eq? #t (argument-exists-in-body? var-name (car (cdr (cdr  (cdr body))))))
                                #t
                                #f))))
            ((is-seq? body)
		(if (member #t (map (lambda(x)
                                        (argument-exists-in-body? var-name x))
                                    (car (cdr body))))
                    #t
                    #f))
            
            
            ((is-lambda-simple? body)
                (let ((arguments (car (cdr body)))
                       (inner-body (car (cdr (cdr body)))))
                        (if (eq? #f (member var-name arguments))
                            (if  (argument-exists-in-body? var-name inner-body)
 			          #t
  				  #f)
                            #f)))			
             ((is-lambda-opt? body)
                (let ((arguments `(,@(car (cdr body)) ,(car (cdr (cdr body)))))
                      (inner-body (car (cdr (cdr (cdr body))))))
                        (if (eq? #f (member var-name arguments))
                             (if (argument-exists-in-body? var-name inner-body)
  			          #t
  				  #f)
                             #f)))
			
			
            ((is-applic (car body)) 
                    (let ((function (car (cdr body)))
                          (parameters (car (cdr (cdr body)))))
                        (if (eq? #t (argument-exists-in-body? var-name function))
                             #t
                             (if (member #t (map (lambda(x)
                                                (argument-exists-in-body? var-name x))
                                                parameters))
                                 #t
                                #f))))
             ((is-box-get? body) #f)
             ((is-box-set? body)
 		(argument-exists-in-body? var-name (car (cdr (cdr body)))))
             ((is-box? body)  #f)
        )
    )
)
    
    
    
    
    
    
    
    
    
    
    
        

(define add-get-set-box
	(lambda (body arguments-to-replace)
		(cond 
                        ((eq? arguments-to-replace '()) body)
			((eq? body '()) body)
			((is-const? body) body)
			((is-var? body) 
				(if (member (car (cdr body)) arguments-to-replace) ;is-get?
						`(box-get ,body)
						body))
			((is-define? body)
				(add-get-set-box (car (cdr (cdr body))) arguments-to-replace))
			((is-seq? body)
				`(,(car body) ,(map 
                                                    (lambda(x)
                                                        (add-get-set-box x arguments-to-replace))
                                                    (car (cdr body)))))
			((is-set? body)
				(if 
					(member (car (cdr (car (cdr body)))) arguments-to-replace)
						`(box-set ,(car (cdr body)) ,(add-get-set-box (car (cdr (cdr body))) arguments-to-replace))
						`(,(car body) ,(car (cdr body)) ,(add-get-set-box (car (cdr (cdr body))) arguments-to-replace))))
			
			((is-or? body)
                            (let ((or-exp (car (cdr body))))
                                `(,(car body) ,(map (lambda (x)
                                                (add-get-set-box x arguments-to-replace))
                                        or-exp))))
			
			
			
			
			((is-if? body)
                            (let ((test ( add-get-set-box  (car (cdr body)) arguments-to-replace))
                                  (dit  ( add-get-set-box  (car (cdr  (cdr body))) arguments-to-replace))
                                  (dif  ( add-get-set-box  (car (cdr  (cdr  (cdr body)))) arguments-to-replace)))
                                    `(,(car body) ,test ,dit ,dif)))
	
				
				
				
			((is-lambda-simple? body)
                            (let ((arguments (car (cdr body)))
                            (inner-body (car (cdr (cdr body)))))
				`(,(car body) ,(car (cdr body)) 
				,(add-get-set-box inner-body (remove-vars-from-list arguments arguments-to-replace)))))

                        ((is-lambda-opt? body)
                            (let ((arguments `(,@(car (cdr body)) ,(car (cdr (cdr body)))))
                                 (inner-body (car (cdr (cdr (cdr body))))))
				`(,(car body) 
				,(car (cdr body)) 
				,(car (cdr (cdr body))) 
				,(add-get-set-box inner-body (remove-vars-from-list arguments arguments-to-replace)))))
			((is-applic (car body)) 
				(let ((function (add-get-set-box (car (cdr body)) arguments-to-replace)) 
					  (parameters (map 
							(lambda(x) 
								(add-get-set-box x arguments-to-replace)) 
							(car (cdr (cdr body))))))
						`(,(car body) ,function ,parameters)))
			((is-box-get? body) body)
                        ((is-box-set? body) 
                            `(,(car body) ,(car (cdr body)) ,(add-get-set-box (car (cdr (cdr body))) arguments-to-replace)))
                        ((is-box? body)  body)
		)
	)
)

(define remove-vars-from-list
    (lambda (toRemove lst)
        (filter
            (lambda (var-in-lst)
                (if (member var-in-lst toRemove)
                    #f
                    #t))
                lst)))







 (define has-set?
	(lambda (var-name body)
		(cond 
			((eq? body '()) #f)
			((is-const? body) #f)
			((is-var? body) #f)
			((is-define? body)
				(if (eq? (car (cdr(car(cdr body)))) var-name)
					#t
					(has-set? var-name (car (cdr (cdr body))))))
			((is-set?  body)
				(if (eq? (car (cdr(car (cdr body)))) var-name) 
					#t
					(has-set? var-name (car (cdr (cdr body))))))
					
					
			((is-or? body)
                            (let ((or-exp (car (cdr body))))
                                (if (member #t (map (lambda (x)
                                                (has-set? var-name x))
                                        or-exp))
                                        #t
                                        #f
                                        )))		
					
					
			((is-if? body)
				(if (eq? #t (has-set? var-name (car (cdr body))))
					#t
					(if (eq? #t (has-set? var-name (car ( cdr (cdr body)))))
						#t
						(if (eq? #t (has-set? var-name (car (cdr (cdr  (cdr body))))))
						#t
						#f))))
			((is-seq? body)
				(if (member #t (map (lambda(x)
							(has-set? var-name x))
						(car (cdr body))))
						#t
						#f))
						
						
						
                        ((is-lambda-simple? body)
                            (let ((arguments (car (cdr body)))
                                  (inner-body (car (cdr (cdr body)))))
                                (if (eq? #f (member var-name arguments))
                                    (if  (has-set? var-name inner-body)
                                        #t
                                        #f)
                                    #f)))
                        ((is-lambda-opt? body)
                            (let ((arguments `(,@(car (cdr body)) ,(car (cdr (cdr body)))))
                                  (inner-body (car (cdr (cdr (cdr body))))))
                                (if (eq? #f (member var-name arguments))
                                    (if (has-set? var-name inner-body)
                                        #t
                                        #f)
                                    #f)))					
			((is-applic (car body)) 
				(let ((first-ans (has-set? var-name(car (cdr body))))
					(second-ans (map 
							(lambda(x) 
								(if (has-set? var-name x)
									#t
									#f)) 
							(car (cdr (cdr body)))))
					)
					(let ((ans (if (eq? #t first-ans)
						#t
						(if (member #t second-ans)
							#t
							#f))))
						ans)))
		)
	)
)






 (define has-get?
  	(lambda (var-name body)
 		(cond 
 			((eq? body '()) #f)
 			((is-const? body) #f)
 			((is-var? body) 
 				(if (eq? (car (cdr body)) var-name)
 					#t
 					#f))
 			((is-define? body)
 				(has-get? var-name (car (cdr (cdr body)))))
 			((is-seq? body)
 				(if (member #t (map 
 						(lambda (x)
 							(has-get? var-name x))
 					(car (cdr body))))
 					#t
 					#f))
 			((is-set?  body)
 				(has-get? var-name (car (cdr (cdr body))))) 
 			((is-lambda-simple? body)
                            (let ((arguments (car (cdr body)))
                                  (inner-body (car (cdr (cdr body)))))
                                (if (eq? #f (member var-name arguments))
                                    (if  (has-get? var-name inner-body)
                                        #t
                                        #f)
                                    #f)))
                        ((is-lambda-opt? body)
                            (let ((arguments `(,@(car (cdr body)) ,(car (cdr (cdr body)))))
                                  (inner-body (car (cdr (cdr (cdr body))))))
                                (if (eq? #f (member var-name arguments))
                                    (if (has-get? var-name inner-body)
                                        #t
                                        #f)
                                    #f)))
 			
 			((is-or? body)
                            (let ((or-exp (car (cdr body))))
                                (if (member #t (map (lambda (x)
                                                (has-get? var-name x))
                                        or-exp))
                                        #t
                                        #f
                                        )))
 			
 			
 			((is-if? body)
 				(if (eq? #t (has-get? var-name (car (cdr body))))
 					#t
 					(if (eq? #t (has-get? var-name (car ( cdr (cdr body)))))
 						#t
 						(if (eq? #t (has-get? var-name (car (cdr (cdr  (cdr body))))))
 						#t
 						#f))))
 			((is-applic (car body)) 			
 				(let ((first-ans (has-get? var-name(car (cdr body))))
 					(second-ans (map 
 							(lambda(x) 
 								(if (has-get? var-name x)
 									#t
 									#f)) 
 							(car (cdr (cdr body)))))
 					)
 					(let ((ans (if (eq? #t first-ans)
 						#t
 						(if (member #t second-ans)
 							#t
 							#f))))
 						ans)))
 		)
 	)
 )

(define pe->lex-pe
	(lambda (exp)

		(pe->lex-pe_with_env exp '())
	)
)

(define pe->lex-pe_with_env
	(lambda (exp env)
		(cond 
                    ((eq? exp '()) exp)			
                    ((is-const? exp) exp)
                    ((is-var? exp)
                        (let ((ans (getVarCorrectly (car (cdr exp)) env (- 1))))
                                ans))
                    ((is-define? exp) 
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env) ,(pe->lex-pe_with_env (car (cdr (cdr exp))) env)))
                    ((is-set? exp) 
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env) ,(pe->lex-pe_with_env (car (cdr (cdr exp))) env)))
                    ((is-seq? exp) 
                        `(,(car exp) ,(map 
                                        (lambda (x)
                                            (pe->lex-pe_with_env x env))
                                            (car (cdr exp)))))
                    
                    
                    ((is-or? exp)
                        (let ((or-exp (car (cdr exp))))
                                `(,(car exp) ,(map (lambda (x)
                                                (pe->lex-pe_with_env x env))
                                        or-exp))))
			
                    
                    ((is-if? exp)
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env) ,(pe->lex-pe_with_env (car ( cdr (cdr exp))) env) ,(pe->lex-pe_with_env (car (cdr (cdr  (cdr exp)))) env)))
                    ((is-lambda-simple? exp)
                        (let ((curr_env (AddToEnviroment (car (cdr exp)) env)))
                            (let ((ans `(,(car exp) ,(car (cdr exp)) ,(pe->lex-pe_with_env (car (cdr (cdr exp))) curr_env))))
                                ans)))
                    ((is-lambda-opt? exp)
                        (let ((vars_to_add  `(,@(car (cdr exp)) , (car (cdr (cdr exp))))))
                            (let ((curr_env (AddToEnviroment vars_to_add env)))
                                (let ((ans `(,(car exp) ,(car (cdr exp)),(car (cdr (cdr exp))) ,(pe->lex-pe_with_env (car (cdr (cdr (cdr exp)))) curr_env))))
                                        ans))))		
                    ((is-applic (car exp))
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env) ,(map 
                                                                                    (lambda(x) 
                                                                                        (pe->lex-pe_with_env x env)) 
                                                                                            (car (cdr (cdr exp))))))
                    ((is-box-get? exp)
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env)))
                    ((is-box-set? exp)
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env) ,(pe->lex-pe_with_env (car (cdr (cdr exp))) env)))
                    ((is-box? exp)
                        `(,(car exp) ,(pe->lex-pe_with_env (car (cdr exp)) env)))
		)
	)
)

(define AddToEnviroment
	(lambda (arguments env)
		`(,arguments ,env)
	)
)

(define getVarCorrectly
	(lambda (var env levelNumber )	
		(cond
			((eq? env '())
				`(fvar ,var))
			((member var (car env)) 
				(if (eq? levelNumber (- 1))
					`(pvar ,var ,(getIndexInList var (car env) 0))
					`(bvar ,var ,levelNumber ,(getIndexInList var (car env) 0))))
			(else
				(getVarCorrectly var (car(cdr env)) (+ 1 levelNumber))
			)
		)
	)
)

(define getIndexInList
	(lambda (var lst index)
		(cond 
			((eq? lst '())
				(- 999))
			((eq? (car lst) var )
				index)
			(else
				(getIndexInList var (cdr lst) (+ 1 index)))
		)
	)
)
				
				
(define annotate-tc
	(lambda (exp)
		(recursive-annotate-tc exp #f)
	)
)


(define recursive-annotate-tc
    (lambda (exp in-tp)
        (cond 
            ((eq? exp '()) exp)
            ((is-const? exp) exp)
            ((is-var? exp) exp)
            ((is-define? exp) 
                `(,(car exp) ,(car (cdr exp)) ,(recursive-annotate-tc (car (cdr (cdr exp))) #f)))
            ((is-set? exp) 
                `(,(car exp) ,(car (cdr exp)) ,(recursive-annotate-tc (car (cdr (cdr exp))) #f)))
            ((is-seq? exp) 
                (let ((without-last-exp (remove-last (car(cdr exp)) '()))
                      (last-exp (get-last (car (cdr exp)))))
                        `(,(car exp) ,`(,@(map 
                                            (lambda(x)
                                                (recursive-annotate-tc x #f))
                                                without-last-exp)
                                            ,(recursive-annotate-tc last-exp in-tp)))))
            
            ((is-or? exp)
                    (let ((or-exp (car (cdr exp))))
                        (let ((firsts-exp (remove-last or-exp '()))
                              (last-exp (get-last or-exp)))
                              (let ((ans-firsts-exp (map (lambda(x)
                                                            (recursive-annotate-tc x #f))
                                                        firsts-exp))
                                    (ans-last-exp (recursive-annotate-tc last-exp in-tp)))
                                    `(,(car exp) ,`(,@ans-firsts-exp ,ans-last-exp))))))
            
            
            
            
            ((is-if? exp)
                `(,(car exp) ,(recursive-annotate-tc (car (cdr exp)) #f) ,(recursive-annotate-tc (car ( cdr (cdr exp))) in-tp) ,(recursive-annotate-tc (car (cdr (cdr  (cdr exp)))) in-tp)))
            ((is-lambda-simple? exp) 
                `(,(car exp) ,(car (cdr exp)) ,(recursive-annotate-tc (car (cdr (cdr exp))) #t)))
            ((is-lambda-opt? exp)
                (let ((normal-arg (car (cdr exp)))
                      (optional-arg (car (cdr (cdr exp))))
                      (body-after-change (recursive-annotate-tc (car (cdr (cdr (cdr exp))))#t )))
                                  `(,(car exp) ,normal-arg ,optional-arg ,body-after-change)))
            ((is-applic (car exp)) 
                (if in-tp 
                    `(tc-applic ,(recursive-annotate-tc (car (cdr exp)) #f) ,(map 
                                                                                    (lambda(x) 
                                                                                        (recursive-annotate-tc x #f)) 
                                                                                    (car (cdr (cdr exp)))))
                    `(,(car exp) ,(recursive-annotate-tc (car (cdr exp)) #f) ,(map 
                                                                                    (lambda(x) 
                                                                                        (recursive-annotate-tc x #f)) 
                                                                                    (car (cdr (cdr exp)))))))
            ((is-box-get? exp) exp)
            ((is-box-set? exp)
                `(,(car exp) ,(car (cdr exp)) ,(recursive-annotate-tc (car (cdr (cdr exp))) #f)))
            ((is-box? exp) exp)
		)
	)
)


(define remove-last
	(lambda (lst acc)
		(cond 
			((eq? lst '()) acc)
			((eq? (cdr lst) '()) acc)
			(else
				(remove-last (cdr lst) `(,@acc ,(car lst))))
		)
	)
)

(define get-last
	(lambda (lst)
		(cond 
			((eq? lst '()) lst)
			((eq? (cdr lst) '()) (car lst))
			(else 
				(get-last (cdr lst)))
		)
	)
)

(define is-const? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'const)
			#t
			#f
		)
	)
)


(define is-var? 
	(lambda (s-exp)
		(if (member (car s-exp) `(fvar bvar pvar var))
			#t
			#f
		)
	)
)
(define is-set?
	(lambda (exp)
		(eq? (car exp) 'set)
	)
)

(define is-if? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'if3)
			#t
			#f
		)
	)
)
(define is-define? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'define)
			#t
			#f
		)
	)
)

(define is-seq? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'seq)
			#t
			#f
		)
	)
)


(define is-lambda-opt? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'lambda-opt)
			#t
			#f
		)
	)
)

(define is-lambda-simple? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'lambda-simple)
			#t
			#f
		)
	)
)
(define is-applic
	(lambda (exp)
		(if (equal? exp 'applic)
			#t
			#f
		)
	)
)
(define is-box? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'box)
			#t
			#f
		)
	)
)
(define is-box-get? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'box-get)
			#t
			#f
		)
	)
)
(define is-box-set? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'box-set)
			#t
			#f
		)
	)
)

(define is-or? 
	(lambda (s-exp)
		(if (eq? (car s-exp) 'or)
			#t
			#f
		)
	)
)
