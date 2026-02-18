Class {
	#name : #GtSlideBuilder,
	#superclass : #Object,
	#instVars : [
		'slideSelector',
		'slideShowClass'
	],
	#category : #'GToolkit-Presenter-Runtime'
}

{ #category : #accessing }
GtSlideBuilder >> build [
	^ thisContext
		object: slideShowClass new
		perform: slideSelector
		withArguments: {GtEmptySlide new}
		inClass: slideShowClass.
]

{ #category : #accessing }
GtSlideBuilder >> definingMethod [
	^ slideShowClass>>slideSelector.
]

{ #category : #accessing }
GtSlideBuilder >> gtSlideCodeFor: aView [
	<gtView>
	((slideShowClass isNil) or: [slideSelector isNil])
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Code';
		object: [self definingMethod asRingDefinition];
		view: #gtSourceFor:.
]

{ #category : #accessing }
GtSlideBuilder >> ignoreSlideTest [
	^ self definingMethod hasPragmaNamed: #noTest.
]

{ #category : #accessing }
GtSlideBuilder >> printClassLabelOn: aStream [
	aStream print: slideShowClass
]

{ #category : #accessing }
GtSlideBuilder >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: slideShowClass name;
		nextPutAll: '>>#';
		nextPutAll: slideSelector;
		nextPutAll: ')'.
]

{ #category : #executing }
GtSlideBuilder >> runUnmanaged [

	"The ideal case would be to updade the example runner to use runManaged"
	^ CurrentExecutionEnvironment runUnmanagedExampleEvaluator: self
]

{ #category : #accessing }
GtSlideBuilder >> selector [
	^ slideSelector
]

{ #category : #accessing }
GtSlideBuilder >> shouldLogWithEpicea [
	^ self definingMethod isNotNil and: [ self definingMethod hasPragmaNamed: #shouldLogWithEpicea ]
]

{ #category : #accessing }
GtSlideBuilder >> slideSelector: aSelector [
	slideSelector := aSelector.
]

{ #category : #accessing }
GtSlideBuilder >> slideShowClass: aClass [
	slideShowClass := aClass.
]

{ #category : #executing }
GtSlideBuilder >> value [
	^ self build run
]
