Class {
	#name : #GtElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'elementBlock'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtElementSlide >> create [
	^ elementBlock value margin: (BlInsets all: 50)
]

{ #category : #accessing }
GtElementSlide >> element: aBlock [
	elementBlock := aBlock
]

{ #category : #accessing }
GtElementSlide >> stencil: aBlock [
	elementBlock := aBlock
]
