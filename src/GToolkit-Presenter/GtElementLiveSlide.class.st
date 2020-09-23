Class {
	#name : #GtElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtElementLiveSlide >> create [
	^ element value.
]

{ #category : #accessing }
GtElementLiveSlide >> element: anElementBlock [
	element := anElementBlock.
]
