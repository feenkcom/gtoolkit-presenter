Class {
	#name : #GtSlide,
	#superclass : #BrStencil,
	#instVars : [
		'slideShow',
		'slideIndex',
		'cachedElement',
		'previewElement',
		'onAddedToSceneGraphAction',
		'shouldPerformActionEveryTime'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlide >> asCachedElement [
	"Answer the receiver's cached element.
	Must be called from the UI process."

	^ cachedElement
]

{ #category : #accessing }
GtSlide >> asPreviewElement [
	"Answer the receiver's preview element.
	Must be called from the UI process."

	^ previewElement
]

{ #category : #accessing }
GtSlide >> cachedElement [
	^ cachedElement
]

{ #category : #accessing }
GtSlide >> cachedElement: anObject [
	cachedElement := anObject
]

{ #category : #private }
GtSlide >> generateElements [
	"Generate the receiver's element and preview"

	| element formElement |

	"5 seconds wait."
	element := self asElement.
	formElement := element asSpartaForm asElement asPannableElement.
	slideShow enqueueTask: (BlTaskAction new action: [
		cachedElement
			slideElement: element.
		(self shouldPerformActionEveryTime)
			ifTrue: [
				cachedElement
					when: BlElementAddedToSceneGraphEvent
					do: [:anEvent |
						anEvent consumed: true.
						self performActionOn: element]]
			ifFalse: [
				cachedElement
					when: BlElementAddedToSceneGraphEvent
					doOnce: [:anEvent |
						anEvent consumed: true.
						self performActionOn: element]].
		slideShow updateSlide: self.
		previewElement
			removeChildren;
			addChild: formElement ]).
]

{ #category : #initialization }
GtSlide >> initialize [

	super initialize.
	shouldPerformActionEveryTime := true.
	cachedElement := GtSlideElement new
		withGlamorousPreview;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		slide: self;
		yourself.
	previewElement := BlLazyElement new
		withGlamorousPreview;
		neverUpdate; "I will be updated by the cached element"
		constraintsDo: [ :c | c vertical exact: 100. c horizontal exact: 150 ];
		background: Color white;
		look: BrShadowLook new;
		margin: (BlInsets all: 10);
		yourself.

]

{ #category : #accessing }
GtSlide >> name [
	^ (self class name gtRemovePrefix: 'Gt') gtRemoveSuffix: 'Slide'
]

{ #category : #testing }
GtSlide >> needsUpdate [ 

	^cachedElement needsUpdate
]

{ #category : #accessing }
GtSlide >> nextStepWith: aSlider [
	aSlider showSlideAfter: self
]

{ #category : #private }
GtSlide >> onAddedToSceneGraphAction [
	^ onAddedToSceneGraphAction ifNil: [^[:anElement | ]].
]

{ #category : #accessing }
GtSlide >> onEveryAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := true.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #accessing }
GtSlide >> onFirstAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := false.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #private }
GtSlide >> performActionOn: element [
	self onAddedToSceneGraphAction cull: element.
]

{ #category : #accessing }
GtSlide >> previewElement [
	previewElement hasChildren ifFalse: [ previewElement schedulePreview ].
	^ previewElement
]

{ #category : #accessing }
GtSlide >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #accessing }
GtSlide >> previousStepWith: aSlider [
	aSlider showSlideBefore: self
]

{ #category : #private }
GtSlide >> queueAsyncUpdate: aSpace [
	"Submit a task to cache the receiver's elements"
	| aCommand aTelemetry |
	
	aTelemetry := aSpace
		ifNil: [ BlNullTelemetry uniqueInstance ]
		ifNotNil: [ aSpace telemetry ].
	
	cachedElement needsUpdate
		ifFalse: [ ^ self ].

	aCommand := GtSlideCommand new slide: self.

	BlUseAsyncFeatures
		ifEnabledDo: [
			aTelemetry
				timeSync: [ 'Schedule slide {1} update command in UI pool' format: { self class name } ]
				during: [ aCommand asBlTktLoggingCommand scheduleInUIPool ]  ] 
		otherwise: [
			aTelemetry
				timeSync: [ 'Execute slide {1} update command directly' format: { self class name } ]
				during: [ aCommand execute ] ]
]

{ #category : #private }
GtSlide >> shouldPerformActionEveryTime [
	^ shouldPerformActionEveryTime.
]

{ #category : #accessing }
GtSlide >> slideIndex [
	^ slideIndex
]

{ #category : #accessing }
GtSlide >> slideIndex: anObject [
	slideIndex := anObject
]

{ #category : #accessing }
GtSlide >> slideShow [
	^ slideShow
]

{ #category : #accessing }
GtSlide >> slideShow: anObject [
	slideShow := anObject
]
