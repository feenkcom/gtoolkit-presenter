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
		'isSlideSelected',
		'futureConfiguration'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtLiveSlide >> asCachedElement [
	"Answer the receiver's cached element.
	Must be called from the UI process."

	^ cachedElement
]

{ #category : #converting }
GtLiveSlide >> asElement [
	| anElement|
	
	anElement := super asElement.
	
	self shouldPerformAction ifTrue: [
		(self shouldPerformActionEveryTime)
			ifTrue: [
				anElement
					when: BlElementAddedToSceneGraphEvent
					do: [:anEvent |
						anEvent consumed: true.
						self performActionOn: anElement]]
			ifFalse: [
				anElement
					when: BlElementAddedToSceneGraphEvent
					doOnce: [:anEvent |
						anEvent consumed: true.
						self performActionOn: anElement] ] ].
	
	^ anElement
]

{ #category : #converting }
GtLiveSlide >> asPreviewElement [
	"Answer the receiver's preview element.
	Must be called from the UI process."

	^ previewElement
]

{ #category : #converting }
GtLiveSlide >> asScalableSlide [
	^ GtProtoLiveSlide new element
		element: [ (self asElement size: 1200 @ 900) asScalableElement ]
]

{ #category : #converting }
GtLiveSlide >> asScalableSlideWithBorder [
	^ GtProtoLiveSlide new element
		element: [ (self asElement
				size: 1200 @ 900;
				addAptitude: BrGlamorousButtonExteriorAptitude new + BrShadowAptitude new beLarge;
				yourself) asScalableElement ]
]

{ #category : #accessing }
GtLiveSlide >> cachedElement [
	^ cachedElement
]

{ #category : #accessing }
GtLiveSlide >> cachedElement: anObject [
	cachedElement := anObject
]

{ #category : #initialization }
GtLiveSlide >> defaultFutureConfiguration [
	^ AsyncFutureExecutionConfiguration new customGroup: #Slide
]

{ #category : #accessing }
GtLiveSlide >> futureConfiguration [
	<return: #AsyncFutureExecutionConfiguration>
	^ futureConfiguration ifNil: [ 
		futureConfiguration := self defaultFutureConfiguration ]
]

{ #category : #accessing }
GtLiveSlide >> futureConfiguration: aAsyncFutureExecutionConfiguration [
	futureConfiguration := aAsyncFutureExecutionConfiguration
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

{ #category : #view }
GtLiveSlide >> gtSlideFor: aView [
	<gtView>
	^ aView forward
		title: 'Slide';
		priority: 6;
		object: [ self asScalableSlide asElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #initialization }
GtLiveSlide >> initialize [
	super initialize.

	shouldPerformActionEveryTime := true.

	cachedElement := GtSlideWidget new
		matchParent;
		slide: self;
		yourself.

	previewElement := BrAsyncWidget new
		strategy: BrAsyncElementFutureNeverUpdateStrategy new; "I will be updated by the cached element"
		constraintsDo: [ :c | c vertical exact: 100. c horizontal exact: 150 ];
		background: Color white;
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

	| aSliceCommand aPromise |
	cachedElement needsUpdate ifFalse: [ ^ self ].

	aSliceCommand := GtSlideCommand new slide: self.
	aPromise := [ aSliceCommand execute ] asAsyncFuture await: self futureConfiguration.
	aSpace enqueueTask: (BlPromiseTask new promise: aPromise).
]

{ #category : #accessing }
GtLiveSlide >> run [
	^ GtSlideRunner new
		slide: self;
		run.
]

{ #category : #accessing }
GtLiveSlide >> shouldPerformAction [
	^ onAddedToSceneGraphAction notNil
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
