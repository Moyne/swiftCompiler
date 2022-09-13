default:
	jflex scanner.jflex
	java java_cup.Main -expect 7 parser.cup
	javac *.java
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
builds:
	rm binarySearch.ll
	rm bubble.ll
	rm division.ll
	rm doubleRet.ll
	rm fibonacci.ll
	rm floydTriangle.ll
	rm helloWorld.ll
	rm multidimArray.ll
	rm stringRet.ll
	java Main binarySearch.swift >> binarySearch.ll
	java Main bubble.swift >> bubble.ll
	java Main division.swift >> division.ll
	java Main doubleRet.swift >> doubleRet.ll
	java Main fibonacci.swift >> fibonacci.ll
	java Main floydTriangle.swift >> floydTriangle.ll
	java Main helloWorld.swift >> helloWorld.ll
	java Main multidimArray.swift >> multidimArray.ll
	java Main stringRet.swift >> stringRet.ll