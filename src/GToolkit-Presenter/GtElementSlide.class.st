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
	^ elementBlock value
]

{ #category : #accessing }
GtElementSlide >> element: aBlock [
	elementBlock := aBlock
]

{ #category : #accessing }
GtElementSlide >> stencil: aBlock [
	elementBlock := aBlock
]
