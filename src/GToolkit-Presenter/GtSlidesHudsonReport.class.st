Class {
	#name : #GtSlidesHudsonReport,
	#superclass : #GtExamplesTestingHudsonReport,
	#category : #'GToolkit-Presenter-Runtime'
}

{ #category : #running }
GtSlidesHudsonReport class >> runPackage: aString [
	^ self new 
		initializeWithTestCases: (self packageOrganizer packageNamed: aString) gtSlideBuildersAllContained;
		reportName: aString;
		run
]

{ #category : #running }
GtSlidesHudsonReport class >> runPackages: aCollectionOfStrings [
	^ aCollectionOfStrings collect: [ :each | 
		self runPackage: each ]
]

{ #category : #'accessing - test case' }
GtSlidesHudsonReport >> containerNameFor: aSlide [
	| definingClass |
	definingClass := aSlide definingMethod.

	^ (definingClass category copyReplaceAll: '-' with: '.'),
		'.',
		definingClass name
		
]

{ #category : #'accessing - test case' }
GtSlidesHudsonReport >> loggingNameFor: anExample [
	| definingMethod |
	definingMethod := anExample definingMethod.
	^ definingMethod methodClass name, '>>', definingMethod selector
]

{ #category : #'accessing - test case' }
GtSlidesHudsonReport >> nameFor: aSlide [
	^ aSlide definingMethod selector
]

{ #category : #private }
GtSlidesHudsonReport >> progressFileName [
	^ 'progress-slides.log'
]

{ #category : #accessing }
GtSlidesHudsonReport >> resultsFileName [
	^ self reportName , '-Slides.xml'
]

{ #category : #running }
GtSlidesHudsonReport >> runSlideBuilder: aSlideBuilder [
	| errorDetails stack runStatus |
	
	errorDetails := nil.
	self
		beginTestCase: aSlideBuilder
		runBlock: [
			[ aSlideBuilder build run ]
				on: self signalableExceptions
				do: [ :err | 
					errorDetails := Dictionary new.
					errorDetails at: #errorClass put: err class.
					errorDetails
						at: #errorMessage
						put: (err messageText ifNil: [ err description ]).
					stack := self stackTraceString: err of: aSlideBuilder ] ].

	errorDetails
		ifNil: [ runStatus := #success ]
		ifNotNil: [
		((errorDetails at: #errorClass) includesBehavior: AssertionFailure)
			ifTrue: [
				runStatus := #failure.
				self writeFailure: errorDetails stack: stack ]
			ifFalse: [
				runStatus := #error.
				self writeError: errorDetails stack: stack ] ].
	
	self endTestCase.
	
	GtExamplesReportRunExampleSignal new
		example: aSlideBuilder;
		runStatus: runStatus;
		emit.
]

{ #category : #running }
GtSlidesHudsonReport >> runTestCase: anExample [
	^ self runSlideBuilder: anExample
]

{ #category : #private }
GtSlidesHudsonReport >> stackTraceString: err of: aTestCase [
	^ String streamContents: [ :str | 
		| context |
		context := err signalerContext.
		[ context isNil or: [ context receiver == aTestCase and: [ context methodSelector == #run ] ] ] whileFalse: [
			[str print: context; lf.]
				on: Error
				do: [ str nextPutAll: 'PRINTING ERROR'; lf].
			context := context sender ] ] 
]

{ #category : #accessing }
GtSlidesHudsonReport >> testCasesToRun [
	^ self testCases reject: [ :aSlideExample |
		aSlideExample ignoreSlideTest ].
]
