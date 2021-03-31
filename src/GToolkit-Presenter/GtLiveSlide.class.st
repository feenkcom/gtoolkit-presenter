"
A live slide is a slide that can be used in live shows and it can be edited live, during the presentation. I am responsible for creating the live slide element and its preview. Those then can be added to a live show. A live slide can take multiple forms, depending on the type of information you want to display in it.
"
Class {
	#name : #GtLiveSlide,
	#superclass : #GtProtoLiveSlide,
	#instVars : [
		'shouldPerformActionEveryTime',
		'onAddedToSceneGraphAction',
		'previewElement',
		'cachedElement',
		'slideIndex',
		'slideShow',
		'isSlideSelected'
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
	[element := self asElement]
		on: Error
		do: [ :anException |
			element := anException asDebuggableElement ].
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
		viewModel: (BrInteractiveModel new
			withHover;
			yourself);
		margin: (BlInsets all: 10);
		yourself.
	self isSlideSelected: false.
	self updatePreviewElementLook
]

{ #category : #accessing }
GtLiveSlide >> isSlideSelected [
	^ isSlideSelected.
]

{ #category : #accessing }
GtLiveSlide >> isSlideSelected: aBoolean [
	isSlideSelected := aBoolean.
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

{ #category : #'private - event handling' }
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
		aShow slideDefinitionChangedFor: self ]
]

{ #category : #'private - event handling' }
GtLiveSlide >> onDefiningMethodRemoved [
	"I am called when the defining method has changed.
	Subclasses may react to the method definition changes.
	I may be called from a non-UI process.".
	
	super onDefiningMethodRemoved.
	self slideShow ifNotNil: [ :aShow | 
		aShow slideDefinitionRemovedFor: self ]
]

{ #category : #'private - event handling' }
GtLiveSlide >> onEveryAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := true.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #'private - event handling' }
GtLiveSlide >> onFirstAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := false.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #'private - event handling' }
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
GtLiveSlide >> run [
	^ GtSlideRunner new
		slide: self;
		run.
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

{ #category : #accessing }
GtLiveSlide >> updatePreviewElementLook [
	isSlideSelected
		ifTrue: [
			previewElement
				aptitude: (BrShadowAptitude new color: (Color r: 0.27 g: 0.67 b: 0.99 alpha: 0.7)) + (BrInteractiveCommonAptitude new 
					default: [ :aWidget |
						aWidget
							border: (BlBorder paint: Color transparent)];
					hovered: [ :aWidget |
						aWidget 
							border: (BlBorder paint: (Color r: 0.27 g: 0.67 b: 0.99) width: 1)])]
		ifFalse: [
			previewElement
				aptitude: (BrShadowAptitude new) + (BrInteractiveCommonAptitude new 
					default: [ :aWidget |
						aWidget
							border: (BlBorder paint: Color transparent)];
					hovered: [ :aWidget |
						aWidget 
							border: (BlBorder paint: (Color r: 0.27 g: 0.67 b: 0.99) width: 1)])].
]
