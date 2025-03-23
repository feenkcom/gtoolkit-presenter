Class {
	#name : #GtSlideShow,
	#superclass : #BrStencil,
	#instVars : [
		'slides',
		'currentSlide',
		'slidesContainer',
		'slideElement',
		'nextArrow',
		'previousArrow',
		'arrowsAreVisible',
		'title',
		'background',
		'previewsContainer',
		'dropdown'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlideShow >> addSlide: aSlide [
	slides add: aSlide.

]

{ #category : #accessing }
GtSlideShow >> background [
	^ background
]

{ #category : #accessing }
GtSlideShow >> background: anObject [
	background := anObject
]

{ #category : #'api - instantiation' }
GtSlideShow >> create [
	| previousElement nextElement container |

	container := GtSlideShowElement new slideShow: self.
	container 
		background: self background;
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		layout: BlLinearLayout vertical.

	slideElement := BrHorizontalPane new matchParent.

	previousArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft.
	previousElement := BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e | self previousStep ];
		addChild: previousArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ previousArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).

	nextArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight.
	nextElement := BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e | self nextStep ];
		addChild: nextArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ nextArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).

	slidesContainer := BrHorizontalPane new
		matchParent;
		addChildren: { previousElement . slideElement . nextElement }.

	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: self slides first.

	container addChild: slidesContainer.
	container addChild: self slidesDropdown.

	container addShortcut: (BlShortcutWithAction new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowRight build;
		action: [ self nextStep ]).
	container addShortcut: (BlShortcutWithAction new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowLeft build;
		action: [ self previousStep ]).
	^ container
]

