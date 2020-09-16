Class {
	#name : #GtLiveShow,
	#superclass : #BrStencil,
	#instVars : [
		'dropdown',
		'previewsContainer',
		'background',
		'title',
		'arrowsAreVisible',
		'previousArrow',
		'nextArrow',
		'slideElement',
		'slidesContainer',
		'currentSlide',
		'slides',
		'coderElement',
		'coderElementState'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtLiveShow >> background [
	^ background.
]

{ #category : #accessing }
GtLiveShow >> background: anObject [
	background := anObject.
]

{ #category : #accessing }
GtLiveShow >> changeCoderElementState [
	coderElementState
		ifTrue: [
			coderElement visibility: BlVisibility gone.
			coderElementState := false]
		ifFalse: [
			coderElement visibility: BlVisibility visible.
			coderElementState := true ].
]

{ #category : #accessing }
GtLiveShow >> coderElement [
	coderElementState := false.
	^ coderElement := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent];
		look: BrShadowLook;
		background: self background;
		margin: (BlInsets top: 5 right: 30 bottom: 5 left: 30);
		addChild: ((GtMethodCoder new 
			forMethod: self slides first definingMethod;
			expanded: true;
			asElement)
				vMatchParent;
				hMatchParent;
				margin: (BlInsets top: 5 right: 10 bottom: 5 left: 10)).
]

{ #category : #accessing }
GtLiveShow >> collectSlides [
	| theSlides |
	theSlides := GtSlidesCollector new
		object: self;
		from: self class;
		to: self class;
		collect.
	self slides: theSlides.
]

{ #category : #accessing }
GtLiveShow >> create [
	| previousElement nextElement container |

	self collectSlides.
	container := GtSlideShowElement new slideShow: self.
	container 
		background: self background;
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		layout: BlLinearLayout vertical.
	slideElement := BlElement new
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	previousElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self previousStep ];
		layout: BlLinearLayout new alignCenter.
	previousArrow := BrButton new
		size: 12 @ 24;
		when: BlClickEvent do: [:e | self previousStep ];
		geometry:
			(BlPolygon
				vertices:
					{(12 @ 0).
					(0 @ 12).
					(12 @ 24)});
		look: (BrInteractiveCommonLook new
				default: [ :aWidget | aWidget background: (BrGlamorousColors defaultButtonBorderColor) ];
				hovered: [ :aWidget | aWidget background: (BrGlamorousColors hoveredButtonBorderColor) ]);
		background: BrGlamorousColors defaultButtonBorderColor.
	previousElement addChild: previousArrow.
	nextElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self nextStep ];
		layout: BlLinearLayout new alignCenter.
	nextArrow := BrButton new
		size: 12 @ 24;
		when: BlClickEvent do: [:e | self nextStep ];
		geometry:
			(BlPolygon
				vertices:
					{(0 @ 0).
					(12 @ 12).
					(0 @ 24)});
		look: (BrInteractiveCommonLook new
				default: [ :aWidget | aWidget background: (BrGlamorousColors defaultButtonBorderColor) ];
				hovered: [ :aWidget | aWidget background: (BrGlamorousColors hoveredButtonBorderColor) ]);
		background: BrGlamorousColors defaultButtonBorderColor.
	nextElement addChild: nextArrow.
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: self slides first.
	container addChild: slidesContainer.
	container addChild: self coderElement.
	container addChild: self slidesDropdown.
	coderElement visibility: BlVisibility gone.
	
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowRight build;
		action: [ self nextStep ]).
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowLeft build;
		action: [ self previousStep ]).
	^ container
]

{ #category : #accessing }
GtLiveShow >> createNewEmptySlide [
	| priority |
	priority := ((self slides at: self currentSlideIndex) priority + 2) asString.
	
	self class
		compile: ('newEmptySlideFor: aSlide
	<gtSlide>
	"Rename this method to be able to add others in the slideshow"
	^ aSlide empty
		priority: ', priority, '.')
		classified: ''.
		
	self collectSlides.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
]

{ #category : #accessing }
GtLiveShow >> currentSlideIndex [
	"Answer the index of the currently displayed slide.
	nil if the slides aren't yet displayed"

	^currentSlide
		ifNil: [ nil ] 
		ifNotNil: [ currentSlide slideIndex ]
]

{ #category : #accessing }
GtLiveShow >> enqueueTask: aTask [

	slidesContainer enqueueTask: aTask
]

{ #category : #accessing }
GtLiveShow >> exportSlides [
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
GtLiveShow >> gtSlidesFor: aView [
	<gtView>
	^ aView list
		title: 'Slides';
		items: [ self slides ];
		itemText: #name
]

{ #category : #accessing }
GtLiveShow >> hasNextSlide [
	^ self slides last ~= currentSlide
]

{ #category : #accessing }
GtLiveShow >> hasPreviousSlide [
	^ self slides first ~= currentSlide
]

{ #category : #accessing }
GtLiveShow >> initialize [
	super initialize.
	slides := OrderedCollection new.
	arrowsAreVisible := false.
	background := Color white
]

{ #category : #accessing }
GtLiveShow >> makeArrowsVisible [
	arrowsAreVisible := true
]

{ #category : #accessing }
GtLiveShow >> nextStep [
	self hasNextSlide ifFalse: [ ^ self ].
	currentSlide nextStepWith: self.
	self updateCoderElement.
]

{ #category : #accessing }
GtLiveShow >> onAddedToSceneGraph: aSpace [
	"If my element has been added to a scene graph ensure the slides have been generated"

	self slides withIndexDo: [ :eachSlide :eachIndex |
		aSpace telemetry
			timeSync: [ 'Queue slide {1} to async update' format: { eachIndex } ]
			during: [ eachSlide queueAsyncUpdate: aSpace ] ]
]

{ #category : #accessing }
GtLiveShow >> previousStep [
	self hasPreviousSlide ifFalse: [ ^ self ].
	currentSlide previousStepWith: self.
	self updateCoderElement.
]

{ #category : #accessing }
GtLiveShow >> showSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide
		ifTrue: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	currentSlide := aSlide.
	self updateArrows.
]

{ #category : #accessing }
GtLiveShow >> showSlideAfter: aSlide [
	self showSlide: (self slides at: currentSlide slideIndex + 1)
]

{ #category : #accessing }
GtLiveShow >> showSlideBefore: aSlide [
	self showSlide: (self slides at: currentSlide slideIndex - 1)
]

{ #category : #accessing }
GtLiveShow >> slides [
	^ slides
]

{ #category : #accessing }
GtLiveShow >> slides: anObject [
	slides := anObject
]

{ #category : #accessing }
GtLiveShow >> slidesContainer [

	^slidesContainer
]

{ #category : #accessing }
GtLiveShow >> slidesDropdown [
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
				addChild:
					(each asPreviewElement
						when: BlClickEvent
						do: [ :e | self showSlide: each ]) ].
	previewsContainer := container.
	^ dropdown := BrButton new
		constraintsDo: [:c |
			c frame horizontal alignRight.
			c frame vertical alignCenter];
		margin: (BlInsets all: 10);
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Slides';
		look: 
			BrGlamorousButtonWithIconLook
			+ (BrGlamorousWithDropdownLook
				handle: [ BrButton new
						look: BrGlamorousButtonWithIconLook 
							- BrGlamorousButtonWithLabelTooltipLook
							- BrGlamorousButtonExteriorLook;
						icon: BrGlamorousIcons hamburger asElement;
						yourself ]
				content: [ | el |
					aToolbar := BrToolbar new.
					aToolbar look: BrGlamorousToolbarLook.
					aToolbar
						addItem:
							(BrToggle new
								beSmall;
								look: BrGlamorousButtonWithIconLook + BrGlamorousToggleBackgroundLook;
								icon: BrGlamorousIcons edit asElement;
								label: 'Update arrows' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent | 
									arrowsAreVisible := true.
									self updateArrows ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent | 
									arrowsAreVisible := false.
									self updateArrows ]);
						addItem:
							(BrButton new
								beSmall;
								look: BrGlamorousButtonWithIconLook;
								label: 'Export slides' asString;
								icon: BrGlamorousIcons save asElement;
								action: [ self exportSlides ]);
						addItem:
							(BrButton new
								beSmall;
								look: BrGlamorousButtonWithIconLook;
								label: 'Browse slide method' asString;
								icon: BrGlamorousIcons browse asElement;
								action: [ self changeCoderElementState ]);
						addItem:
							(BrButton new
								beSmall;
								look: BrGlamorousButtonWithIconLook;
								label: 'Add new slide' asString;
								icon: BrGlamorousIcons add asElement;
								action: [ self createNewEmptySlide ]).
					el := BlElement new
						size: 700 @ 520;
						layout: BlLinearLayout vertical;
						addChild: container asScrollableElement;
						addChild: aToolbar.
					el ]);
			constraintsDo: [ :c | c linear horizontal alignRight ];
			padding: (BlInsets all: 10);
			yourself.
]

{ #category : #accessing }
GtLiveShow >> title [
	^ title ifNil: [ 'Gt Slide Show' ]
]

{ #category : #accessing }
GtLiveShow >> title: anObject [
	title := anObject.
]

{ #category : #accessing }
GtLiveShow >> updateArrows [
	(arrowsAreVisible and: [ self hasPreviousSlide ])
		ifTrue: [ previousArrow visibility: BlVisibility visible ]
		ifFalse: [ previousArrow visibility: BlVisibility hidden ].
	(arrowsAreVisible and: [ self hasNextSlide ])
		ifTrue: [ nextArrow visibility: BlVisibility visible ]
		ifFalse: [ nextArrow visibility: BlVisibility hidden ]
]

{ #category : #accessing }
GtLiveShow >> updateCoderElement [
	coderElementState := false.
	coderElement children ifNotEmpty: [coderElement removeChildren].
	coderElement
		addChild: ((GtMethodCoder new 
			forMethod: (self slides at: self currentSlideIndex) definingMethod;
			expanded: true;
			asElement)
				vMatchParent;
				hMatchParent;
				margin: (BlInsets top: 5 right: 10 bottom: 5 left: 10));
		visibility: BlVisibility gone.
]

{ #category : #accessing }
GtLiveShow >> updateSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide ifFalse: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	self updateArrows.
]
