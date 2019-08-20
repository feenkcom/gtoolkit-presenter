Class {
	#name : #GtElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtElementSlide >> create [
	^ element
]

{ #category : #accessing }
GtElementSlide >> element: anObject [
	element := anObject
]
