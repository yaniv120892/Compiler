(load "pc.scm")


(define <sexpr>
    (new 
		(*delayed (lambda() <WhiteSpacesPlus>))
		(*delayed (lambda() <Comment>))*star
		(*disj 2)
		
        (*delayed (lambda()  <Boolean>))
        (*delayed (lambda()  <Number>))
        (*delayed (lambda()  <Char>))
        (*delayed (lambda()  <Symbol>))
        (*delayed (lambda()  <String>))
        (*delayed (lambda()  <ProperList>))
        (*delayed (lambda()  <ImproperList>))
        (*delayed (lambda()  <Vector>))
        (*delayed (lambda()  <Quoted>))
        (*delayed (lambda()  <QuasiQuoted>))
        (*delayed (lambda()  <UnquoteAndSpliced>))
        (*delayed (lambda()  <Unquoted>))
        (*delayed (lambda()  <CBName>))
        (*delayed (lambda()  <InfixExtention>))
		;(*delayed (lambda()  <Comment>))
        (*disj 14)
		
		(*delayed (lambda() <WhiteSpacesPlus>))
		(*delayed (lambda() <Comment>))*star
		(*disj 2)
		(*caten 3)
		(*pack-with
			(lambda(space1 sexp space2)
				sexp))
    done))

(define ^<meta-char>
    (lambda (str ch)
        (new (*parser (word-ci str))
             (*pack (lambda (_) ch))
    done)))

