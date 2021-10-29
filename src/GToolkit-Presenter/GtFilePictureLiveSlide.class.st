"
I am a live slide that gets a picture reference and displays it. Optionally a scale and a background can be provided.

{{gtMethod:GtExampleLiveShow>>#filePictureExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtFilePictureLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'fileReference',
		'background',
		'maxScale'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #accessing }
GtFilePictureLiveSlide >> background [
	^ background ifNil: [ background := Color white ]
]

{ #category : #accessing }
GtFilePictureLiveSlide >> background: anObject [
	background := anObject
]

{ #category : #'api - instantiation' }
GtFilePictureLiveSlide >> create [
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
GtFilePictureLiveSlide >> fileReference [
	^ fileReference.
]

{ #category : #accessing }
GtFilePictureLiveSlide >> fileReference: aStringOrFileReference [
	fileReference := aStringOrFileReference asFileReference 
]

{ #category : #initialization }
GtFilePictureLiveSlide >> initialize [
	super initialize.
	maxScale := 1.
]

{ #category : #accessing }
GtFilePictureLiveSlide >> maxScale [
	^ maxScale.
]

{ #category : #accessing }
GtFilePictureLiveSlide >> maxScale: aNumber [
	maxScale := aNumber
]
