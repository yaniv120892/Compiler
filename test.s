%include "Meir_Lib.lib"
extern malloc
extern exit
section .data
my_newline: db CHAR_NEWLINE, 0
Free_variable_17:
	dq SOB_UNDEFINED
Free_variable_18:
	dq SOB_UNDEFINED
Free_variable_15:
	dq SOB_UNDEFINED
Free_variable_16:
	dq SOB_UNDEFINED
Free_variable_13:
	dq SOB_UNDEFINED
Free_variable_14:
	dq SOB_UNDEFINED
Free_variable_11:
	dq SOB_UNDEFINED
Free_variable_12:
	dq SOB_UNDEFINED
Free_variable_9:
	dq SOB_UNDEFINED
Free_variable_10:
	dq SOB_UNDEFINED
Free_variable_7:
	dq SOB_UNDEFINED
Free_variable_8:
	dq SOB_UNDEFINED
Free_variable_5:
	dq SOB_UNDEFINED
Free_variable_6:
	dq SOB_UNDEFINED
Free_variable_3:
	dq SOB_UNDEFINED
Free_variable_4:
	dq SOB_UNDEFINED
Free_variable_1:
	dq SOB_UNDEFINED
Free_variable_2:
	dq SOB_UNDEFINED
is_void:
	dq SOB_UNDEFINED
is_null:
	dq SOB_UNDEFINED
is_integer:
	dq SOB_UNDEFINED
is_fraction:
	dq SOB_UNDEFINED
is_boolean:
	dq SOB_UNDEFINED
is_char:
	dq SOB_UNDEFINED
is_string:
	dq SOB_UNDEFINED
is_symbol:
	dq SOB_UNDEFINED
is_closure:
	dq SOB_UNDEFINED
is_pair:
	dq SOB_UNDEFINED
is_vector:
	dq SOB_UNDEFINED
is_eq:
	dq SOB_UNDEFINED
car:
	dq SOB_UNDEFINED
cdr:
	dq SOB_UNDEFINED
cons:
	dq SOB_UNDEFINED
integer_to_char:
	dq SOB_UNDEFINED
char_to_integer:
	dq SOB_UNDEFINED
yaniv_plus:
	dq SOB_UNDEFINED
variadic_plus:
	dq SOB_UNDEFINED
variadic_minus:
	dq SOB_UNDEFINED
yaniv_mult:
	dq SOB_UNDEFINED
variadic_mult:
	dq SOB_UNDEFINED
yaniv_div:
	dq SOB_UNDEFINED
variadic_div:
	dq SOB_UNDEFINED
yaniv_greater:
	dq SOB_UNDEFINED
variadic_greater:
	dq SOB_UNDEFINED
yaniv_smaller:
	dq SOB_UNDEFINED
variadic_smaller:
	dq SOB_UNDEFINED
yaniv_equivalent:
	dq SOB_UNDEFINED
variadic_equivalent:
	dq SOB_UNDEFINED
yaniv_remainder:
	dq SOB_UNDEFINED
yaniv_string_length:
	dq SOB_UNDEFINED
yaniv_string_ref:
	dq SOB_UNDEFINED
yaniv_vector_length:
	dq SOB_UNDEFINED
yaniv_vector_ref:
	dq SOB_UNDEFINED
yaniv_make_string:
	dq SOB_UNDEFINED
yaniv_make_vector:
	dq SOB_UNDEFINED
yaniv_convert_list_to_vector:
	dq SOB_UNDEFINED
yaniv_string_set:
	dq SOB_UNDEFINED
yaniv_vector_set:
	dq SOB_UNDEFINED
yaniv_symbol_to_string:
	dq SOB_UNDEFINED
yaniv_string_to_symbol:
	dq SOB_UNDEFINED
yaniv_apply:
	dq SOB_UNDEFINED

start_of_data:
sobVoid:
	dq MAKE_LITERAL(T_VOID, 0)
sobNil:
	dq MAKE_LITERAL(T_NIL, 0)
sobTrue:
	dq MAKE_LITERAL(T_BOOL,1)
sobFalse:
	dq MAKE_LITERAL(T_BOOL,0)
sobInteger0:
	dq MAKE_LITERAL(T_INTEGER,0)
sobInteger1:
	dq MAKE_LITERAL(T_INTEGER,1)
sobString0:
	MAKE_LITERAL_STRING "error"
sobIntegerNeg1:
	dq MAKE_LITERAL(T_INTEGER,-1)
my_symbols_link: dq sobNil
section .text
main:
;START Create symbol table
;END Create symbol table
	push 0
	push 0
	push 0
	push EXIT_COMPILER_SUCCESS
	START_FUNC
	;adding initial asm functions
	;Start Init Func Closure is_void
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_void
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_void
	;End Init Func Closure is_void
	;Body Function: is_void
Lambda_Body_Start_is_void:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_VOID
	jne Type_not_equal36
	mov rax, [sobTrue]
	jmp end_CMP_TYPE36
Type_not_equal36:
	mov rax, [sobFalse]
end_CMP_TYPE36:
	END_FUNC
Lambda_Body_End_is_void:
	mov [is_void],rax
;Start Init Func Closure is_null
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_null
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_null
	;End Init Func Closure is_null
	;Body Function: is_null
Lambda_Body_Start_is_null:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_NIL
	jne Type_not_equal35
	mov rax, [sobTrue]
	jmp end_CMP_TYPE35
Type_not_equal35:
	mov rax, [sobFalse]
end_CMP_TYPE35:
	END_FUNC
Lambda_Body_End_is_null:
	mov [is_null],rax
;Start Init Func Closure is_integer
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_integer
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_integer
	;End Init Func Closure is_integer
	;Body Function: is_integer
Lambda_Body_Start_is_integer:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_INTEGER
	jne Type_not_equal34
	mov rax, [sobTrue]
	jmp end_CMP_TYPE34
Type_not_equal34:
	mov rax, [sobFalse]
end_CMP_TYPE34:
	END_FUNC
Lambda_Body_End_is_integer:
	mov [is_integer],rax
;Start Init Func Closure is_fraction
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_fraction
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_fraction
	;End Init Func Closure is_fraction
	;Body Function: is_fraction
Lambda_Body_Start_is_fraction:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_FRACTION
	jne Type_not_equal33
	mov rax, [sobTrue]
	jmp end_CMP_TYPE33
Type_not_equal33:
	mov rax, [sobFalse]
end_CMP_TYPE33:
	END_FUNC
Lambda_Body_End_is_fraction:
	mov [is_fraction],rax
;Start Init Func Closure is_boolean
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_boolean
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_boolean
	;End Init Func Closure is_boolean
	;Body Function: is_boolean