(define <less-then-space>
    (const
        (lambda (ch)
            (char<=? ch #\space))))


(define <WhiteSpaces>
    (new 
        (*parser <less-then-space>) *star
        (*pack (lambda(str)  " " ))
    done))

(define <WhiteSpacesPlus>
    (new 
        (*parser <less-then-space>) *plus
        (*pack (lambda(str)  " " ))
    done))
	

(define <line-comment>
    (new
        (*parser (char #\space)) *star
        
        (*parser (char #\;))
        
        (*parser (diff <any-char> (char #\newline)))*star 
        
        
        (*parser (char #\newline))
        (*parser <end-of-input>)
        (*disj 2)
        
        (*caten 4)
        ;(*pack-with
		;    (lambda (space semicolen comment end)
        ;        '()))
    done))

(define <Comment>
	(new
		(*parser <WhiteSpaces>)
		(*delayed (lambda() <sexpr-comment>))
        (*parser <line-comment>)
		(*disj 2)
		(*parser <WhiteSpaces>)
		(*caten 3)
		(*pack-with
			(lambda(space comment space2)
				#\x0))
	done))
    
(define <White-space-or-Epsilon>
    (new 
		
        (*parser <WhiteSpaces>)
        (*delayed (lambda() <sexpr-comment>))
        (*parser <line-comment>)
        (*parser <epsilon>)
        (*disj 3)
        (*parser <WhiteSpaces>)
		(*caten 3)
		(*pack-with
			(lambda (space1 comment space2)
				#\x0))
    done))

(define <sexpr-comment>
    (new
        (*parser (word "#;"))
        (*delayed (lambda() <InfixAddParser>))
        (*parser <sexpr>)
        (*disj 2)
        (*caten 2)
        (*pack-with
            (lambda (semicolen comment)
                #\x0))
    done))
    
    

(define <digit-0-9>
    (range #\0 #\9))

(define <digit-1-9>
    (range #\1 #\9))
    
  
(define <char-a-f>
    (range #\a #\f))
    
  
(define <char-a-f-ci>
    (new
        (*parser <char-a-f>)
        (*parser (range #\A #\F))
        (*disj 2)
    done))

  
(define <char-a-z>
    (range #\a #\z))
    
  
(define <char-a-z-ci>
    (new
        (*parser <char-a-z>)
        (*parser (range #\A #\Z))
        (*disj 2)
    done))
    
    
  
(define <operators>
    (new
        (*parser (char #\+))
        (*parser (char #\-))
        (*parser (char #\*))
        (*parser (char #\/))
        (*parser (char #\^))
        (*parser (char #\=))
        (*parser (char #\<))
        (*parser (char #\>))
        (*disj 8)
    done))



   
(define <Natural>
    (new
        (*parser <digit-0-9>)              
        (*parser <digit-0-9>) *star
        (*caten 2)
        (*pack-with
            (lambda (x xs)
                (string->number 
                    (list->string `(,x ,@xs)))))
    done))

(define <Natural-Without-Zero>
    (new
        (*parser (char #\0)) *star
        (*parser <digit-1-9>)
        (*parser <digit-0-9>) *star
        (*caten 3)
    
        (*pack-with
            (lambda (zeros x xs)
                (string->number (list->string `(,@zeros ,x ,@xs)))))
    done))
    
   
(define <HexChar>
    (new
        (*parser <digit-0-9>)
        (*parser <char-a-f-ci>)
        (*disj 2)
    done))
    
    


    
    
    


(define <Boolean>
    (new
        (*parser (word "#t"))
        (*parser (word "#T"))
        (*disj 2)
        (*pack (lambda(_) (eq? 1 1)))
        (*parser (word "#f"))
        (*parser (word "#F"))
        (*disj 2)
        (*pack (lambda(_) (eq? 1 2)))
        (*disj 2)
        
    done))
    

(define <VisibleSimpleChar> 
    (const 
        (lambda (ch) 
            (and (char>=? ch #\space) ))))
            
            
            
            

(define <CharPrefixVisibleSimpleChar>
    (new
        (*parser <White-space-or-Epsilon>)
        (*parser (word "#\\"))
        (*parser <VisibleSimpleChar>)
        (*caten 2)
        (*pack-with (lambda(x xs) xs))
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))
        
    done))
    

    

    
    
    

(define <HexUnicodeChar>
    (new
        (*parser <White-space-or-Epsilon>)
        (*parser (char-ci #\x))
        (*parser <HexChar>) *plus
        (*caten 2)

        (*pack-with
            (lambda (x hex)  
                (string->symbol
                    (list->string `(,x ,@hex)))))
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))
done))
    
    
    
(define <NamedChar>
    (new
        (*parser <White-space-or-Epsilon>)
        
        (*parser (word-ci "lambda"))
        (*parser (word-ci "newline"))
        (*parser (word-ci "nul"))
        (*parser (word-ci "page"))
        (*parser (word-ci "return"))
        (*parser (word-ci "space"))
        (*parser (word-ci "tab"))
        (*disj 7)
        (*pack (lambda(str) 
                (let ((ans  (string-downcase (list->string  str))))
                    (cond 
                        ((equal? ans "lambda")
                            (integer->char 955))
                        ((equal? ans "newline")
                            #\newline)
                        ((equal? ans "nul")
                            #\nul)
                        ((equal? ans "page")
                            #\page)
                        ((equal? ans "return")
                            #\return)
                        ((equal? ans "space")
                            #\space)
                        ((equal? ans "tab")
                            #\tab)))))
        
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))

done))
    

    
    

(define <CharPrefixNamedChar>
    (new
        (*parser <White-space-or-Epsilon>)
        (*parser (word "#\\"))
        (*parser <NamedChar>)
        (*parser <White-space-or-Epsilon>)
        (*caten 4)
        (*pack-with (lambda(space1 x xs space2)  xs))
        
    done))
    
    
(define <CharPrefixHexUnicodeChar>
    (new
        (*parser <White-space-or-Epsilon>)
        (*parser (word "#\\"))
        (*parser <HexUnicodeChar>)
        (*parser <White-space-or-Epsilon>)
        (*caten 4)
        (*pack-with 
            (lambda(space1 prefix num space3) 
                (integer->char 
                    (string->number 
                        (list->string 
                            (cdr
                                (string->list 
                                    (symbol->string num)
                                )
                            )
                        ) 16
                    )
                )
            )
        )
        
    done))
    


(define <Char>
    (new
        (*parser <CharPrefixHexUnicodeChar>)
        (*parser <CharPrefixNamedChar>)
        (*parser <CharPrefixVisibleSimpleChar>)
        (*disj 3)
    done))
    
    

(define <Integer>
    (new 
               
        (*parser (char #\+))
        (*parser <Natural>)
        (*caten 2)
        (*pack-with
            (lambda (op n)
            n))

        (*parser (char #\-))
        (*parser <Natural>)
        (*caten 2)
        (*pack-with
            (lambda (op n) (- n)))

        (*parser <Natural>)

        (*disj 3)
    
    done))
    

    
    

(define <Fraction>
    (new
        
        (*parser <Integer>)
        ;(*parser <White-space-or-Epsilon>)
        (*parser (char #\/))
        ;(*parser <White-space-or-Epsilon>)
        (*parser <Natural-Without-Zero>)
        (*caten 3)
        (*pack-with
            (lambda (int op nat)
                (/ int nat)))
                
        
    done))    
    

    

(define <Number>
    (new        
        (*parser <White-space-or-Epsilon>)
        (*parser <Fraction>)
        (*parser <Integer>)
        (*disj 2)
        ;(*parser (char #\space))
        ;(*parser <char-a-z-ci>)
        ;(*caten 2)
        (*parser <char-a-z-ci>)
        ;(*disj 2)
        ;(*delayed (lambda () <Number>))
        ;*diff
        *not-followed-by
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda (space1 x space2)
                x))

    done))

 

(define <StringLiteralChar>
    (new 
        (*parser <any-char>)
        (*parser (char #\\))
        *diff
        (*parser (char #\"))
        *diff
    done))

;need to fix "\\"
(define <StringMetaChar>
    (new 
        (*parser (^<meta-char> "\\\\" #\x2f))
        (*parser (^<meta-char> "\"" #\x22))
        (*parser (^<meta-char> "\\n" #\xa))
        (*parser (^<meta-char> "\\r" #\xd))
        (*parser (^<meta-char> "\\t" #\x9))
        (*parser (^<meta-char> "\\f" #\page))
        (*disj 6)
        (*pack
            (lambda (x)
                x))
    done))
    

(define <StringHexChar>
    (new 
        (*parser (word-ci "\\x"))
        (*parser <HexChar>) *star
        (*parser (char #\;))
        (*caten 3)
        (*pack-with
            (lambda (x hex semi)  
                (integer->char 
                    (string->number 
                        (list->string `(#\# #\x ,@hex))))))
    done))
    

(define <StringChar>
    (new 
        (*parser <StringMetaChar>)
        (*parser <StringHexChar>)
        (*parser <StringLiteralChar>)
        (*disj 3)
    done))
    

(define <SymbolChar>
    (new 
        (*parser <digit-0-9>)
        (*parser <char-a-z-ci>)
        (*pack 
            (lambda (ch)
                (char-downcase ch)))
        (*parser <operators>)
        (*parser (char #\?))
        (*parser (char #\!))
        (*parser (char #\$))
        (*parser (char #\_))
        (*disj 7)
    done))
    

(define <Symbol>
    (new 
        (*parser <SymbolChar>) *plus
        (*pack
            (lambda (x)
                (string->symbol
                    (list->string `(,@x)))))
    done))

	

(define <String>
    (new 
        
        (*parser <White-space-or-Epsilon>)
    
        (*parser (char #\"))
                
        (*parser <StringChar>)
        (*parser (char #\"))
	*diff
	*star
        
        (*parser (char #\"))
        
        (*caten 3)
        (*pack-with
            (lambda (open-delim chars close-delim)
		(list->string chars)))

        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))
    done))
	
	
	
	
	
	
	
	
	
	
	
	
	
	

 (define <ProperList>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word "("))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 2)
        (*pack-with 
            (lambda (sexpr2 spaces3)
                sexpr2))
        *star
        (*parser <White-space-or-Epsilon>)
        (*parser (word ")"))
        (*caten 5)
        (*pack-with 
            (lambda (open spaces1 sexpr spaces2 close) 
                sexpr))
                      
                      
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))
        done))

    

 (define <ImproperList>
    (new 
        (*parser <White-space-or-Epsilon>)
        
        
        (*parser (word "("))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 2)
        (*pack-with 
            (lambda (sexpr1 spaces2)
                (car`(,sexpr1 ,spaces2))
            )
        )
        *plus
        (*parser (word "."))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>) 
        (*parser <White-space-or-Epsilon>)
        (*parser (word ")"))
        (*caten 8)
        (*pack-with 
            (lambda (open spaces1 sexpr1_spaces2 point spaces3 sexpr2 spaces4 close) 
                (append sexpr1_spaces2 sexpr2)
            )
        )
            
            
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda ( space1 exp space2)
                exp))
			
     done))




(define <Vector>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word "#"))
        (*parser <White-space-or-Epsilon>)
        (*parser <ProperList>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with 
            (lambda(space1 co space2 prop space3)
		(list->vector prop)))
    done))
    


(define <Quoted>
    (new     
        (*parser <White-space-or-Epsilon>)
        (*parser (word "'"))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda(spaces1 qo spaces2 sexpr spaces3)
                (list 'quote  sexpr)))
    done))

    

(define <QuasiQuoted>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word "`"))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda(spaces1 quasiqo spaces2 sexpr spaces3)
                (list 'quasiquote  sexpr)))
    done))
    
    

(define <Unquoted>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word ","))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda(spaces1 unqo spaces2 sexpr spaces3)
                (list 'unquote  sexpr)))
    done))
    
    

(define <UnquoteAndSpliced>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word ",@"))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda(spaces1 unandsplice spaces2 sexpr spaces3)
                (list 'unquote-splicing sexpr)))
    done))
    



(define <CBNameSyntax1>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser (word "@"))
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda(spaces1 splice spaces2 sexpr spaces3)
                (list 'cbname sexpr)))
    done))

    

(define <CBNameSyntax2>
    (new
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\{))
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser <sexpr>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\}))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 7)
        (*pack-with 
            (lambda (space1 open space2 sexpr space3 close space4) 
               (list 'cbname sexpr))) 
    done))
    
    
    

(define <CBName>
    (new 
        (*parser <CBNameSyntax1>)
        (*parser <CBNameSyntax2>)
        (*disj 2)
    done))
    
    
    

(define <InfixExtention>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*delayed (lambda()  <InfixPrefixExtensionPrefix>))
        (*parser <White-space-or-Epsilon>)
        (*delayed (lambda()  <InfixExpression>))
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with 
            (lambda (space1 pre space2 infix space3)
                infix))
            
    done))
    
    
    

(define <InfixPrefixExtensionPrefix>
    (new 
        (*parser (word "##"))
        (*parser (word "#%"))
        (*disj 2)
    done))
    
    

(define <InfixExpression>
    (new 
        (*delayed (lambda() <InfixAddParser>))
    done))  

    
    

 (define <PowerSymbol>
     (new 
         (*parser ( char #\^))
         (*parser ( word "**"))
         (*disj 2)
     done)) 
     
    

(define <InfixSymbol>
    (new 
        (*parser <SymbolChar>)
        (*parser (char #\+))
        (*parser (char #\-))
        (*parser (char #\*))
        (*parser (word "**"))
        (*parser (char #\^))
        (*parser (char #\/))
        (*disj 6)
        *diff
        *plus
        (*pack
            (lambda (x) 
                (string->symbol
                    (list->string `(,@x)))))

    done))   


(define <InfixBaseCaseParser>
    (new        
        (*delayed (lambda() <InfixSexprEscape>))
        (*delayed (lambda() <InfixParenParser>))
        (*parser <Number>)
        (*parser <InfixSymbol>)
        (*disj 4)
    done))
    
    
    
    
(define setOrderMul_Plus
    (lambda (mul1 mul2)

        (cond
            ((eq? '() mul2)
                mul1
            )
            (else

                (let ((sub  
                            (list (cond 
                                    ((eq? (car (car mul2)) #\+ )
                                        '+)
                                    ((eq? (car (car mul2)) #\- )
                                        '-)
                                    ((eq? (car (car mul2)) #\* )
                                        '*)
                                    ((eq? (car (car mul2)) #\/ )
                                        '/)
                                )
                                mul1 
                                (cdr (car mul2)))))

                (setOrderMul_Plus sub (cdr mul2))
                )
            )
        )
    )
)









(define setOrderPow
    (lambda (mul1 mul2)
        (cond
            ((eq? '() mul2)
                mul1
            )
            ((pair? mul2)
                (let ((ans (list 
                    'expt
                    mul1
                    (cdr mul2)
                )))
                ans
            ))
            (else
                (let ((ans (list 
                    'expt
                    mul1
                    (setOrderPow (cdr (car mul2)) (cdr mul2))
                )))
                ans
                
                )
            )
        )
    )
)




(define <InfixArgsListParser>
    (new        
        (*parser <White-space-or-Epsilon>)
        
        (*delayed (lambda() <InfixAddParser>))
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\,))
        
        (*parser <White-space-or-Epsilon>)
        
        (*delayed (lambda() <InfixAddParser>))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 5)
        (*pack-with	
                (lambda(space1 comma spaces2 add spaces3)
                 add
            )
        )
        *star
        
        (*caten 3)
        (*pack-with	
                (lambda(space add rest)
                    `(,add ,@rest)
                )
        )
        (*parser <epsilon>) 
        (*disj 2)
    done)) 


(define <InfixParenParser>
    (new

        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\())
        
        (*parser <White-space-or-Epsilon>)
        
        (*delayed (lambda() <InfixAddParser>))
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\)))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 7)
        (*pack-with	
                (lambda(space1 open spaces2 add spaces3 close spaces4)
                    add
                )
        )
    done)) 







(define <InfixFuncallParser>
    (new
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixBaseCaseParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 3)
        
        (*pack-with 
            (lambda (space1 base space2)
                base
            )
        )
        
        (*parser (char #\())
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixArgsListParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\)))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 6) 
        (*pack-with 
            (lambda (open space1 arglist space2 close space3)
                    arglist
            )
        )
        *plus
        
        (*caten 2)
        (*pack-with
            (lambda (func arglist)
                `(,func ,@(car arglist))))
                
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixBaseCaseParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 3)
        
        (*pack-with 
            (lambda (space1 base space2)
                base
            )
        )
        (*disj 2)
    done)) 

    
    
  
        
(define Fix-Array-View
    (lambda (ref)
        (cond 
;;              ((eq? ref '())
;;                  ref)
             ((eq? (length ref ) 2)
                 (list 'vector-ref (car ref) (car(cdr ref))))
            (else  
                (let ((chunk (list 'vector-ref (car ref) (car(cdr ref)))))
                (Fix-Array-View `(,chunk ,@(cdr (cdr ref)))))))))


(define <InfixArrayParser>
    (new        
        (*parser <White-space-or-Epsilon>)
        (*parser <InfixFuncallParser>)
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda (space1 func space2)
                func
            )
        )
        
        (*parser (char #\[))
        (*parser <White-space-or-Epsilon>)
        (*delayed (lambda() <InfixAddParser>))
        (*parser <White-space-or-Epsilon>)
        (*parser (char #\]))
        (*parser <White-space-or-Epsilon>)
        (*caten 6) 
        (*pack-with 
            (lambda (open space1 add space2 close space3)
                add
            )
        )
        *plus
        (*caten 2)
        (*pack-with
            (lambda (func add)
                (Fix-Array-View `(,func ,@add))))
        
        
        
        
        
        
        
        
        
        (*parser <White-space-or-Epsilon>)
        (*parser <InfixFuncallParser>)
        (*parser <White-space-or-Epsilon>)
        (*caten 3)
        (*pack-with 
            (lambda (space1 func space2)
                func
            )
        )
        
        (*disj 2)
    done)) 



(define <InfixNegParser>
    (new   
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\-))
        
        (*parser <White-space-or-Epsilon>)
        
        (*delayed (lambda() <InfixNegParser>))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 5) 
        (*pack-with 
            (lambda(space1 op scpace2 neg space3)
;               (string->symbol (list->string (list '- neg)))
                (- 0 neg)
            )
        )
        
        (*parser <InfixArrayParser>)
        (*disj 2)
    done)) 
    
    
    

(define <InfixPowParser>
    (new
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixNegParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser <PowerSymbol>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*delayed (lambda() <InfixPowParser>))
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 4) 
        (*pack-with 
            (lambda(op scpaces1 pow spaces2)
                `(,op ,@pow)
            )
        )
        
        (*caten 4)
        (*pack-with
            (lambda (space1 base1 space2 pow)
                (setOrderPow base1 pow)
            )
        )
        
        (*parser <InfixNegParser>)
        (*disj 2)
                
    done))   


(define <InfixMulParser>
    (new
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixPowParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\*))
        (*parser (char #\/))
        (*disj 2)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixPowParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*caten 4) 
        (*pack-with 
            (lambda(op scpaces1 pow2 spaces2)
                `(,op ,@pow2)
            )
        )
        *star
        (*caten 4)
        (*pack-with
            (lambda (space1 pow1 space2 pow2)
                (setOrderMul_Plus pow1 pow2)
            )
        )
    done))
    

(define <InfixAddParser>
    (new   
        (*parser <White-space-or-Epsilon>)
        
        (*parser <InfixMulParser>)
        
        (*parser <White-space-or-Epsilon>)
        
        (*parser (char #\+))
        (*parser (char #\-))
        (*disj 2)
        (*parser <White-space-or-Epsilon>)
        (*parser <InfixMulParser>)
        (*parser <White-space-or-Epsilon>)
        (*caten 4) 
        (*pack-with 
            (lambda(op scpaces1 mul2 spaces2)
                
                `(,op ,@mul2)
            )
        )
        *star
        
        (*caten 4)
        (*pack-with
            (lambda (space1 mul1 space2 mul2)

                (setOrderMul_Plus mul1  mul2)
            )
        )
    done)) 
    
    

    


(define <InfixSexprEscape>
    (new 
        (*parser <White-space-or-Epsilon>)
        (*parser <InfixPrefixExtensionPrefix>)
        (*parser <White-space-or-Epsilon>)
        (*parser <sexpr>)
        (*parser <White-space-or-Epsilon>)
        (*caten 5)
        (*pack-with
            (lambda (space1 prefix space2 exp space3)
                exp))
    done)) 
    


    
