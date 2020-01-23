Class {
	#name : #GtSlideElement,
	#superclass : #BlAsyncElement,
	#instVars : [
		'slide',
		'slideElement'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #initialization }
GtSlideElement >> defaultPreviewStrategy [
	^ BlAsyncPreviewStrategy delayedStencil: BrGlamorousAsyncElementProgressPreviewStencil new
]

{ #category : #drawing }
GtSlideElement >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.
	"If the slide show was removed from a scene graph before all the slides were generated, 
	and then added back in to a graph, we may need to generate our slide."
	slideElement ifNil: [ self queueAsyncUpdate ].
]

{ #category : #testing }
GtSlideElement >> needsUpdate [
	"Answer a boolean indicating whether the receiver needs to be updated (via an asynchronous task).
	In GtSlideShow only the current slide is attached to the scene graph - the receiver needs to be updated if its slide show is attached to the scene graph."

	"We dont need to update if the slide element has already been generated"
	slideElement ifNotNil: [ ^false ].

	"We don't need to update if there has been an exception, 
	or our slide show isn't attached to a scene graph"
	(asyncException isNil and: [ self slideShowIsAttachedToSceneGraph ])
		ifFalse: [ ^false ].

	^true
]

{ #category : #'async processing' }
GtSlideElement >> queueAsyncUpdate [
	"Queue a task to update the receiver's state.
	Since slides generate their cached element and preview element together defer to the slide"

	self needsUpdate ifFalse: [ ^self ].
	self slide queueAsyncUpdate.
]

{ #category : #'async processing' }
GtSlideElement >> queueEntry [
	"GtSlideElement is unusual in that it is the slide that is responsible for queueing tasks"

	^self shouldNotImplement 
]

{ #category : #accessing }
GtSlideElement >> slide [
	^ slide
]

{ #category : #accessing }
GtSlideElement >> slide: anObject [
	slide := anObject
]

{ #category : #accessing }
GtSlideElement >> slideElement [
	^ slideElement
]

{ #category : #accessing }
GtSlideElement >> slideElement: aBlElement [
	"Set the receiver's slide element.
	Must be called from the UI process"

	slideElement := aBlElement.
	self
		removeChildren;
		addChild: slideElement.

]

{ #category : #testing }
GtSlideElement >> slideShowIsAttachedToSceneGraph [
	"Answer a boolean indicating whether the receiver's slide show is attached to a scene graph.
	The receiver will only be attached to a scene graph while it is the current slide."

	^self slide slideShow slidesContainer isAttachedToSceneGraph
]
