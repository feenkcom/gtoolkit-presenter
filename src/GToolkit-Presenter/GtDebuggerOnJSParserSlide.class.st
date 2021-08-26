Class {
	#name : 'GtDebuggerOnJSParserSlide',
	#superclass : 'GtSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'accessing' }
GtDebuggerOnJSParserSlide >> create [
	| context process debuggingSession |
	context := [ JSParser parse: 'if (x == 42) return true;' ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.	
	debuggingSession := (process 
		newDebugSessionNamed: 'JSParser debugging'
		startedAt: process suspendedContext).
	[ SmaCCParserDebugSession handlesContext: debuggingSession context ]
		whileFalse: [ debuggingSession stepInto ].
	^ (GtMoldableDebugger on: debuggingSession) inPager
]
