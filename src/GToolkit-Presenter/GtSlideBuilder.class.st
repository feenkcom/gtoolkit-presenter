Class {
	#name : 'GtSlideBuilder',
	#superclass : 'Object',
	#instVars : [
		'slideSelector',
		'slideShowClass'
	],
	#category : 'GToolkit-Presenter-Runtime'
}

{ #category : 'accessing' }
GtSlideBuilder >> build [
	^ thisContext
		object: slideShowClass new
		perform: slideSelector
		withArguments: {GtEmptySlide new}
		inClass: slideShowClass.
]

{ #category : 'accessing' }
GtSlideBuilder >> definingMethod [
	^ slideShowClass>>slideSelector.
]

{ #category : 'accessing' }
GtSlideBuilder >> gtSlideCodeFor: aView [
	<gtView>
	((slideShowClass isNil) or: [slideSelector isNil])
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Code';
		object: [self definingMethod asRingDefinition];
		view: #gtSourceFor:.
]

{ #category : 'accessing' }
GtSlideBuilder >> ignoreSlideTest [
	^ self definingMethod hasPragmaNamed: #noTest.
]

{ #category : 'accessing' }
GtSlideBuilder >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: slideShowClass name;
		nextPutAll: '>>#';
		nextPutAll: slideSelector;
		nextPutAll: ')'.
]

{ #category : 'accessing' }
GtSlideBuilder >> slideSelector: aSelector [
	slideSelector := aSelector.
]

{ #category : 'accessing' }
GtSlideBuilder >> slideShowClass: aClass [
	slideShowClass := aClass.
]