Lambda_Body_Start_is_boolean:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_BOOL
	jne Type_not_equal32
	mov rax, [sobTrue]
	jmp end_CMP_TYPE32
Type_not_equal32:
	mov rax, [sobFalse]
end_CMP_TYPE32:
	END_FUNC
Lambda_Body_End_is_boolean:
	mov [is_boolean],rax
;Start Init Func Closure is_char
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_char
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_char
	;End Init Func Closure is_char
	;Body Function: is_char
Lambda_Body_Start_is_char:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_CHAR
	jne Type_not_equal31
	mov rax, [sobTrue]
	jmp end_CMP_TYPE31
Type_not_equal31:
	mov rax, [sobFalse]
end_CMP_TYPE31:
	END_FUNC
Lambda_Body_End_is_char:
	mov [is_char],rax
;Start Init Func Closure is_string
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_string
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_string
	;End Init Func Closure is_string
	;Body Function: is_string
Lambda_Body_Start_is_string:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_STRING
	jne Type_not_equal30
	mov rax, [sobTrue]
	jmp end_CMP_TYPE30
Type_not_equal30:
	mov rax, [sobFalse]
end_CMP_TYPE30:
	END_FUNC
Lambda_Body_End_is_string:
	mov [is_string],rax
;Start Init Func Closure is_symbol
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_symbol
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_symbol
	;End Init Func Closure is_symbol
	;Body Function: is_symbol
Lambda_Body_Start_is_symbol:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_SYMBOL
	jne Type_not_equal29
	mov rax, [sobTrue]
	jmp end_CMP_TYPE29
Type_not_equal29:
	mov rax, [sobFalse]
end_CMP_TYPE29:
	END_FUNC
Lambda_Body_End_is_symbol:
	mov [is_symbol],rax
;Start Init Func Closure is_closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_closure
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_closure
	;End Init Func Closure is_closure
	;Body Function: is_closure
Lambda_Body_Start_is_closure:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_CLOSURE
	jne Type_not_equal28
	mov rax, [sobTrue]
	jmp end_CMP_TYPE28
Type_not_equal28:
	mov rax, [sobFalse]
end_CMP_TYPE28:
	END_FUNC
Lambda_Body_End_is_closure:
	mov [is_closure],rax
;Start Init Func Closure is_pair
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_pair
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_pair
	;End Init Func Closure is_pair
	;Body Function: is_pair
Lambda_Body_Start_is_pair:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_PAIR
	jne Type_not_equal27
	mov rax, [sobTrue]
	jmp end_CMP_TYPE27
Type_not_equal27:
	mov rax, [sobFalse]
end_CMP_TYPE27:
	END_FUNC
Lambda_Body_End_is_pair:
	mov [is_pair],rax
;Start Init Func Closure is_vector
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_vector
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_vector
	;End Init Func Closure is_vector
	;Body Function: is_vector
Lambda_Body_Start_is_vector:
	START_FUNC
	mov rax, qword[rbp + 4 * 8]
	TYPE rax
	cmp rax,T_VECTOR
	jne Type_not_equal26
	mov rax, [sobTrue]
	jmp end_CMP_TYPE26
Type_not_equal26:
	mov rax, [sobFalse]
end_CMP_TYPE26:
	END_FUNC
Lambda_Body_End_is_vector:
	mov [is_vector],rax
;Start Init Func Closure is_eq
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_is_eq
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_is_eq
	;End Init Func Closure is_eq
	;Body Function: is_eq
Lambda_Body_Start_is_eq:
	START_FUNC
	mov r11, qword[rbp + 4 * 8]
	mov r12, qword[rbp + 5 * 8]
	mov r13, r11
	mov r14, r12
	TYPE r13
	TYPE r14
	cmp r13, T_SYMBOL
	jne REGULAR_COMPARE25
	cmp r14, T_SYMBOL
	jne REGULAR_COMPARE25
	DATA r11
	DATA r12
REGULAR_COMPARE25:
	cmp r11, r12
	jne Not_equal25
	mov rax, [sobTrue]
	jmp end_CMP25
Not_equal25:
	mov rax, [sobFalse]
end_CMP25:
	END_FUNC
Lambda_Body_End_is_eq:
	mov [is_eq],rax
;Start Init Func Closure CAR
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_CAR
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_CAR
	;End Init Func Closure CAR
	;Body Function: CAR
Lambda_Body_Start_CAR:
	START_FUNC
	mov r11, qword[rbp + 4 * 8]
	CAR r11
	mov rax, r11
	END_FUNC
Lambda_Body_End_CAR:
	mov [car],rax
;Start Init Func Closure CDR
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_CDR
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_CDR
	;End Init Func Closure CDR
	;Body Function: CDR
Lambda_Body_Start_CDR:
	START_FUNC
	mov r11, qword[rbp + 4 * 8]
	CDR r11
	mov rax, r11
	END_FUNC
Lambda_Body_End_CDR:
	mov [cdr],rax
;Start Init Func Closure cons
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_cons
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_cons
	;End Init Func Closure cons
	;Body Function: cons
Lambda_Body_Start_cons:
	START_FUNC
	mov rdi,8
	MY_MALLOC r11
	mov rdi, qword[rbp + (4 * 8)]
	mov [r11], rdi
	push r11
	mov rdi,8
	MY_MALLOC r12
	mov rdi, qword[rbp + (5 * 8)]
	mov [r12], rdi
	push r12
	mov rdi, 8
	MY_MALLOC r15
	pop r12
	pop r11
	MAKE_MALLOC_LITERAL_PAIR r15, r11, r12	;target-address,car-address,cdr-address 
	mov rax, [r15]
	END_FUNC
Lambda_Body_End_cons:
	mov [cons],rax
;Start Init Func Closure integer_to_char
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_integer_to_char
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_integer_to_char
	;End Init Func Closure integer_to_char
	;Body Function: integer_to_char
Lambda_Body_Start_integer_to_char:
	START_FUNC
	mov rdi, qword[rbp + (4 * 8)]
	mov rbx, rdi
	TYPE rbx
	cmp rbx, T_INTEGER
	jne ERORR_HAPPEND
	MY_MAKE_LITERAL rax ,T_CHAR ,rdi
	END_FUNC
Lambda_Body_End_integer_to_char:
	mov [integer_to_char],rax
;Start Init Func Closure char_to_integer
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_char_to_integer
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_char_to_integer
	;End Init Func Closure char_to_integer
	;Body Function: char_to_integer
