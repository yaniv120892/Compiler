

%:
	echo '(load "compiler.scm") (compile-scheme-file "$(MAKECMDGOALS).scm" "$(MAKECMDGOALS).s")' | scheme -q
	nasm -f elf64 -o $(MAKECMDGOALS).o $(MAKECMDGOALS).s
	gcc -m64 $(MAKECMDGOALS).o -o $(MAKECMDGOALS)

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o $(MAKECMDGOALS).s $(MAKECMDGOALS)
