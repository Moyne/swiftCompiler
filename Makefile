default:
	jflex scanner.jflex
	java java_cup.Main -expect 110 parser.cup
	javac *.java