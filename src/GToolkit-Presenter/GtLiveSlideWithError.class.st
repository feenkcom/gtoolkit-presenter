Class {
	#name : 'GtLiveSlideWithError',
	#superclass : 'GtLiveSlide',
	#instVars : [
		'error'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'accessing' }
GtLiveSlideWithError >> create [
	^ error asDebuggableElement.
]

{ #category : 'accessing' }
GtLiveSlideWithError >> error [
	^ error.
]

{ #category : 'accessing' }
GtLiveSlideWithError >> error: anObject [
	error := anObject.
]
