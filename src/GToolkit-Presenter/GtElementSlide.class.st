Class {
	#name : 'GtElementSlide',
	#superclass : 'GtSlide',
	#instVars : [
		'elementBlock'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtElementSlide >> create [
	^ BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		addChild: elementBlock value
]

{ #category : 'accessing' }
GtElementSlide >> element: aBlock [
	elementBlock := aBlock
]

{ #category : 'accessing' }
GtElementSlide >> stencil: aBlock [
	elementBlock := aBlock
]
