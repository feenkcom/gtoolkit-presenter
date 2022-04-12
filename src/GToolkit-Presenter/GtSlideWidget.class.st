Class {
	#name : #GtSlideWidget,
	#superclass : #BrAsyncWidget,
	#instVars : [
		'slide',
		'slideElement'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlideWidget >> defaultStrategy [
	^ BrAsyncElementFutureWhenVisibleStrategy new
]

{ #category : #accessing }
GtSlideWidget >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.

	"If the slide show was removed from a scene graph before all the slides were generated, 
	and then added back in to a graph, we may need to generate our slide."
	slideElement ifNil: [ 
		self needsUpdate ifFalse: [ ^ self ].

		self slide queueAsyncUpdate: self space ]
]

{ #category : #accessing }
GtSlideWidget >> needsUpdate [
	slideElement
		ifNotNil: [ ^ false ].

	self slideShowIsAttachedToSceneGraph
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
GtSlideWidget >> slide [
	^ slide 
]

{ #category : #accessing }
GtSlideWidget >> slide: aSlide [
	slide := aSlide
]

{ #category : #accessing }
GtSlideWidget >> slideElement: anElement [
	slideElement := anElement.

	self stencil: [ anElement ]
]

{ #category : #accessing }
GtSlideWidget >> slideShowIsAttachedToSceneGraph [

	"Answer a boolean indicating whether the receiver's slide show is attached to a scene graph.
	The receiver will only be attached to a scene graph while it is the current slide."

	^ self slide slideShow slidesContainer topMostParent
		  isAttachedToSceneGraph
]
