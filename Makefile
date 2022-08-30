default:
	jflex scanner.jflex
	java java_cup.Main -expect 4 parser.cup
	javac *.java
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~