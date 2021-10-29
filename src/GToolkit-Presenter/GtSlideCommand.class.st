Class {
	#name : #GtSlideCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'slide'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlideCommand >> entryIdentifier [

	^slide
]

{ #category : #accessing }
GtSlideCommand >> entryPriority [
	"Answer the task priority of the receiver.
	This is the distance away from the visible portion of the screen.  To accurately fit in with other windows we should really determine the screen size and use that as the multiplier, however it probably isn't worth the effort."

	| slidePriority previewPriority element rootBounds elementBounds |

	self slideShow currentSlideIndex ifNil: [ ^1000 ].
	slidePriority := (self slideIndex - self slideShow currentSlideIndex) abs * 1000.

	element := slide previewElement.
	element isAttachedToSceneGraph ifFalse: [ ^slidePriority ].

	"Determine the of the element and its space (in the parent's coordinate system).
	It may be that the element only takes up part of the space, so this is an approximation.
	ToDo: Be able to set the parent element which should be used to calculate the distance"
	rootBounds := self slideShow dropdown boundsInSpace.
	elementBounds := element boundsInSpace.

	"If the element is visible, load at high priority"
	previewPriority := (rootBounds containsRect: elementBounds) ifTrue: 
		[ 1 ]
	ifFalse: [ 
		"Otherwise, priority is proportional to distance from viewable area"
		rootBounds center distanceTo: elementBounds center ].
	^slidePriority min: previewPriority

]

{ #category : #evaluating }
GtSlideCommand >> execute [ 
	"Generate the receiver's slide's bloc elements"

	slide needsUpdate ifTrue:
		[ slide generateElements ]
]

{ #category : #testing }
GtSlideCommand >> includesSingleCommand [

	^true
]

{ #category : #accessing }
GtSlideCommand >> name [ 

	^name
		ifNotNil: [ super name ]
		ifNil: [ slide name, ' ', self slideIndex asString ]
]

{ #category : #accessing }
GtSlideCommand >> slide [
	^ slide
]

{ #category : #accessing }
GtSlideCommand >> slide: anObject [
	slide := anObject
]

{ #category : #accessing }
GtSlideCommand >> slideIndex [ 

	^slide slideIndex
]

{ #category : #accessing }
GtSlideCommand >> slideShow [ 
	"Answer the slide show the receiver's slide is a member of"

	^slide slideShow
]
