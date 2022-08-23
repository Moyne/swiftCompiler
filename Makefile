default:
	jflex scanner.jflex
	java java_cup.Main -expect 10 parser.cup
	javac *.java