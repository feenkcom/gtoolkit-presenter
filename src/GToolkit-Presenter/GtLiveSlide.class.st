Class {
	#name : #GtLiveSlide,
	#superclass : #GtProtoLiveSlide,
	#instVars : [
		'shouldPerformActionEveryTime',
		'onAddedToSceneGraphAction',
		'previewElement',
		'cachedElement',
		'slideIndex',
		'slideShow'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtLiveSlide >> asCachedElement [
	"Answer the receiver's cached element.
	Must be called from the UI process."

	^ cachedElement
]

{ #category : #accessing }
GtLiveSlide >> asPreviewElement [
	"Answer the receiver's preview element.
	Must be called from the UI process."

	^ previewElement
]

{ #category : #accessing }
GtLiveSlide >> cachedElement [
	^ cachedElement
]

{ #category : #accessing }
GtLiveSlide >> cachedElement: anObject [
	cachedElement := anObject
]

{ #category : #accessing }
GtLiveSlide >> generateElements [
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

{ #category : #accessing }
GtLiveSlide >> initialize [

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
GtLiveSlide >> name [
	^ (self class name gtRemovePrefix: 'Gt').
]

{ #category : #accessing }
GtLiveSlide >> needsUpdate [ 

	^cachedElement needsUpdate
]

{ #category : #accessing }
GtLiveSlide >> nextStepWith: aSlider [
	aSlider showSlideAfter: self
]

{ #category : #accessing }
GtLiveSlide >> onAddedToSceneGraphAction [
	^ onAddedToSceneGraphAction ifNil: [^[:anElement | ]].
]

{ #category : #'private - event handling' }
GtLiveSlide >> onDefiningMethodChange [
	"I am called when the defining method has changed.
	Subclasses may react to the method definition changes.
	I may be called from a non-UI process.".
	super onDefiningMethodChange.
	
	self slideShow ifNotNil: [ :aShow | 
		aShow slideDefinitionChanged: self ]
]

{ #category : #accessing }
GtLiveSlide >> onEveryAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := true.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #accessing }
GtLiveSlide >> onFirstAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := false.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #accessing }
GtLiveSlide >> performActionOn: element [
	self onAddedToSceneGraphAction cull: element.
]

{ #category : #accessing }
GtLiveSlide >> previewElement [
	previewElement hasChildren ifFalse: [ previewElement schedulePreview ].
	^ previewElement
]

{ #category : #accessing }
GtLiveSlide >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #accessing }
GtLiveSlide >> previousStepWith: aSlider [
	aSlider showSlideBefore: self
]

{ #category : #accessing }
GtLiveSlide >> queueAsyncUpdate: aSpace [
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

{ #category : #accessing }
GtLiveSlide >> shouldPerformActionEveryTime [
	^ shouldPerformActionEveryTime.
]

{ #category : #accessing }
GtLiveSlide >> slideIndex [
	^ slideIndex
]

{ #category : #accessing }
GtLiveSlide >> slideIndex: anObject [
	slideIndex := anObject
]

{ #category : #accessing }
GtLiveSlide >> slideShow [
	^ slideShow
]

{ #category : #accessing }
GtLiveSlide >> slideShow: anObject [
	slideShow := anObject
]