Lambda_Body_Start_char_to_integer:
	START_FUNC
	mov rdi, qword[rbp + (4 * 8)]
	mov rbx, rdi
	TYPE rbx
	cmp rbx, T_CHAR
	jne ERORR_HAPPEND
	MY_MAKE_LITERAL rax ,T_INTEGER ,rdi
	END_FUNC
Lambda_Body_End_char_to_integer:
	mov [char_to_integer],rax
;Start Init Func Closure yaniv_plus
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_plus
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_plus
	;End Init Func Closure yaniv_plus
	;Body Function: yaniv_plus x+y
Lambda_Body_Start_yaniv_plus:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
	MY_PLUS_FRACTION rdi, rcx
	TRY_INTEGER_CONVERTION rax
	END_FUNC
Lambda_Body_End_yaniv_plus:
	mov [yaniv_plus],rax
;Start Init Func Closure yaniv_mult
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_mult
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_mult
	;End Init Func Closure yaniv_mult
	;Body Function: yaniv_mult x+y
Lambda_Body_Start_yaniv_mult:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
	MY_MULT_FRACTION rdi, rcx
	TRY_INTEGER_CONVERTION rax
	END_FUNC
Lambda_Body_End_yaniv_mult:
	mov [yaniv_mult],rax
;Start Init Func Closure yaniv_div
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_div
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_div
	;End Init Func Closure yaniv_div
	;Body Function: yaniv_div x+y
Lambda_Body_Start_yaniv_div:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
TEST1:
	MY_DIV_FRACTION rcx, rdi
	TRY_INTEGER_CONVERTION rax
	END_FUNC
Lambda_Body_End_yaniv_div:
	mov [yaniv_div],rax
;Start Init Func Closure yaniv_greater
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_greater
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_greater
	;End Init Func Closure yaniv_greater
	;Body Function: yaniv_greater
Lambda_Body_Start_yaniv_greater:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
	GREATER_THAN_FRACTION rcx, rdi
	END_FUNC
Lambda_Body_End_yaniv_greater:
	mov [yaniv_greater],rax
;Start Init Func Closure yaniv_smaller
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_smaller
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_smaller
	;End Init Func Closure yaniv_smaller
	;Body Function: yaniv_smaller
Lambda_Body_Start_yaniv_smaller:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
	SMALLER_THAN_FRACTION rcx, rdi
	END_FUNC
Lambda_Body_End_yaniv_smaller:
	mov [yaniv_smaller],rax
;Start Init Func Closure yaniv_equivalent
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_equivalent
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_equivalent
	;End Init Func Closure yaniv_equivalent
	;Body Function: yaniv_equivalent
Lambda_Body_Start_yaniv_equivalent:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	FRAC_CONVERTER rcx
	mov rcx,rax
	push rcx
	FRAC_CONVERTER rdi
	mov rdi,rax
	pop rcx
	EQUIVALENT_FRACTION rcx, rdi
	END_FUNC
Lambda_Body_End_yaniv_equivalent:
	mov [yaniv_equivalent],rax
;Start Init Func Closure yaniv_remainder
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_remainder
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_remainder
	;End Init Func Closure yaniv_remainder
	;Body Function: yaniv_remainder
Lambda_Body_Start_yaniv_remainder:
	START_FUNC
	mov rcx, qword[rbp + (4 * 8)]	;rcx =x
	mov rdi, qword[rbp + (5 * 8)]	;rdi =y
	DATA rcx
	DATA rdi
	mov rax,rcx
	cqo
	idiv rdi	; rax- result , rdx - reminder
	ADD_LITERAL_TYPE T_INTEGER, rdx
	mov rax,rdx
	END_FUNC
Lambda_Body_End_yaniv_remainder:
	mov [yaniv_remainder],rax
;Start Init Func Closure yaniv_string_length
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_string_length
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_string_length
	;End Init Func Closure yaniv_string_length
	;Body Function: yaniv_string_length
Lambda_Body_Start_yaniv_string_length:
	START_FUNC
	push r8
	mov r8, qword[rbp + (4 * 8)]
	STRING_LENGTH r8
	ADD_LITERAL_TYPE T_INTEGER, r8
	mov rax, r8
	pop r8
	END_FUNC
Lambda_Body_End_yaniv_string_length:
	mov [yaniv_string_length],rax
;Start Init Func Closure yaniv_string_ref
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_string_ref
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_string_ref
	;End Init Func Closure yaniv_string_ref
	;Body Function: yaniv_string_ref
Lambda_Body_Start_yaniv_string_ref:
	START_FUNC
	mov rbx, qword[rbp + (4 * 8)]	;hold the string
	mov rcx, qword[rbp + (5 * 8)]	;hold the index
	DATA rcx
	xor rdx,rdx
	STRING_REF dl,rbx,rcx
	ADD_LITERAL_TYPE T_CHAR, rdx
	mov rax,rdx
	END_FUNC
Lambda_Body_End_yaniv_string_ref:
	mov [yaniv_string_ref],rax
;Start Init Func Closure yaniv_vector_length
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_vector_length
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_vector_length
	;End Init Func Closure yaniv_vector_length
	;Body Function: yaniv_vector_length
Lambda_Body_Start_yaniv_vector_length:
	START_FUNC
	push r8
	mov r8, qword[rbp + (4 * 8)]
	VECTOR_LENGTH r8
	ADD_LITERAL_TYPE T_INTEGER, r8
	mov rax, r8
	pop r8
	END_FUNC
Lambda_Body_End_yaniv_vector_length:
	mov [yaniv_vector_length],rax
;Start Init Func Closure yaniv_vector_ref
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_vector_ref
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_vector_ref
	;End Init Func Closure yaniv_vector_ref
	;Body Function: yaniv_vector_ref
Lambda_Body_Start_yaniv_vector_ref:
	START_FUNC
	mov rbx, qword[rbp + (4 * 8)]	;hold the vector
	mov rcx, qword[rbp + (5 * 8)]	;hold the index
	DATA rcx
	VECTOR_REF rdx,rbx,rcx
	mov rax,rdx
	END_FUNC
Lambda_Body_End_yaniv_vector_ref:
	mov [yaniv_vector_ref],rax
;Start Init Func Closure yaniv_make_string
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_make_string
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_make_string
	;End Init Func Closure yaniv_make_string
	;Body Function: yaniv_make_string
Lambda_Body_Start_yaniv_make_string:
	START_FUNC
	mov r14, qword[rbp + (3 * 8)]	;hold number of arguments
	mov r9, qword[rbp + (4 * 8)]	;hold the length as sobInteger
	mov r8, qword[rbp + (5 * 8)]	;hold the SobChar
	cmp r14,1
	jne REGULAR_MAKE_STRING8	; check if num of arguments in 1, need to return chars of 0
	mov r8, 0
	ADD_LITERAL_TYPE T_CHAR ,r8
