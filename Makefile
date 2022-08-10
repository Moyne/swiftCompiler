default:
	jflex scanner.jflex
	java java_cup.MainDrawTree parser.cup
	javac *.java