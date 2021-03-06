Class {
	#name : #GtFilePictureSlide,
	#superclass : #GtSlide,
	#instVars : [
		'fileReference',
		'background',
		'maxScale'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtFilePictureSlide >> background [
	^ background ifNil: [ background := Color white ]
]

{ #category : #accessing }
GtFilePictureSlide >> background: anObject [
	background := anObject
]

{ #category : #'api - instantiation' }
GtFilePictureSlide >> create [
	| form container |
	container := BlElement new 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		background: self background;
		layout: BlLinearLayout new.
	form := PNGReadWriter formFromFileNamed: self fileReference fullName.
	^ container addChild: ((BlElement new 
		size: form extent;
		background: (BlImageBackground new image: form)) asScalableElement maxScale: self maxScale)
]

{ #category : #accessing }
GtFilePictureSlide >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtFilePictureSlide >> fileReference: aStringOrFileReference [
	fileReference := aStringOrFileReference asFileReference 
]

{ #category : #accessing }
GtFilePictureSlide >> initialize [
	super initialize.
	maxScale := 1.
]

{ #category : #accessing }
GtFilePictureSlide >> maxScale [
	^ maxScale
]

{ #category : #accessing }
GtFilePictureSlide >> maxScale: aNumber [
	maxScale := aNumber
]