REGULAR_MAKE_STRING8:
	DATA r8	;Save the char
	DATA r9	;Save the number
	lea rdi, [r9*8]	;mul 8 for each char
	MY_MALLOC r11	;r11 saves the chars
	xor r15,r15
START_LOOP_CREATE_STRING8:
	cmp r15,r9
	jge END_LOOP_CREATE_STRING8
	mov [r11+r15], r8b	;insert a char to his position in the new string
	inc r15
	 jmp START_LOOP_CREATE_STRING8
END_LOOP_CREATE_STRING8:
	sub r11, start_of_data	;fix the pointer position accourding to malloc
	xor r12,r12
	mov r12,r9
	shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)
	or r12, r11
	shl r12, TYPE_BITS
	or r12 , T_STRING
	push r12

mov rdi,8
	MY_MALLOC rax	;rax saves a pointer to the new sobString
	pop r12
	mov rax,r12 
	END_FUNC
Lambda_Body_End_yaniv_make_string:
	mov [yaniv_make_string],rax
;Start Init Func Closure yaniv_make_vector
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_make_vector
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_make_vector
	;End Init Func Closure yaniv_make_vector
	;Body Function: yaniv_make_vector
Lambda_Body_Start_yaniv_make_vector:
	START_FUNC
	mov r14, qword[rbp + (3 * 8)]	;hold number of arguments
	mov r9, qword[rbp + (4 * 8)]	;hold the length as sobInteger
	mov r8, qword[rbp + (5 * 8)]	;hold the Sob to add
	cmp r14,1
	jne REGULAR_MAKE_VECTOR7	; check if num of arguments in 1, need to return integers of 0
	mov r8, 0
	ADD_LITERAL_TYPE T_INTEGER ,r8
REGULAR_MAKE_VECTOR7:
	DATA r9	;Save the number
	shl r9,3
	mov rdi, r9
	MY_MALLOC r11	;r11 saves the SOBs in the vector 
	xor r15,r15
START_LOOP_CREATE_VECTOR7:
	cmp r15,r9
	jge END_LOOP_CREATE_VECTOR7
	mov rdi, 8
	MY_MALLOC rax
	mov [rax], r8
	mov [r11+ r15], rax	;insert a sob to his position in the new vector
	add r15, 8
	 jmp START_LOOP_CREATE_VECTOR7
END_LOOP_CREATE_VECTOR7:
	sub r11, start_of_data	;fix the pointer position accourding to malloc
	xor r12,r12
	shr r9,3
	mov r12,r9
	shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)
	or r12, r11
	shl r12, TYPE_BITS
	or r12 , T_VECTOR
	push r12

mov rdi,8
	MY_MALLOC rax	;rax saves a pointer to the new Vector
	pop r12
	mov rax,r12 
	END_FUNC
Lambda_Body_End_yaniv_make_vector:
	mov [yaniv_make_vector],rax
;Start Init Func Closure yaniv_convert_list_to_vector
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_convert_list_to_vector
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_convert_list_to_vector
	;End Init Func Closure yaniv_convert_list_to_vector
	;Body Function: yaniv_convert_list_to_vector
Lambda_Body_Start_yaniv_convert_list_to_vector:
	START_FUNC
	mov r14, qword[rbp + (3 * 8)]	;hold number of arguments
	shl r14,3
	mov rdi, r14
	MY_MALLOC r11	;r11 saves the SOBs in the vector 
	xor r15,r15
START_LOOP_CREATE_VECTOR6:
	cmp r15, r14 
	jge END_LOOP_CREATE_VECTOR6
	mov rdi, 8
	MY_MALLOC rax
	mov rdi,  qword[rbp +  4*8 + r15]
	mov [rax],    rdi
	mov [r11+ r15], rax	;insert a sob to his position in the new vector
	add r15, 8
	 jmp START_LOOP_CREATE_VECTOR6
END_LOOP_CREATE_VECTOR6:
	sub r11, start_of_data	;fix the pointer position accourding to malloc
	xor r12,r12
	shr r14,3	;save the number of elements in the vector
	mov r12,r14
	shl r12, ((WORD_SIZE - TYPE_BITS) >> 1)
	or r12, r11
	shl r12, TYPE_BITS
	or r12 , T_VECTOR
	push r12

mov rdi,8
	MY_MALLOC rax	;rax saves a pointer to the new Vector
	pop r12
	mov rax,r12 
	END_FUNC
Lambda_Body_End_yaniv_convert_list_to_vector:
	mov [yaniv_convert_list_to_vector],rax
;Start Init Func Closure yaniv_string_set
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_string_set
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_string_set
	;End Init Func Closure yaniv_string_set
	;Body Function: yaniv_string_set
Lambda_Body_Start_yaniv_string_set:
	START_FUNC
	mov r14, qword[rbp + (4 * 8)]	;hold the string
	mov r9, qword[rbp + (5 * 8)]	;hold the SobInteger that represent the index to set
	mov r8, qword[rbp + (6 * 8)]	;hold the SobChar
	DATA r8	;r8 hold now the char itself
	DATA r9	;r9 hold now the index itself
	STRING_ELEMENTS r14
	mov [r14+ r9], r8b
	mov rax, [sobVoid] 
	END_FUNC
Lambda_Body_End_yaniv_string_set:
	mov [yaniv_string_set],rax
;Start Init Func Closure yaniv_vector_set
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_vector_set
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_vector_set
	;End Init Func Closure yaniv_vector_set
	;Body Function: yaniv_vector_set
Lambda_Body_Start_yaniv_vector_set:
	START_FUNC
	mov r14, qword[rbp + (4 * 8)]	;hold the vector
	mov r9, qword[rbp + (5 * 8)]	;hold the SobInteger that represent the index to set
	mov r8, qword[rbp + (6 * 8)]	;hold the Sob to put
	DATA r9	;r9 hold now the index itself
	VECTOR_ELEMENTS r14
	lea r9,[r9*8]	;r9 hold the position(index*bytes) in the vector
	push r9	;save the index
	mov rdi, 8
	MY_MALLOC rax
	mov [rax], r8
	pop r9	;pop the index
	mov [r14+ r9], rax	;insert a sob to his position in the new vector
	mov rax, [sobVoid] 
	END_FUNC
Lambda_Body_End_yaniv_vector_set:
	mov [yaniv_vector_set],rax
;Start Init Func Closure yaniv_symbol_to_string
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_symbol_to_string
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_symbol_to_string
	;End Init Func Closure yaniv_symbol_to_string
	;Body Function: yaniv_symbol_to_string
