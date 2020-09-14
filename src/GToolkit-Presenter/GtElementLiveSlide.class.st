Class {
	#name : #GtElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtElementLiveSlide >> create [
	^ element value.
]

{ #category : #accessing }
GtElementLiveSlide >> element: anElementBlock [
	element := anElementBlock.
]
