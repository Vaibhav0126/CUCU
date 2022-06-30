i have this cucu compiler as specifed in Lab 8 (only mantioned data type and control statmants were used in it)
commands to compile compiler : 
				step 1 : bison -d cucu.y
				step 2 : flex cucu.l    
				step 3 : g++ cucu.tab.c lex.yy.c -lfl -o cucu
command to compile and run cucu code file 
				step 1 : ./cucu [FILENAME.cu]
		
it will create to additional file Laxer.txt and pharser.txt as expected 