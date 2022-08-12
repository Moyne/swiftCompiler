default:
	jflex scanner.jflex
	java java_cup.Main -expect 11 parser.cup
	javac *.java