Lambda_Body_Start_yaniv_symbol_to_string:
	START_FUNC
	mov r14, qword[rbp + 4 * 8]	;hold the sobSymbol
	DATA r14
	add r14,start_of_data
	mov rax, [r14]
	END_FUNC
Lambda_Body_End_yaniv_symbol_to_string:
	mov [yaniv_symbol_to_string],rax
;Start Init Func Closure yaniv_string_to_symbol
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_string_to_symbol
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_string_to_symbol
	;End Init Func Closure yaniv_string_to_symbol
	;Body Function: yaniv_string_to_symbol
Lambda_Body_Start_yaniv_string_to_symbol:
	START_FUNC
	mov r14, qword[rbp + 4 * 8]	;hold the sobString
	mov rax, [my_symbols_link]	;hold the current symbol
START_LOOP2:
	cmp rax,sobNil
	je END_OF_LIST2
	push rax	;push the symbol
	mov rdi,[rax]
	mov rax, rdi
	DATA rax
	add rax,start_of_data
	mov rdi, [rax]
	mov rax, rdi
	cmp rax, r14
	je SYMBOL_FOUND2
	pop rax	;pop the current symbol
	add rax,8	;get the pointer to the next symbol
	mov rax, [rax]	;get the symbol inside the pointer link
	jmp START_LOOP2
END_OF_LIST2:
	push r14	;push string for create a symbol
	call CREATE_SYMBOL	;symbol will be in rax
	pop r14
	END_FUNC
SYMBOL_FOUND2:
	pop rax	;pop the current symbol
	mov rdi, [rax]
	mov rax,rdi
	END_FUNC
Lambda_Body_End_yaniv_string_to_symbol:
	mov [yaniv_string_to_symbol],rax
;Start Init Func Closure yaniv_apply
	PUSH_R8_R15
	push rdi
	mov rdi, 8 
	MY_MALLOC r12
	mov r13, 0	;library function don't have env
	MAKE_LITERAL_CLOSURE r12, r13 ,Lambda_Body_Start_yaniv_apply
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End_yaniv_apply
	;End Init Func Closure yaniv_apply
	;Body Function: yaniv_apply
Lambda_Body_Start_yaniv_apply:
	START_FUNC
	mov r15, [rbp] 
	mov r8, qword[rbp + 1 * 8]	;save the return address
	mov r9, qword[rbp + 4 * 8]	;hold the function
	mov r10, qword[rbp + 5 * 8]	;hold the list
	push r10
	call list_length_asm	;length will be in rax
	pop r10
	mov r11, rax	;rax will hold the list length
	lea rsp, [rsp+ 6*8]	;skip over s,f,arg count,env
	mov r12, r11	;r12 args count
LOOP_PUSH_ARGS1:
	cmp r12,0
	je END_LOOP_PUSH_ARGS1
	mov r13, r10
	CAR r13
	push r13
	CDR r10
	dec r12
	jmp LOOP_PUSH_ARGS1
END_LOOP_PUSH_ARGS1:
	mov r13, rsp
	lea r14, [r13+ r11*8 -8]
START_FLIP_STACK1:
	cmp r14, r13
	jle END_FLIP_STACK1
	mov rcx , qword[r13] 
	mov rsi, qword[r14]
	mov qword[r13], rsi
	mov qword[r14], rcx
	add r13, 8
	sub r14,8
	jmp START_FLIP_STACK1
END_FLIP_STACK1:
	push r11	;push number of arguments in list
	mov r10, r9
	CLOSURE_ENV r9
	push r9	;push the CLOSURE_ENV of f
	push r8	;save the return address
	CLOSURE_CODE r10
	mov rax, r10
	mov rbp, r15
	jmp rax
Lambda_Body_End_yaniv_apply:
	mov [yaniv_apply],rax

	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop29:
	cmp rdx , r12
	jge endParamLoop29
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop29
endParamLoop29:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start29	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End29
	;End Closure
	;Start lambda body
Lambda_Body_Start29:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax ,[sobInteger0]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[is_eq]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End29:
	;End lambda body
	mov [Free_variable_17],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop30:
	cmp rdx , r12
	jge endParamLoop30
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop30
endParamLoop30:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start30	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End30
	;End Closure
	;Start lambda body
Lambda_Body_Start30:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax ,[sobFalse]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[is_eq]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_24
	mov rax ,[sobTrue]

	jmp L_if3_exit_24
L_if3_else_24:
	mov rax ,[sobFalse]

L_if3_exit_24:
	END_FUNC
Lambda_Body_End30:
	;End lambda body
	mov [Free_variable_18],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop27:
	cmp rdx , r12
	jge endParamLoop27
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop27
endParamLoop27:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start27	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End27
	;End Closure
	;Start lambda body
Lambda_Body_Start27:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_integer]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	jne L_or_exit_1
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_fraction]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	L_or_exit_1:
	END_FUNC
Lambda_Body_End27:
	;End lambda body
	mov [Free_variable_15],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop28:
	cmp rdx , r12
	jge endParamLoop28
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop28
endParamLoop28:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start28	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End28
	;End Closure
	;Start lambda body
Lambda_Body_Start28:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[Free_variable_15]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End28:
	;End lambda body
	mov [Free_variable_16],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop25:
	cmp rdx , r12
	jge endParamLoop25
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop25
endParamLoop25:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start25	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End25
	;End Closure
	;Start lambda body
Lambda_Body_Start25:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_integer]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_21
	mov rax ,[sobInteger1]

	jmp L_if3_exit_21
L_if3_else_21:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_fraction]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_20
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_20
L_if3_else_20:
	mov rax ,[sobString0]

L_if3_exit_20:

L_if3_exit_21:
	END_FUNC
Lambda_Body_End25:
	;End lambda body
	mov [Free_variable_13],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop26:
	cmp rdx , r12
	jge endParamLoop26
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop26
endParamLoop26:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start26	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End26
	;End Closure
	;Start lambda body
Lambda_Body_Start26:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_integer]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_23
	mov rax, [rbp +(4+ 0) * 8]

	jmp L_if3_exit_23
L_if3_else_23:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_fraction]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_22
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_22
L_if3_else_22:
	mov rax ,[sobString0]

L_if3_exit_22:

L_if3_exit_23:
	END_FUNC
Lambda_Body_End26:
	;End lambda body
	mov [Free_variable_14],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop23:
	cmp rdx , r12
	jge endParamLoop23
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop23
endParamLoop23:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start23	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End23
	;End Closure
	;Start lambda body
