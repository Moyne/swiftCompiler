default:
	jflex scanner.jflex
	java java_cup.Main -expect 3 parser.cup
	javac *.java
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
builds:
	java Main binarySearch.swift >> binarySearch.ll
	java Main bubble.swift >> bubble.ll
	java Main division.swift >> division.ll
	java Main doubleRet.swift >> doubleRet.ll
	java Main fibonacci.swift >> fibonacci.ll
	java Main floydTortoise.swift >> floydTortoise.ll
	java Main floydTriangle.swift >> floydTriangle.ll
	java Main helloWorld.swift >> helloWorld.ll
	java Main multidimArray.swift >> multidimArray.ll
	java Main stringRet.swift >> stringRet.ll
cleanll:
	rm -vfr *.ll
buildsRm:
	rm -vfr *.ll
	java Main binarySearch.swift >> binarySearch.ll
	java Main bubble.swift >> bubble.ll
	java Main division.swift >> division.ll
	java Main doubleRet.swift >> doubleRet.ll
	java Main fibonacci.swift >> fibonacci.ll
	java Main floydTortoise.swift >> floydTortoise.ll
	java Main floydTriangle.swift >> floydTriangle.ll
	java Main helloWorld.swift >> helloWorld.ll
	java Main multidimArray.swift >> multidimArray.ll
	java Main stringRet.swift >> stringRet.ll
run:
	-lli binarySearch.ll & lli bubble.ll & lli division.ll & lli doubleRet.ll & lli fibonacci.ll & lli floydTortoise.ll & lli floydTriangle.ll & lli helloWorld.ll & lli multidimArray.ll & lli stringRet.ll
	