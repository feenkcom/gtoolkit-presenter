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
	^ element margin: (BlInsets all: 50)
]

{ #category : #accessing }
GtElementSlide >> element: anObject [
	element := anObject
]