Lambda_Body_Start23:
	START_FUNC
	FIX_FOR_OPT10:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List10:
	cmp r14,0
	jle End_Create_List10
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List10
End_Create_List10:
	mov qword[rbp + 3 * 8],1
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +1)], rdi
	cmp r10, 0	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK10
	mov r9, r10 
	sub r9 ,0
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK10
	mov r9, 0
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP10:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP10
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP10
END_LOOP_MOVE_STACK_UP10:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK10:
	pop rdi
	POP_R8_R15
	mov rax, [rbp +(4+ 0) * 8]
	END_FUNC
Lambda_Body_End23:
	;End lambda body
	mov [Free_variable_11],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop24:
	cmp rdx , r12
	jge endParamLoop24
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop24
endParamLoop24:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start24	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End24
	;End Closure
	;Start lambda body
Lambda_Body_Start24:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 2) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_19
	mov rax, [rbp +(4+ 1) * 8]

	jmp L_if3_exit_19
L_if3_else_19:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 2) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 2) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 2
	mov rax, [rbp +(4+ 0) * 8]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_19:
	END_FUNC
Lambda_Body_End24:
	;End lambda body
	mov [Free_variable_12],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop21:
	cmp rdx , r12
	jge endParamLoop21
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop21
endParamLoop21:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start21	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End21
	;End Closure
	;Start lambda body
Lambda_Body_Start21:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_17
	mov rax ,[sobInteger0]

	jmp L_if3_exit_17
L_if3_else_17:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 1
	mov rax ,[Free_variable_9]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax ,[sobInteger1]
	push rax
	push 2
	mov rax ,[variadic_plus]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_17:
	END_FUNC
Lambda_Body_End21:
	;End lambda body
	mov [Free_variable_9],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop22:
	cmp rdx , r12
	jge endParamLoop22
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop22
endParamLoop22:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start22	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End22
	;End Closure
	;Start lambda body
Lambda_Body_Start22:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_18
	mov rax ,[sobNil]

	jmp L_if3_exit_18
L_if3_else_18:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_10]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 1
	mov rax, [rbp +(4+ 0) * 8]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[cons]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_18:
	END_FUNC
Lambda_Body_End22:
	;End lambda body
	mov [Free_variable_10],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop18:
	cmp rdx , r12
	jge endParamLoop18
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop18
endParamLoop18:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start18	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End18
	;End Closure
	;Start lambda body
Lambda_Body_Start18:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_14
	mov rax, [rbp +(4+ 1) * 8]

	jmp L_if3_exit_14
L_if3_else_14:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[Free_variable_7]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[cons]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_14:
	END_FUNC
Lambda_Body_End18:
	;End lambda body
	mov [Free_variable_7],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop19:
	cmp rdx , r12
	jge endParamLoop19
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop19
endParamLoop19:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start19	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End19
	;End Closure
	;Start lambda body
Lambda_Body_Start19:
	START_FUNC
	FIX_FOR_OPT9:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List9:
	cmp r14,0
	jle End_Create_List9
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List9
End_Create_List9:
	mov qword[rbp + 3 * 8],1
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +1)], rdi
	cmp r10, 0	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK9
	mov r9, r10 
	sub r9 ,0
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK9
	mov r9, 0
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP9:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP9
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP9
END_LOOP_MOVE_STACK_UP9:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK9:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax ,[sobInteger1]
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[Free_variable_9]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[variadic_equivalent]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_16
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_16
L_if3_else_16:
	;Start applic
	push qword[sobNil]
	mov rax ,[sobInteger0]
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 1
	mov rax ,[Free_variable_9]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[variadic_equivalent]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_15
	mov rax ,[sobNil]

	jmp L_if3_exit_15
L_if3_else_15:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobNil]
	push rax
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 2
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop20:
	cmp rdx , r12
	jge endParamLoop20
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop20
endParamLoop20:
	pop rdx
	POP_R8_R15

	;Building bvars
	mov r13,qword[rbp +2*8]
	PUSH_R8_R15
	push rdi
	mov r15,1

startEnvLoop20:
	cmp r15, 0
	jl endEnvLoop20
	mov rdi, qword [r13 + 8 * r15]
	mov [r13 + 8 * (r15 + 1)] , rdi
	dec r15
	jmp startEnvLoop20
endEnvLoop20:

	pop rdi
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start20	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End20
	;End Closure
	;Start lambda body
Lambda_Body_Start20:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_7]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End20:
	;End lambda body
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_15:

L_if3_exit_16:
	END_FUNC
Lambda_Body_End19:
	;End lambda body
	mov [Free_variable_8],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop16:
	cmp rdx , r12
	jge endParamLoop16
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop16
endParamLoop16:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start16	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End16
	;End Closure
	;Start lambda body
Lambda_Body_Start16:
	START_FUNC
	FIX_FOR_OPT8:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List8:
	cmp r14,1
	jle End_Create_List8
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List8
End_Create_List8:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK8
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK8
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP8:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP8
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP8
END_LOOP_MOVE_STACK_UP8:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK8:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_6]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End16:
	;End lambda body
	mov [Free_variable_5],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop17:
	cmp rdx , r12
	jge endParamLoop17
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop17
endParamLoop17:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start17	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End17
	;End Closure
	;Start lambda body
Lambda_Body_Start17:
	START_FUNC
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_13
	mov rax ,[sobNil]

	jmp L_if3_exit_13
L_if3_else_13:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax ,[cdr]
	push rax
	push 2
	mov rax ,[Free_variable_3]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_6]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax ,[car]
	push rax
	push 2
	mov rax ,[Free_variable_3]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[yaniv_apply]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[cons]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_13:
	END_FUNC
Lambda_Body_End17:
	;End lambda body
	mov [Free_variable_6],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop14:
	cmp rdx , r12
	jge endParamLoop14
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop14
endParamLoop14:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start14	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End14
	;End Closure
	;Start lambda body
Lambda_Body_Start14:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_12
	mov rax ,[sobNil]

	jmp L_if3_exit_12
L_if3_else_12:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_3]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 1
	mov rax, [rbp +(4+ 0) * 8]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[cons]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_12:
	END_FUNC
Lambda_Body_End14:
	;End lambda body
	mov [Free_variable_3],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop15:
	cmp rdx , r12
	jge endParamLoop15
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop15
endParamLoop15:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start15	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End15
	;End Closure
	;Start lambda body