{ #category : #accessing }
GtSlideShow >> currentSlideIndex [
	"Answer the index of the currently displayed slide.
	nil if the slides aren't yet displayed"

	^currentSlide
		ifNil: [ nil ] 
		ifNotNil: [ currentSlide slideIndex ]
]

{ #category : #accessing }
GtSlideShow >> dropdown [ 

	^dropdown
]

{ #category : #'api - tasks' }
GtSlideShow >> enqueueTask: aTask [

	slidesContainer enqueueTask: aTask
]

{ #category : #accessing }
GtSlideShow >> exportSlides [
	self slides
		withIndexDo: [ :eachSlide :anIndex |	
			| eachCachedElement eachSlideElement |		

			eachCachedElement := eachSlide asCachedElement.
			eachSlideElement := eachCachedElement slideElement
				ifNil: [ eachCachedElement ].
			eachSlideElement asSpartaForm
				writePNGFileNamed: self title, ' - ', anIndex asString, '.png' ]
]

{ #category : #accessing }
GtSlideShow >> gtSlidesFor: aView [
	<gtView>
	^ aView list
		title: 'Slides';
		items: [ self slides ];
		itemText: #name
]

{ #category : #'api - instantiation' }
GtSlideShow >> hasNextSlide [
	^ self slides last ~= currentSlide
]

{ #category : #'api - instantiation' }
GtSlideShow >> hasPreviousSlide [
	^ self slides first ~= currentSlide
]

{ #category : #initialization }
GtSlideShow >> initialize [
	super initialize.
	slides := OrderedCollection new.
	arrowsAreVisible := false.
	background := Color white
]

{ #category : #accessing }
GtSlideShow >> makeArrowsVisible [
	arrowsAreVisible := true
]

{ #category : #'api - instantiation' }
GtSlideShow >> nextStep [
	self hasNextSlide ifFalse: [ ^ self ].
	currentSlide nextStepWith: self
]

{ #category : #'hooks - children' }
GtSlideShow >> onAddedToSceneGraph: aSpace [
	"If my element has been added to a scene graph ensure the slides have been generated"

	self slides withIndexDo: [ :eachSlide :eachIndex |
		BlFrameTelemetry
			time: [ 'Queue slide {1} to async update' format: { eachIndex } ]
			during: [ eachSlide queueAsyncUpdate: aSpace ] ]
]

{ #category : #'api - instantiation' }
GtSlideShow >> openInSpace [ 
	| space |
	space := BlSpace new.
	space extent: 800@500.
	space title: self title.
	space root addChild: self asElement.
	space root addShortcut: (BlShortcutWithAction new 
		repeatable: false;
		combination: (BlSingleKeyCombination new key: BlKeyboardKey pageDown);
			action: [ self nextStep ]).
	space root addShortcut: (BlShortcutWithAction new 
		repeatable: false;
		combination: (BlSingleKeyCombination new key: BlKeyboardKey pageUp);
			action: [ self previousStep ]).
	space show
]

{ #category : #accessing }
GtSlideShow >> previewsContainer [
	^ previewsContainer
]

{ #category : #'api - instantiation' }
GtSlideShow >> previousStep [
	self hasPreviousSlide ifFalse: [ ^ self ].
	currentSlide previousStepWith: self
]

{ #category : #'api - instantiation' }
GtSlideShow >> showSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide
		ifTrue: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	currentSlide := aSlide.
	self updateArrows
]

{ #category : #'api - instantiation' }
GtSlideShow >> showSlideAfter: aSlide [

	self showSlide: (self slides at: currentSlide slideIndex + 1)
]

{ #category : #'api - instantiation' }
GtSlideShow >> showSlideBefore: aSlide [
	self showSlide: (self slides at: currentSlide slideIndex - 1)
]

{ #category : #accessing }
GtSlideShow >> slides [
	^ slides
]

{ #category : #accessing }
GtSlideShow >> slides: anObject [
	slides := anObject
]

{ #category : #accessing }
GtSlideShow >> slidesContainer [

	^slidesContainer
]

{ #category : #'api - instantiation' }
GtSlideShow >> slidesDropdown [
	| container aToolbar |
	container := BlElement new.
	container
		layout: BlFlowLayout new;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ];
		padding: (BlInsets all: 10).
	self slides
		do: [ :each | 
			container
				addChild: (each asPreviewElement when: BlClickEvent do: [ :e | self showSlide: each ]) ].
	previewsContainer := container.
	^ dropdown := BrButton new
			margin: (BlInsets all: 10);
			icon: BrGlamorousIcons hamburger asElement;
			label: 'Slides';
			aptitude: BrGlamorousButtonWithIconAptitude
					+ (BrGlamorousWithExplicitDropdownAptitude
							handle: [ BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
											- BrGlamorousButtonExteriorAptitude;
									icon: BrGlamorousIcons hamburger asElement;
									yourself ]
							content: [ | el |
								aToolbar := BrToolbar new.
								aToolbar aptitude: BrGlamorousToolbarAptitude.
								aToolbar
									addItem: (BrToggle new
											beSmallSize;
											aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
											icon: BrGlamorousIcons edit asElement;
											when: BrToggleActivatedEvent
												do: [ :anEvent | 
													arrowsAreVisible := true.
													self updateArrows ];
											when: BrToggleDeactivatedEvent
												do: [ :anEvent | 
													arrowsAreVisible := false.
													self updateArrows ]);
									addItem: (BrButton new
											beSmallSize;
											aptitude: BrGlamorousButtonWithIconAptitude;
											icon: BrGlamorousIcons save asElement;
											action: [ self exportSlides ]).
								el := BlElement new
										size: 700 @ 520;
										layout: BlLinearLayout vertical;
										addChild: container asScrollableElement;
										addChild: aToolbar.
								el ]);
			constraintsDo: [ :c | c linear horizontal alignRight ];
			padding: (BlInsets all: 10);
			yourself
]

{ #category : #accessing }
GtSlideShow >> title [
	^ title ifNil: [ 'Gt Slide Show' ]
]

{ #category : #accessing }
GtSlideShow >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GtSlideShow >> updateArrows [
	(arrowsAreVisible and: [ self hasPreviousSlide ])
		ifTrue: [ previousArrow visibility: BlVisibility visible ]
		ifFalse: [ previousArrow visibility: BlVisibility hidden ].
	(arrowsAreVisible and: [ self hasNextSlide ])
		ifTrue: [ nextArrow visibility: BlVisibility visible ]
		ifFalse: [ nextArrow visibility: BlVisibility hidden ]
]

{ #category : #'api - instantiation' }
GtSlideShow >> updateSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide ifFalse: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	self updateArrows
]
