Class {
	#name : #GtSlideStencil,
	#superclass : #GtSlide,
	#instVars : [
		'stencil',
		'slide'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSlideStencil >> create [
	"#generateElements should be called"
]

{ #category : #private }
GtSlideStencil >> generateElements [

	self slide
		cachedElement: self asCachedElement;
		previewElement: self asPreviewElement;
		slideShow: slideShow;
		generateElements
]

{ #category : #accessing }
GtSlideStencil >> slide [

	^ slide ifNil: [ slide := stencil value ]
]

{ #category : #accessing }
GtSlideStencil >> stencil [
	^ stencil
]

{ #category : #accessing }
GtSlideStencil >> stencil: anObject [
	stencil := anObject
]