Lambda_Body_Start15:
	START_FUNC
	FIX_FOR_OPT7:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List7:
	cmp r14,0
	jle End_Create_List7
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List7
End_Create_List7:
	mov qword[rbp + 3 * 8],1
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +1)], rdi
	cmp r10, 0	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK7
	mov r9, r10 
	sub r9 ,0
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK7
	mov r9, 0
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP7:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP7
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP7
END_LOOP_MOVE_STACK_UP7:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK7:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobInteger0]
	push rax
	mov rax ,[yaniv_plus]
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End15:
	;End lambda body
	mov [variadic_plus],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop11:
	cmp rdx , r12
	jge endParamLoop11
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop11
endParamLoop11:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start11	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End11
	;End Closure
	;Start lambda body
Lambda_Body_Start11:
	START_FUNC
	FIX_FOR_OPT5:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List5:
	cmp r14,1
	jle End_Create_List5
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List5
End_Create_List5:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK5
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK5
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP5:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP5
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP5
END_LOOP_MOVE_STACK_UP5:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK5:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_11
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobIntegerNeg1]
	push rax
	push 2
	mov rax ,[variadic_mult]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_11
L_if3_else_11:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 2
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop12:
	cmp rdx , r12
	jge endParamLoop12
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop12
endParamLoop12:
	pop rdx
	POP_R8_R15

	;Building bvars
	mov r13,qword[rbp +2*8]
	PUSH_R8_R15
	push rdi
	mov r15,1

startEnvLoop12:
	cmp r15, 0
	jl endEnvLoop12
	mov rdi, qword [r13 + 8 * r15]
	mov [r13 + 8 * (r15 + 1)] , rdi
	dec r15
	jmp startEnvLoop12
endEnvLoop12:

	pop rdi
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start12	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End12
	;End Closure
	;Start lambda body
Lambda_Body_Start12:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobIntegerNeg1]
	push rax
	push 2
	mov rax ,[variadic_mult]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End12:
	;End lambda body
	push rax
	push 2
	mov rax ,[Free_variable_10]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[variadic_plus]
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_11:
	END_FUNC
Lambda_Body_End11:
	;End lambda body
	mov [variadic_minus],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop13:
	cmp rdx , r12
	jge endParamLoop13
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop13
endParamLoop13:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start13	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End13
	;End Closure
	;Start lambda body
Lambda_Body_Start13:
	START_FUNC
	FIX_FOR_OPT6:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List6:
	cmp r14,0
	jle End_Create_List6
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List6
End_Create_List6:
	mov qword[rbp + 3 * 8],1
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +1)], rdi
	cmp r10, 0	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK6
	mov r9, r10 
	sub r9 ,0
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK6
	mov r9, 0
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP6:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP6
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP6
END_LOOP_MOVE_STACK_UP6:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK6:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobInteger1]
	push rax
	mov rax ,[yaniv_mult]
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End13:
	;End lambda body
	mov [variadic_mult],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop9:
	cmp rdx , r12
	jge endParamLoop9
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop9
endParamLoop9:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start9	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End9
	;End Closure
	;Start lambda body
Lambda_Body_Start9:
	START_FUNC
	FIX_FOR_OPT3:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List3:
	cmp r14,1
	jle End_Create_List3
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List3
End_Create_List3:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK3
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK3
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP3:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP3
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP3
END_LOOP_MOVE_STACK_UP3:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK3:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_9
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	mov rax ,[sobInteger1]
	push rax
	push 2
	mov rax ,[yaniv_div]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_9
L_if3_else_9:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax ,[sobInteger1]
	push rax
	mov rax ,[variadic_mult]
	push rax
	push 3
	mov rax ,[Free_variable_12]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[yaniv_div]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax ,[sobInteger1]
	push rax
	push 2
	mov rax ,[variadic_mult]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_9:
	END_FUNC
Lambda_Body_End9:
	;End lambda body
	mov [variadic_div],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop10:
	cmp rdx , r12
	jge endParamLoop10
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop10
endParamLoop10:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start10	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End10
	;End Closure
	;Start lambda body
Lambda_Body_Start10:
	START_FUNC
	FIX_FOR_OPT4:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List4:
	cmp r14,1
	jle End_Create_List4
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List4
End_Create_List4:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK4
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK4
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP4:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP4
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP4
END_LOOP_MOVE_STACK_UP4:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK4:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_10
	mov rax ,[sobTrue]

	jmp L_if3_exit_10
L_if3_else_10:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_4]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_10:
	END_FUNC
Lambda_Body_End10:
	;End lambda body
	mov [variadic_greater],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop7:
	cmp rdx , r12
	jge endParamLoop7
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop7
endParamLoop7:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start7	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End7
	;End Closure
	;Start lambda body
Lambda_Body_Start7:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_7
	mov rax ,[sobTrue]

	jmp L_if3_exit_7
L_if3_else_7:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[yaniv_greater]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_6
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[Free_variable_4]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_6
L_if3_else_6:
	mov rax ,[sobFalse]

L_if3_exit_6:

L_if3_exit_7:
	END_FUNC
Lambda_Body_End7:
	;End lambda body
	mov [Free_variable_4],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop8:
	cmp rdx , r12
	jge endParamLoop8
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop8
endParamLoop8:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start8	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End8
	;End Closure
	;Start lambda body
Lambda_Body_Start8:
	START_FUNC
	FIX_FOR_OPT2:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List2:
	cmp r14,1
	jle End_Create_List2
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List2
End_Create_List2:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK2
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK2
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP2:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP2
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP2
END_LOOP_MOVE_STACK_UP2:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK2:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_8
	mov rax ,[sobTrue]

	jmp L_if3_exit_8
L_if3_else_8:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_1]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_8:
	END_FUNC
Lambda_Body_End8:
	;End lambda body
	mov [variadic_smaller],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop5:
	cmp rdx , r12
	jge endParamLoop5
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop5
endParamLoop5:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start5	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End5
	;End Closure
	;Start lambda body
Lambda_Body_Start5:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_4
	mov rax ,[sobTrue]

	jmp L_if3_exit_4
L_if3_else_4:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[yaniv_smaller]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_3
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[Free_variable_1]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_3
L_if3_else_3:
	mov rax ,[sobFalse]

L_if3_exit_3:

L_if3_exit_4:
	END_FUNC
Lambda_Body_End5:
	;End lambda body
	mov [Free_variable_1],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop6:
	cmp rdx , r12
	jge endParamLoop6
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop6
endParamLoop6:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start6	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End6
	;End Closure
	;Start lambda body
Lambda_Body_Start6:
	START_FUNC
	FIX_FOR_OPT1:
	PUSH_R8_R15
	push rdi
	mov rdi, 8
	MY_MALLOC r15
	mov rdi, qword[sobNil]
	mov qword[r15], rdi
	mov r14, qword[rbp+ 3*8]
	mov r10, r14
