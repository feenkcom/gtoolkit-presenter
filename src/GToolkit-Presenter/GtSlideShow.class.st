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

	container := BlElement new.
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
		background: ((Color fromHexString: #BDBDBD) alpha: 0.5).
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
		background: ((Color fromHexString: #BDBDBD) alpha: 0.5).
	nextElement addChild: nextArrow.
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideIndex: index;
			queueCacheElementIn: self ].
	self showSlide: self slides first.
	container addChild: slidesContainer.
	container addChild: self slidesDropdown.
	
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
GtSlideShow >> gtSlidesFor: aView [
	<gtView>
	^ aView list 
		title: 'Slides';
		items: [ self slides ];
		itemFormat: #name
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

{ #category : #'api - instantiation' }
GtSlideShow >> openInSpace [ 
	| space |
	space := BlSpace new.
	space extent: 800@500.
	space title: self title.
	space root addChild: self asElement.
	space root addShortcut: (BlShortcut new 
		repeatable: false;
		combination: (BlSingleKeyCombination new key: BlKeyboardKey pageDown);
			action: [ self nextStep ]).
	space root addShortcut: (BlShortcut new 
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
				
	dropdown := BrDropdown new.
	container := BlElement new.
	container 
				layout: BlFlowLayout new;
				constraintsDo: [:c |
					c vertical fitContent. c horizontal matchParent ];
				padding: (BlInsets all: 10).
	self slides do: [ :each |
		container addChild: (each asPreviewElement
			when: BlClickEvent do: [:e | self showSlide: each]) ].
	previewsContainer := container.
	^ dropdown
		constraintsDo: [ :c | c linear horizontal alignRight ];
		padding: (BlInsets all: 10);
		toggle: [
			BrButton new
				look: BrGlamorousButtonWithIconLook + BrGlamorousDropdownToggleLook;
				icon: (BrGlamorousIcons hamburger asElement) ];
		popup: [ | el |
			aToolbar := BrToolbar new.
			aToolbar look: BrGlamorousToolbarLook.

			aToolbar addItem: (BrToggle new 
					beSmall;
					look: BrGlamorousButtonWithIconLook + BrGlamorousToggleBackgroundLook;
					icon: (BrGlamorousIcons edit asElement);
					when: BrToggleActivatedEvent do: [ :anEvent | 
						arrowsAreVisible := true.
						self updateArrows.
						 ];
					when: BrToggleDeactivatedEvent do: [ :anEvent | 
						arrowsAreVisible := false.
						self updateArrows. ]).
			el := BlElement new 
				size: 400@250;
				layout: BlLinearLayout vertical;
				addChild: (container asScrollableElement);
				addChild: aToolbar.
			el
			  ];
		look: BrGlamorousDropdownLook new
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
