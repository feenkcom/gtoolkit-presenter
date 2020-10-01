Class {
	#name : #GtSlidesHDReport,
	#superclass : #HDReport,
	#instVars : [
		'stream',
		'progressFile',
		'examples',
		'executionTime',
		'examplesPosition',
		'examplesErrors',
		'examplesFailures',
		'examplesExecuted',
		'title'
	],
	#category : #'GToolkit-Presenter-Runtime'
}

{ #category : #running }
GtSlidesHDReport class >> runPackage: aString [
	^ self new 
		initializeExamples: (RPackage organizer packageNamed: aString) gtSlidesAllContained 
		entitled: aString;
		run;
		done
]

{ #category : #private }
GtSlidesHDReport >> beginExample: anExample runBlock: aBlock [
	| time |
	progressFile 
		nextPutAll: 'starting slide: ';
		nextPutAll: anExample definingMethod methods last methodClass name;
		nextPutAll: '>>';
		nextPutAll: anExample definingMethod methods last selector;
		nextPutAll: ' ... '; 
		flush.
	time := aBlock timeToRun.
	stream tab; 
		nextPutAll: '<testcase classname="'; 
		nextPutAll: (self encode: (anExample definingMethod methods last methodClass category copyReplaceAll: '-' with: '.')); 
		nextPut: $.; nextPutAll: (self encode: anExample definingMethod methods last methodClass name); 
		nextPutAll: '" name="'; nextPutAll: (self encode: anExample definingMethod methods last selector); 
		nextPutAll: '" time="'; print: (time asMilliSeconds / 1000.0); 
		nextPutAll: '">'; 
		lf
	

]

{ #category : #running }
GtSlidesHDReport >> done [
	"just close the file"
	[ progressFile close ] on: Error do: []
]

{ #category : #private }
GtSlidesHDReport >> endExample [
	stream tab; nextPutAll: '</testcase>'; lf.
	progressFile nextPutAll: 'finished' ; crlf; flush.

]

{ #category : #initialization }
GtSlidesHDReport >> examples: aCollection [
	examples := aCollection
]

{ #category : #accessing }
GtSlidesHDReport >> examplesErrors [
	^ examplesErrors
]

{ #category : #accessing }
GtSlidesHDReport >> examplesExecuted [ 
	^ examplesExecuted
]

{ #category : #accessing }
GtSlidesHDReport >> examplesFailures [
	^ examplesFailures
]

{ #category : #accessing }
GtSlidesHDReport >> examplesPassing [
	^ self examplesExecuted - self examplesFailures - self examplesErrors
]

{ #category : #accessing }
GtSlidesHDReport >> examplesSkipped [
	^ self examplesTotal - self examplesExecuted
]

{ #category : #accessing }
GtSlidesHDReport >> examplesTotal [
	^ examples size
]

{ #category : #testing }
GtSlidesHDReport >> hasErrors [ 
	^ examplesErrors ~= 0
]

{ #category : #testing }
GtSlidesHDReport >> hasFailures [ 
	^ examplesFailures ~= 0
]

{ #category : #initialization }
GtSlidesHDReport >> initialize [
	| aFile |
	super initialize.
	executionTime := 0 asDuration.
	examplesPosition := 0.
	examplesExecuted := 0.
	examplesFailures := 0.
	examplesErrors := 0.
	
	aFile := File named: 'progress-slides.log'.
	aFile delete.
	progressFile := ZnCharacterWriteStream
			on: (aFile writeStream setToEnd; yourself)
			encoding: 'utf8'.
	
]

{ #category : #initialization }
GtSlidesHDReport >> initializeExamples: aCollection entitled: aString [
	examples := aCollection.
	title := aString
]

{ #category : #running }
GtSlidesHDReport >> run [
	Author uniqueInstance
		ifUnknownAuthorUse: 'hudson'
		during: [ [ 
			self setUp.
			executionTime := [ self runAll ]
				timeToRun ]
					ensure: [ self tearDown ] ]
]

{ #category : #running }
GtSlidesHDReport >> runAll [
	CurrentExecutionEnvironment runTestsBy: [ 
		examples do: [ :each | self runExample: each ] ]
]

{ #category : #running }
GtSlidesHDReport >> runExample: aSlide [
	| error stack |
	self
		beginExample: aSlide
		runBlock: [
			examplesExecuted := examplesExecuted + 1.
			[ aSlide run ]
				on: Halt , Error , AssertionFailure
				do: [ :err | 
					error := err.
					stack := self stackTraceString: err of: aSlide ] ].
	self 
		writeError: error 
		andStack: stack
		for: aSlide.
	
	self endExample
]

{ #category : #running }
GtSlidesHDReport >> serializeError: error of: anExample [
	"We got an error from a test, let's serialize it so we can properly debug it later on..."
	| context testCaseMethodContext |
	
	context := error signalerContext.
	testCaseMethodContext := context findContextSuchThat: [ :ctx| 
		ctx receiver == anExample and: [ ctx methodSelector == #performTest ]].
	context := context copyTo: testCaseMethodContext.
	
	[ FuelOutStackDebugAction
		serializeTestFailureContext: context sender 		
		toFileNamed: anExample methodClass name asString,'-', anExample selector, '.fuel' ] 
	on: Error 
	do: [:err| "simply continue..." ]


]

{ #category : #running }
GtSlidesHDReport >> setUp [
	| aFile fileName |
	progressFile nextPutAll: 'running slides: ';
		nextPutAll: title ; crlf; flush.
	
	fileName := title , '-Slides.xml'.
	aFile := File named: fileName .
	aFile delete.
	stream := ZnCharacterWriteStream
			on: (aFile writeStream setToEnd; yourself)
			encoding: 'utf8'.
	
	stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'; lf.
	stream nextPutAll: '<testsuite name="'; nextPutAll: (self encode: title); 
		nextPutAll: '" tests="'; print: examples size; nextPutAll: '">'.
	
	"Now this is ugly. We want to update the time and the number of failures and errors, but still at the same time stream a valid XML. So remember this position and add some whitespace, that we can fill later."
	examplesPosition := stream wrappedStream position - 1.
	stream nextPutAll: (String new: 100 withAll: Character space); lf.
]

{ #category : #private }
GtSlidesHDReport >> stackTraceString: err of: anExample [
	^ String streamContents: [ :str | 
		| context |
		context := err signalerContext.
		[ context isNil 
			or: [  
				(context methodSelector == #primitiveProcessExample:withEvaluationContext: and: [ 
					context arguments first = anExample ])
					or: [ context receiver = anExample and: [ context methodSelector = #debug ] ] ] 
		] whileFalse: [
			str print: context; lf.
			context := context sender ] ] 
]

{ #category : #running }
GtSlidesHDReport >> tearDown [
	stream tab; nextPutAll: '<system-out><![CDATA[]]></system-out>'; lf.
	stream tab; nextPutAll: '<system-err><![CDATA[]]></system-err>'; lf.
	stream nextPutAll: '</testsuite>'.
	
	stream wrappedStream position: examplesPosition.
	stream 
		nextPutAll: ' failures="'; print: examplesFailures; 
		nextPutAll: '" errors="'; print: examplesErrors; 
		nextPutAll: '" time="'; print: executionTime asMilliSeconds / 1000.0; 
		nextPutAll: '">'.
	stream close.
	
	progressFile 
		nextPutAll: 'finished running slides: ';
		nextPutAll: title;
		close
]

{ #category : #private }
GtSlidesHDReport >> writeError: anError andStack: aString for: aTestCase [
	"XML tag is now open"
	anError ifNotNil: [
		(anError isKindOf: AssertionFailure)
			ifTrue: [ self writeFailure: anError stack: aString ]
			ifFalse: [ self writeError: anError stack: aString ] ]
]

{ #category : #private }
GtSlidesHDReport >> writeError: error stack: stack [
	examplesErrors := examplesErrors + 1.
	stream tab; tab; nextPutAll: '<error type="'.
	self writeException: error stack: stack.
	stream nextPutAll: '</error>'; lf
]

{ #category : #private }
GtSlidesHDReport >> writeException: error stack: stack [.

	stream 
		nextPutAll: (self encode: error class name); 
		nextPutAll: '" message="'; nextPutAll: (self encode: (error messageText ifNil: [ error description ])); 
		nextPutAll: '">'; 
		nextPutAll: (self encode: stack).
]

{ #category : #private }
GtSlidesHDReport >> writeFailure: error stack: stack [
	examplesFailures := examplesFailures + 1.
	stream tab; tab; nextPutAll: '<failure type="'.
	self writeException: error stack: stack.  
	stream	nextPutAll: '</failure>'; lf
]