Start_Create_List1:
	cmp r14,1
	jle End_Create_List1
	mov rdi, 8
	MY_MALLOC r13
	mov rdi, qword[rbp+ 8 * (3 + r14)]
	mov qword[r13] , rdi
	mov rdi, 8
	MY_MALLOC r12
	MAKE_MALLOC_LITERAL_PAIR r12, r13, r15
	mov r15, r12
	dec r14
	jmp Start_Create_List1
End_Create_List1:
	mov qword[rbp + 3 * 8],2
	mov rdi, qword[r15]
	mov qword[rbp + 8 * (3 +2)], rdi
	cmp r10, 1	; if number of arguments for lambda = number of arguments from applic
	je NO_NEED_TO_MOVE_STACK1
	mov r9, r10 
	sub r9 ,1
	cmp r9, 0 	; if number of arguments from applic - arguments from lambda = 0
	je NO_NEED_TO_MOVE_STACK1
	mov r9, 1
	add r10, 3
	add r9, 4
START_LOOP_MOVE_STACK_UP1:
	cmp r10, 0
	jl END_LOOP_MOVE_STACK_UP1
	mov rdi, qword[rbp + 8* r9]
	mov qword[rbp + 8 * r10], rdi
	dec r10
	dec r9
	jmp START_LOOP_MOVE_STACK_UP1
END_LOOP_MOVE_STACK_UP1:
	inc r9
	neg r9
	shl r9,3
	add rbp,r9
	add rsp,r9
NO_NEED_TO_MOVE_STACK1:
	pop rdi
	POP_R8_R15
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_5
	mov rax ,[sobTrue]

	jmp L_if3_exit_5
L_if3_else_5:
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[Free_variable_2]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

L_if3_exit_5:
	END_FUNC
Lambda_Body_End6:
	;End lambda body
	mov [variadic_equivalent],rax
	mov rax, [sobVoid]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop4:
	cmp rdx , r12
	jge endParamLoop4
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop4
endParamLoop4:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start4	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End4
	;End Closure
	;Start lambda body
Lambda_Body_Start4:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[is_null]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_2
	mov rax ,[sobTrue]

	jmp L_if3_exit_2
L_if3_else_2:
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	mov rax, [rbp +(4+ 0) * 8]
	push rax
	push 2
	mov rax ,[yaniv_equivalent]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	cmp rax, [sobFalse]
	je L_if3_else_1
	;Start applic
	push qword[sobNil]
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[cdr]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	;Start applic
	push qword[sobNil]
	mov rax, [rbp +(4+ 1) * 8]
	push rax
	push 1
	mov rax ,[car]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	push rax
	push 2
	mov rax ,[Free_variable_2]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic

	jmp L_if3_exit_1
L_if3_else_1:
	mov rax ,[sobFalse]

L_if3_exit_1:

L_if3_exit_2:
	END_FUNC
Lambda_Body_End4:
	;End lambda body
	mov [Free_variable_2],rax
	mov rax, [sobVoid]
	;Start applic
	push qword[sobNil]
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop1:
	cmp rdx , r12
	jge endParamLoop1
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop1
endParamLoop1:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start1	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End1
	;End Closure
	;Start lambda body
Lambda_Body_Start1:
	START_FUNC
	;Start applic
	push qword[sobNil]
	mov rax ,[sobFalse]
	push rax
	push 1
	;Start applic
	push qword[sobNil]
	mov rax ,[sobTrue]
	push rax
	push 1
	mov rax, [rbp +(4+ 0) * 8]
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	END_FUNC
Lambda_Body_End1:
	;End lambda body
	push rax
	push 1
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 1
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop2:
	cmp rdx , r12
	jge endParamLoop2
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop2
endParamLoop2:
	pop rdx
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start2	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End2
	;End Closure
	;Start lambda body
Lambda_Body_Start2:
	START_FUNC
	;Start Closure
	PUSH_R8_R15
	push rdi
	mov rdi, 8 	;size
	MY_MALLOC r12	;malloc for rax(save the closure)
	mov rdi, 8 * 2
	push r12
	MY_MALLOC r13	;malloc for rbx(save the env)
	pop r12
	mov rdi, [rbp + 3*8]
	shl rdi, 3
	push r12
	push r13
	MY_MALLOC r14	;malloc for rcx(save the pvars)
	pop r13
	pop r12
	;building pvars
	PUSH_R8_R15
	push rdx
	mov r12 , qword[rbp + 3 * 8]
	xor rdx, rdx
paramLoop3:
	cmp rdx , r12
	jge endParamLoop3
	xor r15,r15
	mov r15, qword[rbp + (rdx + 4) *8]
	mov [r14 + 8*rdx], r15
	inc rdx
	jmp paramLoop3
endParamLoop3:
	pop rdx
	POP_R8_R15

	;Building bvars
	mov r13,qword[rbp +2*8]
	PUSH_R8_R15
	push rdi
	mov r15,1

startEnvLoop3:
	cmp r15, 0
	jl endEnvLoop3
	mov rdi, qword [r13 + 8 * r15]
	mov [r13 + 8 * (r15 + 1)] , rdi
	dec r15
	jmp startEnvLoop3
endEnvLoop3:

	pop rdi
	POP_R8_R15

	mov [r13 + 0], r14	;move the pvars to the env
	MAKE_LITERAL_CLOSURE r12, r13, Lambda_Body_Start3	;target,env,code
	mov rax,qword[r12]
	pop rdi
	POP_R8_R15
	jmp Lambda_Body_End3
	;End Closure
	;Start lambda body
Lambda_Body_Start3:
	START_FUNC
	mov rax,qword[rbp + 8 * 2]
	mov rax,qword[rax + 8 * 0]
	mov rax,qword[rax + 8 * 0]
	END_FUNC
Lambda_Body_End3:
	;End lambda body
	END_FUNC
Lambda_Body_End2:
	;End lambda body
	mov rbx,rax
	CLOSURE_ENV rbx
	push rbx
	CLOSURE_CODE rax
	call rax
	mov rbx, [rsp+1*8]	;num of arguments
	shl rbx,3
	add rsp, rbx 
	pop rbx 
	pop rbx 
	pop rbx 
	;End applic
	PUSH_R8_R15
	push rax
	cmp rax,[sobVoid]
	je DONT_PRINT1
	call write_sob
	mov rax, 0
	mov rdi, my_newline
	call printf
	DONT_PRINT1:
	pop rax
	POP_R8_R15
EXIT_COMPILER_SUCCESS:
	pop rbx
	mov rax, 0
	call exit
ERORR_HAPPEND:
	push 0	;TODO: how to exit normally
	ret
