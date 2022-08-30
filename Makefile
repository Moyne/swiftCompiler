default:
	jflex scanner.jflex
	java java_cup.Main -expect 7 parser.cup
	javac *.java
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~